import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/constants.dart';
import '../../data/mock/mock_restaurants.dart';
import '../../shared/widgets/avatar.dart';
import '../../shared/widgets/cards.dart';
import '../../shared/widgets/chip.dart';
import '../../shared/widgets/cta.dart';
import '../../shared/widgets/scene.dart';
import '../../shared/widgets/tab_bar.dart';
import '../../shared/widgets/text.dart';
import '../../shared/widgets/top_bar.dart';

class MyReservationsPage extends StatelessWidget {
  const MyReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final stanley = restaurantById('stanley');
    final kikis = restaurantById('kikis');
    final sax = restaurantById('sax');
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
                    const Lbl('9 bookings across G’nK'),
                    const SizedBox(height: 6),
                    const Headline('Reservations', size: 42),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: const [
                        OffChip(label: 'Upcoming · 2', active: true, gold: true),
                        OffChip(label: 'Past · 7'),
                        OffChip(label: 'Cancelled'),
                      ],
                    ),
                  ],
                ),
              ),

              // Hero upcoming
              Positioned(
                top: 250,
                left: 20,
                right: 20,
                height: 170,
                child: CardPhoto(
                  photoAsset: stanley.photoAsset,
                  padding: const EdgeInsets.all(18),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Lbl(
                                      'IN 2 DAYS',
                                      color: Colors.white
                                          .withValues(alpha: 0.85),
                                      size: 10,
                                      uppercase: true,
                                    ),
                                    const SizedBox(height: 6),
                                    const Headline(
                                      'Stanley',
                                      size: 32,
                                      dark: true,
                                    ),
                                    const SizedBox(height: 4),
                                    Lbl(
                                      'Fri 14 Nov · 20:30 · 4 guests',
                                      color: Colors.white
                                          .withValues(alpha: 0.85),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.gold,
                                  borderRadius:
                                      BorderRadius.circular(AppRadii.pill),
                                ),
                                child: const Text(
                                  'CONFIRMED',
                                  style: TextStyle(
                                    color: AppColors.textDark,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Positioned(
                        right: 0,
                        bottom: 0,
                        child: CTAStart(label: 'View'),
                      ),
                    ],
                  ),
                ),
              ),

              // Second upcoming — KIKI's Beach
              Positioned(
                top: 436,
                left: 20,
                right: 20,
                child: CardLight(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Avatar(photoAsset: kikis.photoAsset, size: 52, ring: true),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "KIKI's Beach",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.2,
                              ),
                            ),
                            Lbl('Sat 22 Nov · 14:00 · cabana for 6'),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.trueBlack,
                          borderRadius: BorderRadius.circular(AppRadii.pill),
                        ),
                        child: const Text(
                          'CONFIRMED',
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Past — Sax
              Positioned(
                top: 540,
                left: 20,
                right: 20,
                child: CardDark(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Avatar(photoAsset: sax.photoAsset, size: 44),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sax',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textWhite,
                              ),
                            ),
                            Lbl('Thu 6 Nov · past', color: AppColors.textMuteDark),
                          ],
                        ),
                      ),
                      const Lbl(
                        'VIEW',
                        color: AppColors.textMuteDark,
                        size: 10,
                        uppercase: true,
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 22,
                child: OffTabBar(
                  active: NavTab.reservations,
                  onTap: (t) {
                    if (t == NavTab.home) context.go('/');
                    if (t == NavTab.feed) context.go('/restaurants');
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
