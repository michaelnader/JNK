import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/constants.dart';
import '../../data/mock/mock_restaurants.dart';
import '../../shared/widgets/cards.dart';
import '../../shared/widgets/cta.dart';
import '../../shared/widgets/scene.dart';
import '../../shared/widgets/tab_bar.dart';
import '../../shared/widgets/text.dart';
import '../../shared/widgets/top_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final feat = mockRestaurants[0]; // Stanley as featured
    return Scaffold(
      body: AppScene(
        tone: SceneTone.photo,
        photoAsset: feat.photoAsset,
        child: SafeArea(
          child: Stack(
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TopBar(
                  left: const Text(
                    "G'NK",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                      color: AppColors.textWhite,
                    ),
                  ),
                  right: [
                    RoundBtn(
                      dark: true,
                      child: const Icon(
                        Icons.notifications_none_rounded,
                        color: AppColors.textWhite,
                      ),
                    ),
                  ],
                ),
              ),

              // Hero block
              Positioned(
                top: 90,
                left: 24,
                right: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Lbl(
                      'Tonight at',
                      color: Colors.white.withValues(alpha: 0.75),
                    ),
                    const SizedBox(height: 6),
                    Headline(
                      '${feat.name}.',
                      size: 56,
                      dark: true,
                      italic: true,
                    ),
                    const SizedBox(height: 8),
                    Lbl(feat.tag, color: Colors.white.withValues(alpha: 0.85)),
                  ],
                ),
              ),

              // Lower stack — status + reserve CTA
              Positioned(
                left: 20,
                right: 20,
                bottom: 110,
                child: CardLight(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StatLine(
                                  value: '14',
                                  label: 'tables tonight',
                                  icon: Icons.calendar_today_outlined,
                                ),
                                SizedBox(height: 14),
                                StatLine(
                                  value: 'On',
                                  label: 'serving · 6–11 PM',
                                  icon: Icons.wifi_rounded,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 110,
                            child: CardDark(
                              padding: const EdgeInsets.all(14),
                              radius: 22,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Lbl(
                                    'From',
                                    color: AppColors.textMuteDark,
                                    size: 10,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'EGP ${feat.deposit}',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.gold,
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  const Lbl(
                                    '/ guest',
                                    color: AppColors.textMuteDark,
                                    size: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              color: AppColors.trueBlack,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.favorite_border,
                              color: AppColors.gold,
                              size: 16,
                            ),
                          ),
                          const Spacer(),
                          CTAStart(
                            label: 'Reserve',
                            dark: true,
                            onTap: () =>
                                context.push('/restaurants/${feat.id}/book'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom tab bar
              Positioned(
                left: 0,
                right: 0,
                bottom: 22,
                child: OffTabBar(
                  active: NavTab.home,
                  onTap: (t) {
                    if (t == NavTab.reservations) context.go('/reservations');
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
