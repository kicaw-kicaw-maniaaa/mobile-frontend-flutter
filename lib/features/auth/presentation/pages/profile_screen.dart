import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<String, bool> _preferences = {
    'Critical Alerts': true,
    'Zone Updates': true,
    'System Logs': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceContainer.withAlpha(200),
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            const Icon(Icons.shield, color: AppColors.accentCyan),
            const SizedBox(width: 8),
            Text(
              'SPATAGUARD',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.accentCyan,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.borderMuted, height: 1),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surfaceMain.withAlpha(204),
              border: Border.all(color: AppColors.borderMuted),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.accentCyan.withAlpha(128), width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accentCyan.withAlpha(50),
                            blurRadius: 20,
                          ),
                        ],
                        color: AppColors.surfaceVariant,
                      ),
                      child: const Icon(Icons.person, size: 40, color: AppColors.textSecondary),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.safeGreen.withAlpha(50),
                              border: Border.all(color: AppColors.safeGreen.withAlpha(76)),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: AppColors.safeGreen,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Status: Online',
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.safeGreen,
                                    fontFamily: 'Space Grotesk',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Operator K-9',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.badge, size: 16, color: AppColors.textSecondary),
                              const SizedBox(width: 4),
                              Text(
                                'ID: SPG-8842-X',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontFamily: 'Space Grotesk',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 16, color: AppColors.textSecondary),
                              const SizedBox(width: 4),
                              Text(
                                'Sector: Alpha-Prime',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontFamily: 'Space Grotesk',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Edit Profile'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentCyan,
                      foregroundColor: AppColors.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => context.push('/profile/history'),
                    icon: const Icon(Icons.history, size: 18),
                    label: const Text('View Report History'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.accentCyan,
                      side: const BorderSide(color: AppColors.accentCyan),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Notification Preferences
          _buildSectionCard(
            context,
            icon: Icons.notifications_active,
            title: 'Notification Preferences',
            children: [
              _buildToggleItem(context, 'Critical Alerts', 'Immediate spatial breaches.'),
              _buildToggleItem(context, 'Zone Updates', 'Changes in layer statuses.'),
              _buildToggleItem(context, 'System Logs', 'Routine maintenance reports.'),
            ],
          ),
          const SizedBox(height: 24),

          // Connected Devices
          _buildSectionCard(
            context,
            icon: Icons.devices,
            title: 'Connected Devices',
            children: [
              _buildDeviceItem(context, Icons.desktop_windows, 'Command Terminal Alpha', 'Active Now', true),
              _buildDeviceItem(context, Icons.smartphone, 'Mobile Uplink X', 'Last sync: 2h ago', false),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Pair New Device'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.accentCyan,
                  side: const BorderSide(color: AppColors.accentCyan),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Security Protocols
          _buildSectionCard(
            context,
            icon: Icons.admin_panel_settings,
            title: 'Security Protocols',
            children: [
              _buildActionItem(context, Icons.password, 'Access Key', 'Update encryption hash.', AppColors.accentCyan),
              _buildActionItem(context, Icons.fingerprint, 'Biometrics', 'Manage spatial identity.', AppColors.accentCyan),
              _buildActionItem(context, Icons.power_settings_new, 'Terminate Session', 'Log out of all nodes.', AppColors.dangerRose, onTap: () {
                context.go('/login');
              }),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context, {required IconData icon, required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceMain.withAlpha(204),
        border: Border.all(color: AppColors.borderMuted),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.accentCyan, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.borderMuted, height: 1),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildToggleItem(BuildContext context, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontFamily: 'Space Grotesk',
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _preferences[title] ?? false,
            onChanged: (val) {
              setState(() {
                _preferences[title] = val;
              });
            },
            activeThumbColor: AppColors.accentCyan,
            activeTrackColor: AppColors.accentCyan.withAlpha(100),
            inactiveThumbColor: AppColors.textSecondary,
            inactiveTrackColor: AppColors.surfaceVariant,
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceItem(BuildContext context, IconData icon, String title, String subtitle, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer.withAlpha(128),
        border: Border.all(color: AppColors.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontFamily: 'Space Grotesk',
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isActive ? AppColors.safeGreen : AppColors.textSecondary,
                    fontFamily: 'Space Grotesk',
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.link_off, color: AppColors.dangerRose),
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(4),
              minimumSize: const Size(32, 32),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, IconData icon, String title, String subtitle, Color color, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer.withAlpha(128),
          border: Border.all(color: color == AppColors.dangerRose ? color.withAlpha(76) : AppColors.outlineVariant),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: color == AppColors.dangerRose ? color : AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontFamily: 'Space Grotesk',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
