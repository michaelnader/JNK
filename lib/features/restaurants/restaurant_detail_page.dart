import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/constants.dart';
import '../../data/mock/mock_restaurants.dart';
import '../../shared/widgets/cards.dart';
import '../../shared/widgets/cta.dart';
import '../../shared/widgets/scene.dart';
import '../../shared/widgets/text.dart';
import '../../shared/widgets/top_bar.dart';

class RestaurantDetailPage extends StatelessWidget {
  const RestaurantDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final r = restaurantById(id);
    return Scaffold(
      body: AppScene(
        tone: SceneTone.photo,
        photoAsset: r.photoAsset,
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TopBar(
                  left: RoundBtn(
                    dark: true,
                    onTap: () => context.pop(),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 16,
                      color: AppColors.textWhite,
                    ),
                  ),
                  right: const [
                    RoundBtn(
                      dark: true,
                      child: Icon(
                        Icons.favorite,
                        size: 16,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 80,
                left: 24,
                right: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Lbl(r.tag, color: Colors.white.withValues(alpha: 0.7)),
                    const SizedBox(height: 6),
                    Headline('${r.name}.', size: 56, dark: true),
                  ],
                ),
              ),

              Positioned(
                left: 20,
                right: 20,
                bottom: 24,
                child: CardLight(
                  padding: const EdgeInsets.all(22),
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
                                  value: '98%',
                                  label: 'booked tonight',
                                  icon: Icons.calendar_today_outlined,
                                ),
                                SizedBox(height: 18),
                                StatLine(
                                  value: 'On',
                                  label: 'open · 6–11 PM',
                                  icon: Icons.wifi_rounded,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 110,
                            height: 130,
                            child: CardPhoto(
                              photoAsset: r.photoAsset,
                              padding: const EdgeInsets.all(12),
                              radius: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Lbl(
                                    r.name.toUpperCase(),
                                    color: Colors.white
                                        .withValues(alpha: 0.85),
                                    size: 10,
                                    uppercase: true,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 11,
                                        color: AppColors.gold,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '4.8',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textWhite,
                                        ),
                                      ),
                                    ],
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
                          Expanded(
                            child: CardDark(
                              padding: const EdgeInsets.all(14),
                              radius: 22,
                              child: Row(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: const BoxDecoration(
                                      color: AppColors.gold,
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.vpn_key_outlined,
                                      size: 14,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Lbl(
                                        'From',
                                        color: AppColors.textMuteDark,
                                        size: 10,
                                      ),
                                      Text(
                                        'EGP ${r.deposit}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textWhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CardDark(
                              padding: const EdgeInsets.all(14),
                              radius: 22,
                              child: Row(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.calendar_today_outlined,
                                      size: 14,
                                      color: AppColors.textWhite,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Lbl(
                                        'Today',
                                        color: AppColors.textMuteDark,
                                        size: 10,
                                      ),
                                      Text(
                                        '14 left',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textWhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CTAGold(
                          label: 'Reserve a table',
                          onTap: () => context.push('/restaurants/$id/book'),
                        ),
                      ),
                    ],
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
