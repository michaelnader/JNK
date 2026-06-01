import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app/constants.dart';
import '../../data/mock/mock_restaurants.dart';
import '../../shared/widgets/cards.dart';
import '../../shared/widgets/cta.dart';
import '../../shared/widgets/scene.dart';
import '../../shared/widgets/text.dart';
import '../../shared/widgets/top_bar.dart';
import 'booking_cubit.dart';

class DatePickerPage extends StatelessWidget {
  const DatePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final form = context.watch<BookingCubit>().state;
    final r = restaurantById(form.restaurantId);
    return Scaffold(
      body: AppScene(
        tone: SceneTone.dark,
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TopBar(
                  titleDark: true,
                  left: RoundBtn(
                    dark: true,
                    onTap: () => context.pop(),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 16,
                      color: AppColors.textWhite,
                    ),
                  ),
                  title: const Text('Step 1 of 4'),
                  right: [
                    RoundBtn(
                      dark: true,
                      onTap: () => context.go('/'),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: AppColors.textWhite,
                      ),
                    ),
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
                    Lbl(
                      '${r.name} · ${form.guestCount} guests',
                      color: Colors.white.withValues(alpha: 0.65),
                    ),
                    const SizedBox(height: 6),
                    const Headline('Choose\na date.', size: 42, dark: true),
                  ],
                ),
              ),

              Positioned(
                top: 230,
                left: 20,
                right: 20,
                child: CardLight(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Lbl('Party size'),
                            SizedBox(height: 2),
                            Text(
                              '4 guests',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RoundBtn(
                        size: 36,
                        onTap: () => context
                            .read<BookingCubit>()
                            .setParty((form.guestCount - 1).clamp(1, 12)),
                        child: const Text('−'),
                      ),
                      const SizedBox(width: 8),
                      RoundBtn(
                        size: 36,
                        onTap: () => context
                            .read<BookingCubit>()
                            .setParty((form.guestCount + 1).clamp(1, 12)),
                        child: const Text('+'),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 330,
                left: 20,
                right: 20,
                child: CardLight(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'November 2025',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          RoundBtn(size: 30, child: const Text('‹')),
                          const SizedBox(width: 6),
                          RoundBtn(size: 30, child: const Text('›')),
                        ],
                      ),
                      const SizedBox(height: 14),
                      const _Calendar(),
                    ],
                  ),
                ),
              ),

              Positioned(
                bottom: 28,
                left: 20,
                right: 20,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CTAGold(
                    label: 'Fri 14 Nov',
                    onTap: () {
                      context
                          .read<BookingCubit>()
                          .setDate(DateTime(2025, 11, 14));
                      context.push('/booking/time');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Calendar extends StatelessWidget {
  const _Calendar();

  @override
  Widget build(BuildContext context) {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    const offset = 5;
    const today = 12;
    const selected = 14;
    final cells = <int?>[];
    for (var i = 0; i < offset; i++) cells.add(null);
    for (var d = 1; d <= 30; d++) cells.add(d);
    while (cells.length < 35) cells.add(null);

    return Column(
      children: [
        Row(
          children: [
            for (final d in days)
              Expanded(
                child: Center(
                  child: Text(
                    d,
                    style: const TextStyle(
                      color: AppColors.textMuteLight,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: cells.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            childAspectRatio: 1,
          ),
          itemBuilder: (_, i) {
            final d = cells[i];
            if (d == null) return const SizedBox();
            final isSel = d == selected;
            final isTod = d == today;
            final isPast = d < today;
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSel
                    ? AppColors.gold
                    : (isTod
                        ? Colors.black.withValues(alpha: 0.07)
                        : Colors.transparent),
              ),
              alignment: Alignment.center,
              child: Text(
                '$d',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                  color: isPast
                      ? AppColors.textFaintLight
                      : AppColors.textDark,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
