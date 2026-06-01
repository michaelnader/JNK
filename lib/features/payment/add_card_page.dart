import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/constants.dart';
import '../../shared/widgets/cards.dart';
import '../../shared/widgets/cta.dart';
import '../../shared/widgets/scene.dart';
import '../../shared/widgets/text.dart';
import '../../shared/widgets/top_bar.dart';

class AddCardPage extends StatelessWidget {
  const AddCardPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  title: const Text('Add a card'),
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
              const Positioned(
                top: 70,
                left: 24,
                right: 24,
                child: Headline('New card.', size: 36, dark: true),
              ),

              // Card preview
              Positioned(
                top: 150,
                left: 20,
                right: 20,
                height: 170,
                child: CardDark(
                  padding: const EdgeInsets.all(22),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // gold glow blob
                      Positioned(
                        top: -60,
                        right: -60,
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: [
                                AppColors.gold.withValues(alpha: 0.5),
                                Colors.transparent,
                              ],
                              stops: const [0, 0.6],
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              CircleAvatar(
                                radius: 5,
                                backgroundColor: AppColors.gold,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "G'NK",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textWhite,
                                  letterSpacing: -0.2,
                                ),
                              ),
                              Spacer(),
                              Lbl(
                                'DEBIT',
                                color: AppColors.textMuteDark,
                                size: 10,
                                uppercase: true,
                              ),
                            ],
                          ),
                          const SizedBox(height: 28),
                          const Text(
                            '4242  1234  ••••',
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.textWhite,
                              letterSpacing: 2.5,
                              fontFamily: 'monospace',
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Lbl(
                                    'NAME',
                                    color: AppColors.textMuteDark,
                                    size: 9,
                                    uppercase: true,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'AHMED SALEH',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textWhite,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Lbl(
                                    'EXPIRES',
                                    color: AppColors.textMuteDark,
                                    size: 9,
                                    uppercase: true,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '09 / 28',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textWhite,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 340,
                left: 20,
                right: 20,
                child: CardLight(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      _Field(
                        label: 'Card number',
                        value: '4242 1234 ••••',
                        focused: true,
                      ),
                      _Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: AppColors.divLight),
                                ),
                              ),
                              child: _Field(label: 'Expires', value: '09 / 28'),
                            ),
                          ),
                          Expanded(
                            child: _Field(label: 'CVV', value: '•••'),
                          ),
                        ],
                      ),
                      _Divider(),
                      _Field(label: 'Name on card', value: 'Ahmed Saleh'),
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
                    label: 'Save · Pay EGP 1,000',
                    onTap: () => context.go('/confirmation'),
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

class _Field extends StatelessWidget {
  const _Field({required this.label, required this.value, this.focused = false});

  final String label;
  final String value;
  final bool focused;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Lbl(label, size: 10, uppercase: true),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
              if (focused) ...[
                const SizedBox(width: 3),
                Container(width: 1.5, height: 14, color: AppColors.gold),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) =>
      Container(height: 1, color: AppColors.divLight);
}
