import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/constants.dart';
import '../../data/mock/mock_restaurants.dart';
import '../../data/models/restaurant.dart';
import '../../shared/widgets/avatar.dart';
import '../../shared/widgets/cards.dart';
import '../../shared/widgets/chip.dart';
import '../../shared/widgets/scene.dart';
import '../../shared/widgets/tab_bar.dart';
import '../../shared/widgets/text.dart';
import '../../shared/widgets/top_bar.dart';

class RestaurantsPage extends StatelessWidget {
  const RestaurantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppScene(
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TopBar(
                  left: RoundBtn(
                    onTap: () => context.go('/'),
                    child: const Icon(Icons.arrow_back_ios_new, size: 16),
                  ),
                  right: [
                    RoundBtn(child: const Icon(Icons.search, size: 18)),
                  ],
                ),
              ),
              Positioned(
                top: 70,
                left: 24,
                right: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Headline('Restaurants', size: 42),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: const [
                        OffChip(label: 'All · 6', active: true),
                        OffChip(label: 'Cairo'),
                        OffChip(label: 'Sahel'),
                        OffChip(label: 'Red Sea'),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 210,
                left: 20,
                right: 20,
                bottom: 100,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: mockRestaurants.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final r = mockRestaurants[i];
                    final variant = i == 0
                        ? _RowVariant.photo
                        : (i.isOdd ? _RowVariant.dark : _RowVariant.light);
                    return _RestRow(
                      r: r,
                      variant: variant,
                      onTap: () => context.push('/restaurants/${r.id}'),
                    );
                  },
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 22,
                child: OffTabBar(
                  active: NavTab.feed,
                  onTap: (t) {
                    if (t == NavTab.home) context.go('/');
                    if (t == NavTab.reservations) context.go('/reservations');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _RowVariant { photo, dark, light }

class _RestRow extends StatelessWidget {
  const _RestRow({required this.r, required this.variant, this.onTap});

  final Restaurant r;
  final _RowVariant variant;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (variant) {
      case _RowVariant.dark:
        body = CardDark(
          padding: const EdgeInsets.all(14),
          child: _content(dark: true),
        );
      case _RowVariant.photo:
        body = CardPhoto(
          photoAsset: r.photoAsset,
          padding: const EdgeInsets.all(14),
          child: _content(dark: true, photo: true),
        );
      case _RowVariant.light:
        body = CardLight(
          padding: const EdgeInsets.all(14),
          child: _content(dark: false),
        );
    }
    return GestureDetector(onTap: onTap, child: body);
  }

  Widget _content({required bool dark, bool photo = false}) {
    final fg = dark ? AppColors.textWhite : AppColors.textDark;
    final mute = dark ? AppColors.textMuteDark : AppColors.textMuteLight;
    return Row(
      children: [
        if (!photo) Avatar(photoAsset: r.photoAsset, size: 52, ring: true),
        if (photo) const SizedBox(width: 4),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                r.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: fg,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 2),
              Lbl(r.tag, color: mute),
            ],
          ),
        ),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: dark ? AppColors.gold : AppColors.trueBlack,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.arrow_forward,
            size: 14,
            color: dark ? AppColors.textDark : AppColors.textWhite,
          ),
        ),
      ],
    );
  }
}
