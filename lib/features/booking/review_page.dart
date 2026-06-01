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

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final form = context.watch<BookingCubit>().state;
    final r = restaurantById(form.restaurantId);
    final total = r.deposit * form.guestCount;
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
                  title: const Text('Step 4 of 4'),
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
                child: Headline('Your\nbooking.', size: 42, dark: true),
              ),

              Positioned(
                top: 220,
                left: 20,
                right: 20,
                height: 170,
                child: CardPhoto(
                  photoAsset: r.photoAsset,
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  'RESTAURANT',
                                  color: Colors.white
                                      .withValues(alpha: 0.8),
                                  size: 11,
                                  uppercase: true,
                                ),
                                Headline(r.name, size: 28, dark: true),
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
                      Lbl(
                        'FRI 14 NOV · ${form.time ?? "20:30"} · ${form.guestCount} GUESTS',
                        color: Colors.white.withValues(alpha: 0.8),
                        size: 11,
                        uppercase: true,
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 410,
                left: 20,
                right: 20,
                child: CardLight(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      _ReviewRow(
                        label: 'Occasion',
                        value:
                            '${form.occasion ?? "Anniversary"} · ${form.dietary.isEmpty ? "Pescatarian" : form.dietary.join(", ")}',
                      ),
                      const _Divider(),
                      const _ReviewRow(
                        label: 'Note',
                        value: 'Quiet corner, cake at the end',
                      ),
                      const _Divider(),
                      const _ReviewRow(
                        label: 'Cancellation',
                        value: 'Free until 24h before',
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 568,
                left: 20,
                right: 20,
                child: CardGold(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Lbl(
                              'Refundable deposit',
                              color: Colors.black.withValues(alpha: 0.65),
                              size: 11,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'EGP $total',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.5,
                                color: AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: AppColors.trueBlack,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: AppColors.textWhite,
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
                    label: 'Continue to payment',
                    onTap: () => context.push('/payment'),
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

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        children: [
          Lbl(label),
          const Spacer(),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
                letterSpacing: -0.1,
              ),
            ),
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
