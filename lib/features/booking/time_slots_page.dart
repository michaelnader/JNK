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

class TimeSlotsPage extends StatelessWidget {
  const TimeSlotsPage({super.key});

  static const _slots = [
    ['18:00', '18:30', '19:00'],
    ['19:30', '20:00', '20:30'],
    ['21:00', '21:30', '22:00'],
    ['22:30', '23:00', '23:30'],
  ];

  @override
  Widget build(BuildContext context) {
    final form = context.watch<BookingCubit>().state;
    final r = restaurantById(form.restaurantId);
    final picked = form.time ?? '20:30';
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
                  title: const Text('Step 2 of 4'),
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
                      'Fri 14 Nov · ${r.name} · ${form.guestCount} guests',
                      color: Colors.white.withValues(alpha: 0.65),
                    ),
                    const SizedBox(height: 6),
                    const Headline('Pick\na time.', size: 42, dark: true),
                  ],
                ),
              ),

              Positioned(
                top: 240,
                left: 20,
                right: 20,
                child: CardLight(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Lbl('Available tonight'),
                      const SizedBox(height: 12),
                      Column(
                        children: [
                          for (final row in _slots) ...[
                            Row(
                              children: [
                                for (var i = 0; i < row.length; i++) ...[
                                  if (i > 0) const SizedBox(width: 8),
                                  Expanded(
                                    child: _SlotTile(
                                      label: row[i],
                                      selected: row[i] == picked,
                                      onTap: () => context
                                          .read<BookingCubit>()
                                          .setTime(row[i]),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 555,
                left: 20,
                right: 20,
                child: CardDark(
                  padding: const EdgeInsets.all(14),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(
                        color: AppColors.textMuteDark,
                        fontSize: 12,
                      ),
                      children: const [
                        TextSpan(text: 'Tables are held '),
                        TextSpan(
                          text: '15 minutes',
                          style: TextStyle(
                            color: AppColors.gold,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(text: ' past your booking time.'),
                      ],
                    ),
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
                    label: 'Continue · $picked',
                    onTap: () {
                      context.read<BookingCubit>().setTime(picked);
                      context.push('/booking/occasion');
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

class _SlotTile extends StatelessWidget {
  const _SlotTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: selected ? AppColors.gold : AppColors.warmSand,
          borderRadius: BorderRadius.circular(AppRadii.cardTiny),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: 15,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }
}
