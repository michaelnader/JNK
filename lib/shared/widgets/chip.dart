import 'package:flutter/material.dart';

import '../../app/constants.dart';

/// Pill chip — three active flavours (gold / dark / light) plus an outline
/// rest state. Tone tells the chip whether it sits on a light or dark surface
/// so the outline picks the right divider colour.
class OffChip extends StatelessWidget {
  const OffChip({
    super.key,
    required this.label,
    this.active = false,
    this.dark = false,
    this.gold = false,
    this.onTap,
  });

  final String label;
  final bool active;
  final bool dark;
  final bool gold;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    Color border;
    if (active) {
      if (gold) {
        bg = AppColors.gold;
        fg = AppColors.textDark;
        border = AppColors.gold;
      } else if (dark) {
        bg = AppColors.softCream;
        fg = AppColors.textDark;
        border = AppColors.softCream;
      } else {
        bg = AppColors.trueBlack;
        fg = AppColors.textWhite;
        border = AppColors.trueBlack;
      }
    } else {
      bg = Colors.transparent;
      fg = dark ? AppColors.textMuteDark : AppColors.textMuteLight;
      border = dark ? AppColors.divDark : AppColors.divLight;
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppRadii.chip),
          border: Border.all(color: border, width: 1),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: fg,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.05,
          ),
        ),
      ),
    );
  }
}
