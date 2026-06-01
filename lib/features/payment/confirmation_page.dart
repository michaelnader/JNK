import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/constants.dart';
import '../../data/mock/mock_restaurants.dart';
import '../../shared/widgets/avatar.dart';
import '../../shared/widgets/cards.dart';
import '../../shared/widgets/cta.dart';
import '../../shared/widgets/scene.dart';
import '../../shared/widgets/text.dart';
import '../../shared/widgets/top_bar.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final r = mockRestaurants[0]; // Stanley
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
                    onTap: () => context.go('/'),
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
                        Icons.download_outlined,
                        size: 16,
                        color: AppColors.textWhite,
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
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.gold,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.goldDeep.withValues(alpha: 0.40),
                            blurRadius: 30,
                            offset: const Offset(0, 14),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.check_rounded,
                        size: 36,
                        color: AppColors.textDark,
                        weight: 800,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Lbl(
                      'Confirmation sent to ahmed@email.com',
                      color: Colors.white.withValues(alpha: 0.75),
                    ),
                    const SizedBox(height: 12),
                    const Headline("You're in.", size: 50, dark: true),
                  ],
                ),
              ),

              Positioned(
                left: 20,
                right: 20,
                bottom: 24,
                child: CardLight(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Avatar(photoAsset: r.photoAsset, size: 52, ring: true),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  r.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                Lbl(r.tag),
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
                              borderRadius:
                                  BorderRadius.circular(AppRadii.pill),
                            ),
                            child: const Text(
                              'GNK-A4F92K',
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
                      const SizedBox(height: 16),
                      Container(
                        height: 1,
                        color: AppColors.divLight,
                      ),
                      const SizedBox(height: 14),
                      const Row(
                        children: [
                          Expanded(
                            child: MiniStat(label: 'Date', value: 'Fri 14 Nov'),
                          ),
                          Expanded(
                            child: MiniStat(label: 'Time', value: '20:30'),
                          ),
                          Expanded(
                            child: MiniStat(label: 'Guests', value: '04'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const _Qr(),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Show on arrival',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Lbl('Or just give your name.'),
                              ],
                            ),
                          ),
                          CTAStart(label: 'Wallet', dark: true),
                        ],
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

class _Qr extends StatelessWidget {
  const _Qr();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.trueBlack,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          childAspectRatio: 1,
        ),
        itemCount: 49,
        itemBuilder: (_, i) {
          final x = i % 7;
          final y = i ~/ 7;
          final inCorner =
              (x < 2 && y < 2) || (x > 4 && y < 2) || (x < 2 && y > 4);
          final on = inCorner || (x * 31 + y * 17 + 5) % 7 < 3;
          return Container(color: on ? AppColors.gold : AppColors.trueBlack);
        },
      ),
    );
  }
}
