import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../app/constants.dart';
import '../../shared/widgets/cards.dart';
import '../../shared/widgets/chip.dart';
import '../../shared/widgets/cta.dart';
import '../../shared/widgets/scene.dart';
import '../../shared/widgets/text.dart';
import '../../shared/widgets/top_bar.dart';
import 'booking_cubit.dart';

class OccasionPage extends StatelessWidget {
  const OccasionPage({super.key});

  static const _opts = [
    'Birthday',
    'Anniversary',
    'Date night',
    'Business',
    'Celebration',
    'Just because',
  ];
  static const _diet = ['Vegetarian', 'Pescatarian', 'Gluten-free'];

  @override
  Widget build(BuildContext context) {
    final form = context.watch<BookingCubit>().state;
    final occasion = form.occasion ?? 'Anniversary';
    final dietary = form.dietary.isEmpty ? {'Pescatarian'} : form.dietary;
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
                  title: const Text('Step 3 of 4'),
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
                      'Optional · helps us prepare',
                      color: Colors.white.withValues(alpha: 0.65),
                    ),
                    const SizedBox(height: 6),
                    const Headline('A bit\nmore.', size: 42, dark: true),
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
                      const Lbl('Occasion'),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          for (final o in _opts)
                            OffChip(
                              label: o,
                              active: o == occasion,
                              gold: o == occasion,
                              onTap: () =>
                                  context.read<BookingCubit>().setOccasion(o),
                            ),
                        ],
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
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Lbl('Special request'),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: AppColors.textDark,
                          ),
                          children: [
                            const TextSpan(text: 'Celebrating ten years. '),
                            TextSpan(
                              text:
                                  'A quiet corner table would be perfect, and a cake at the end if it’s possible.',
                              style: const TextStyle(
                                color: AppColors.textMuteLight,
                              ),
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Container(
                                width: 1.5,
                                height: 14,
                                margin: const EdgeInsets.only(left: 2),
                                color: AppColors.gold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 580,
                left: 20,
                right: 20,
                child: CardDark(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Lbl(
                        'Dietary',
                        color: AppColors.textMuteDark,
                        size: 11,
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          for (final d in _diet)
                            OffChip(
                              label: d,
                              dark: true,
                              active: dietary.contains(d),
                              gold: dietary.contains(d),
                              onTap: () {
                                final next = Set<String>.from(dietary);
                                if (next.contains(d)) {
                                  next.remove(d);
                                } else {
                                  next.add(d);
                                }
                                context.read<BookingCubit>().setDietary(next);
                              },
                            ),
                        ],
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
                    label: 'Continue to review',
                    onTap: () {
                      final c = context.read<BookingCubit>();
                      c.setOccasion(occasion);
                      c.setDietary(dietary);
                      context.push('/booking/review');
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
