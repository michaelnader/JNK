import 'package:flutter/material.dart';

import '../../app/constants.dart';

/// The Aqara-style "Start ›››" pill — outer pill with an inner arrow disc.
///
/// `dark=false` → cream pill with a true-black inner disc.
/// `dark=true`  → true-black pill with a cream inner disc.
class CTAStart extends StatelessWidget {
  const CTAStart({
    super.key,
    required this.label,
    this.dark = false,
    this.onTap,
  });

  final String label;
  final bool dark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bg = dark ? AppColors.trueBlack : AppColors.softCream;
    final fg = dark ? AppColors.textWhite : AppColors.textDark;
    final innerBg = dark ? AppColors.softCream : AppColors.trueBlack;
    final innerFg = dark ? AppColors.textDark : AppColors.textWhite;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 52,
        constraints: const BoxConstraints(minWidth: 120),
        padding: const EdgeInsets.fromLTRB(22, 4, 4, 4),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppRadii.pill),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: dark ? 0.20 : 0.12),
              blurRadius: 22,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: fg,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(width: 16),
            _ArrowDisc(bg: innerBg, fg: innerFg),
          ],
        ),
      ),
    );
  }
}

/// Denim-gradient pill + dark inner arrow disc.
class CTAGold extends StatelessWidget {
  const CTAGold({super.key, required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 52,
        constraints: const BoxConstraints(minWidth: 120),
        padding: const EdgeInsets.fromLTRB(22, 4, 4, 4),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.goldLight, AppColors.gold],
          ),
          borderRadius: BorderRadius.circular(AppRadii.pill),
          boxShadow: [
            BoxShadow(
              color: AppColors.goldDeep.withValues(alpha: 0.30),
              blurRadius: 22,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(width: 16),
            const _ArrowDisc(bg: AppColors.trueBlack, fg: AppColors.textWhite),
          ],
        ),
      ),
    );
  }
}

class _ArrowDisc extends StatelessWidget {
  const _ArrowDisc({required this.bg, required this.fg});

  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        '›››',
        style: TextStyle(
          color: fg,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 2,
          height: 1,
        ),
      ),
    );
  }
}
