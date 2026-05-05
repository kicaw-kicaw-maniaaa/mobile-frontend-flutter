import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';

class MainNavigationScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainNavigationScreen({
    super.key,
    required this.navigationShell,
  });

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          border: const Border(
            top: BorderSide(color: AppColors.borderMuted, width: 1),
          ),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
          backgroundColor: Colors.transparent,
          indicatorColor: AppColors.accentCyan.withAlpha(50),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.explore_outlined, color: AppColors.textSecondary),
              selectedIcon: Icon(Icons.explore, color: AppColors.accentCyan),
              label: 'Map',
            ),
            NavigationDestination(
              icon: Icon(Icons.add_alert_outlined, color: AppColors.textSecondary),
              selectedIcon: Icon(Icons.add_alert, color: AppColors.warningAmber),
              label: 'Report',
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications_outlined, color: AppColors.textSecondary),
              selectedIcon: Icon(Icons.notifications, color: AppColors.primary),
              label: 'Alerts',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline, color: AppColors.textSecondary),
              selectedIcon: Icon(Icons.person, color: AppColors.accentCyan),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
