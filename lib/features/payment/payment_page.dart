import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/constants.dart';
import '../../shared/widgets/cards.dart';
import '../../shared/widgets/cta.dart';
import '../../shared/widgets/scene.dart';
import '../../shared/widgets/text.dart';
import '../../shared/widgets/top_bar.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

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
                  title: const Text('Payment'),
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
                      'EGP 1,000 · refundable deposit',
                      color: Colors.white.withValues(alpha: 0.65),
                    ),
                    const SizedBox(height: 6),
                    const Headline('How will\nyou pay?', size: 42, dark: true),
                  ],
                ),
              ),

              Positioned(
                top: 240,
                left: 20,
                right: 20,
                child: CardLight(
                  padding: const EdgeInsets.all(6),
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.trueBlack,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.apple,
                          size: 22,
                          color: AppColors.textWhite,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Pay',
                          style: TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 320,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.white.withValues(alpha: 0.12),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Lbl(
                      'OR USE A CARD',
                      color: Colors.white.withValues(alpha: 0.55),
                      size: 11,
                      uppercase: true,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.white.withValues(alpha: 0.12),
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                top: 360,
                left: 20,
                right: 20,
                child: CardLight(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      _PayRow(
                        brand: 'VISA',
                        name: 'Personal',
                        last: '4421',
                        selected: true,
                      ),
                      _Divider(),
                      _PayRow(brand: 'MC', name: 'Business', last: '0392'),
                      _Divider(),
                      InkWell(
                        onTap: () => context.push('/payment/add'),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),
                          child: Row(
                            children: [
                              _AddCircle(),
                              SizedBox(width: 12),
                              Text(
                                'Add a new card',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textDark,
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

              Positioned(
                bottom: 28,
                left: 20,
                right: 20,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CTAGold(
                    label: 'Pay EGP 1,000',
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

class _PayRow extends StatelessWidget {
  const _PayRow({
    required this.brand,
    required this.name,
    required this.last,
    this.selected = false,
  });

  final String brand;
  final String name;
  final String last;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 28,
            decoration: BoxDecoration(
              gradient: brand == 'VISA'
                  ? const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF1A1F71), Color(0xFF2A3F9D)],
                    )
                  : const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF232323), Color(0xFF454545)],
                    ),
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: Text(
              brand,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                Lbl('•••• $last'),
              ],
            ),
          ),
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: selected ? AppColors.gold : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: selected
                    ? AppColors.gold
                    : Colors.black.withValues(alpha: 0.18),
                width: 2,
              ),
            ),
            alignment: Alignment.center,
            child: selected
                ? Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.textDark,
                      shape: BoxShape.circle,
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) => Container(
        height: 1,
        margin: const EdgeInsets.symmetric(horizontal: 18),
        color: AppColors.divLight,
      );
}

class _AddCircle extends StatelessWidget {
  const _AddCircle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: AppColors.gold,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: const Text(
        '+',
        style: TextStyle(
          color: AppColors.textDark,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
