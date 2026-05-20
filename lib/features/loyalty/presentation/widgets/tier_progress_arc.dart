import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../app/constants.dart';
import '../../../../core/utils/loyalty_calculator.dart';
import '../../../../data/models/user.dart';

class TierProgressArc extends StatelessWidget {
  const TierProgressArc({required this.snapshot, super.key});

  final LoyaltySnapshot snapshot;

  Color _tierColor(LoyaltyTier t) {
    switch (t) {
      case LoyaltyTier.silver:
        return AppColors.tierSilver;
      case LoyaltyTier.gold:
        return AppColors.tierGold;
      case LoyaltyTier.platinum:
        return AppColors.tierPlatinum;
      case LoyaltyTier.obsidian:
        return AppColors.tierObsidian;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _tierColor(snapshot.currentTier);
    return SizedBox(
      width: 240,
      height: 240,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: _ArcPainter(
                progress: snapshot.progressToNext,
                color: color,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                snapshot.currentTier.label.toUpperCase(),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: color,
                  letterSpacing: 4,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '${snapshot.points}',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'POINTS',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.textTertiary,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  _ArcPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.shortestSide / 2) - 16;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..color = AppColors.glassFill;

    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: 2 * math.pi,
        colors: [
          color.withValues(alpha: 0.2),
          color,
          color.withValues(alpha: 0.85),
        ],
      ).createShader(rect);

    // 270° arc — leave a "gap" at the bottom for visual grounding.
    const start = math.pi * 0.75;
    const sweep = math.pi * 1.5;

    canvas.drawArc(rect, start, sweep, false, base);
    canvas.drawArc(rect, start, sweep * progress, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _ArcPainter old) =>
      old.progress != progress || old.color != color;
}
