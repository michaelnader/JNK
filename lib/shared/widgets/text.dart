import 'package:flutter/material.dart';

import '../../app/constants.dart';

/// Big display headline — Plus Jakarta Sans 600 with proportional letter-spacing.
///
/// Matches the prototype's `Headline5` rule: letter-spacing = `-0.025 * size`.
class Headline extends StatelessWidget {
  const Headline(
    this.text, {
    super.key,
    this.size = 36,
    this.dark = false,
    this.italic = false,
  });

  final String text;
  final double size;
  final bool dark;
  final bool italic;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: size,
        height: 1.05,
        letterSpacing: -0.025 * size,
        color: dark ? AppColors.textWhite : AppColors.textDark,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      ),
    );
  }
}

/// Small muted label.
class Lbl extends StatelessWidget {
  const Lbl(
    this.text, {
    super.key,
    this.color,
    this.size = 12,
    this.weight = FontWeight.w500,
    this.letterSpacing = -0.05,
    this.uppercase = false,
  });

  final String text;
  final Color? color;
  final double size;
  final FontWeight weight;
  final double letterSpacing;
  final bool uppercase;

  @override
  Widget build(BuildContext context) {
    return Text(
      uppercase ? text.toUpperCase() : text,
      style: TextStyle(
        color: color ?? AppColors.textMuteLight,
        fontSize: size,
        fontWeight: uppercase ? FontWeight.w700 : weight,
        letterSpacing: uppercase ? 1.2 : letterSpacing,
      ),
    );
  }
}

/// Big number + label-with-icon below.
class StatLine extends StatelessWidget {
  const StatLine({
    super.key,
    required this.value,
    required this.label,
    this.icon,
    this.dark = false,
  });

  final String value;
  final String label;
  final IconData? icon;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final fg = dark ? AppColors.textWhite : AppColors.textDark;
    final mute = dark ? AppColors.textMuteDark : AppColors.textMuteLight;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            color: fg,
            fontSize: 30,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            height: 1,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 11, color: mute),
              const SizedBox(width: 6),
            ],
            Text(label, style: TextStyle(color: mute, fontSize: 11)),
          ],
        ),
      ],
    );
  }
}

/// Tiny field label + value pair (used in confirmation grids).
class MiniStat extends StatelessWidget {
  const MiniStat({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Lbl(label, size: 10, uppercase: true),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
}
