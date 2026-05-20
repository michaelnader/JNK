import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../app/constants.dart';

/// Helper for showing a frosted bottom sheet with the JNK glass aesthetic.
///
/// Use [GlassModal.show] in place of [showModalBottomSheet] — it auto-applies
/// the obsidian backdrop blur, glass-styled container, drag handle, and
/// optional title.
class GlassModal {
  const GlassModal._();

  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    String? title,
    bool isDismissible = true,
    bool useRootNavigator = true,
    double heightFactor = 0.75,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      useRootNavigator: useRootNavigator,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.obsidianDeep.withValues(alpha: 0.55),
      builder: (sheetContext) {
        return _GlassSheet(
          title: title,
          heightFactor: heightFactor,
          child: builder(sheetContext),
        );
      },
    );
  }
}

class _GlassSheet extends StatelessWidget {
  const _GlassSheet({
    required this.child,
    required this.heightFactor,
    this.title,
  });

  final Widget child;
  final double heightFactor;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    const radius = BorderRadius.vertical(top: Radius.circular(AppRadii.xl2));

    return FractionallySizedBox(
      heightFactor: heightFactor,
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: AppGlass.blurSigma + 6,
            sigmaY: AppGlass.blurSigma + 6,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: radius,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.charcoal.withValues(alpha: 0.92),
                  AppColors.obsidian.withValues(alpha: 0.95),
                ],
              ),
              border: const Border(
                top: BorderSide(color: AppColors.glassBorder),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.only(
                  left: AppSpacing.xl,
                  right: AppSpacing.xl,
                  top: AppSpacing.md,
                  bottom: mq.viewInsets.bottom + AppSpacing.xl,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 44,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.glassBorder,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    if (title != null) ...[
                      const SizedBox(height: AppSpacing.xl),
                      Text(
                        title!,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                    const SizedBox(height: AppSpacing.lg),
                    Flexible(child: child),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
