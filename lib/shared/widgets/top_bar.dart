import 'package:flutter/material.dart';

import '../../app/constants.dart';

/// Floating top bar — left + optional title + right slots. Positioned by the
/// caller (usually inside a Stack with SafeArea top inset honoured).
class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    this.left,
    this.title,
    this.right,
    this.titleDark = false,
  });

  final Widget? left;
  final Widget? title;
  final List<Widget>? right;
  final bool titleDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (left != null) left! else const SizedBox(width: 42, height: 42),
          if (title != null) ...[
            const SizedBox(width: 12),
            Expanded(
              child: Center(
                child: DefaultTextStyle.merge(
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: titleDark
                        ? AppColors.textWhite
                        : AppColors.textDark,
                    letterSpacing: -0.2,
                  ),
                  child: title!,
                ),
              ),
            ),
            const SizedBox(width: 12),
          ] else
            const Spacer(),
          if (right != null)
            Row(
              children: [
                for (var i = 0; i < right!.length; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  right![i],
                ],
              ],
            )
          else
            const SizedBox(width: 42, height: 42),
        ],
      ),
    );
  }
}

/// Circular icon button. Two variants: light (cream) and dark (true black).
class RoundBtn extends StatelessWidget {
  const RoundBtn({
    super.key,
    required this.child,
    this.dark = false,
    this.size = 42,
    this.onTap,
  });

  final Widget child;
  final bool dark;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bg = dark ? AppColors.trueBlack : AppColors.softCream;
    final fg = dark ? AppColors.textWhite : AppColors.textDark;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: dark ? 0.20 : 0.10),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: dark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.white.withValues(alpha: 0.6),
            width: 0.5,
          ),
        ),
        alignment: Alignment.center,
        child: IconTheme.merge(
          data: IconThemeData(color: fg, size: size * 0.42),
          child: DefaultTextStyle.merge(
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.w600,
              fontSize: size * 0.42,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
