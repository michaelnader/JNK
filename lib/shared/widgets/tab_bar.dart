import 'package:flutter/material.dart';

import '../../app/constants.dart';

enum NavTab { home, reservations, feed, me }

/// Floating pill nav with the active tab as a gold circular badge.
class OffTabBar extends StatelessWidget {
  const OffTabBar({
    super.key,
    required this.active,
    required this.onTap,
    this.dark = false,
  });

  final NavTab active;
  final ValueChanged<NavTab> onTap;
  final bool dark;

  static const _items = <(NavTab, IconData)>[
    (NavTab.home, Icons.home_outlined),
    (NavTab.reservations, Icons.calendar_today_outlined),
    (NavTab.feed, Icons.grid_view_outlined),
    (NavTab.me, Icons.person_outline),
  ];

  @override
  Widget build(BuildContext context) {
    final bg = dark ? AppColors.trueBlack : AppColors.softCream;
    final fg = dark ? AppColors.textWhite : AppColors.textDark;
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      height: 58,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: dark ? 0.25 : 0.12),
            blurRadius: 26,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (final (tab, icon) in _items)
            _TabButton(
              icon: icon,
              active: tab == active,
              fg: fg,
              onTap: () => onTap(tab),
            ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.icon,
    required this.active,
    required this.fg,
    required this.onTap,
  });

  final IconData icon;
  final bool active;
  final Color fg;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 42,
        height: 42,
        child: active
            ? Container(
                decoration: const BoxDecoration(
                  color: AppColors.gold,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(icon, size: 18, color: AppColors.textDark),
              )
            : Center(
                child: Icon(
                  icon,
                  size: 18,
                  color: fg.withValues(alpha: 0.65),
                ),
              ),
      ),
    );
  }
}
