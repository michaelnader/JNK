import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/constants.dart';
import '../glass/ambient_background.dart';
import '../glass/glass_nav_bar.dart';

/// Scaffold wrapping every tabbed route — provides the ambient background and
/// the glass bottom nav. The actual page content (the StatefulShellRoute child)
/// stacks above the background.
class AppShell extends StatelessWidget {
  const AppShell({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  static const _navItems = <GlassNavItem>[
    GlassNavItem(
      icon: Icons.dashboard_customize_outlined,
      label: 'Club',
      route: '/dashboard',
    ),
    GlassNavItem(
      icon: Icons.auto_awesome_outlined,
      label: 'Venues',
      route: '/venues',
    ),
    GlassNavItem(
      icon: Icons.diamond_outlined,
      label: 'Loyalty',
      route: '/loyalty',
    ),
    GlassNavItem(
      icon: Icons.mail_outline_rounded,
      label: 'Invites',
      route: '/invites',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AmbientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        body: navigationShell,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(top: AppSpacing.sm),
          child: GlassNavBar(
            items: _navItems,
            currentIndex: navigationShell.currentIndex,
            onTap: (i) => navigationShell.goBranch(
              i,
              initialLocation: i == navigationShell.currentIndex,
            ),
          ),
        ),
      ),
    );
  }
}
