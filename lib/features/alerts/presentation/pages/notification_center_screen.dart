import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class NotificationCenterScreen extends StatefulWidget {
  const NotificationCenterScreen({super.key});

  @override
  State<NotificationCenterScreen> createState() => _NotificationCenterScreenState();
}

class _NotificationCenterScreenState extends State<NotificationCenterScreen> {
  String _searchQuery = '';
  
  final List<Map<String, dynamic>> _alertsData = [
    {
      'title': 'Critical Flood Level',
      'level': 'BAHAYA',
      'time': '14:22',
      'description': 'Water levels in Sector 4 Alpha have exceeded safe thresholds. Immediate evacuation recommended.',
      'location': 'LAT -6.2088, LNG 106.8456',
      'actionText': 'ACKNOWLEDGE',
      'color': AppColors.dangerRose,
      'icon': Icons.warning,
      'group': 'Hari Ini',
    },
    {
      'title': 'Soil Instability Detected',
      'level': 'SIAGA',
      'time': '11:05',
      'description': 'Minor tremors recorded. Potential landslide risk in Northern Ridge. Deploying drones for assessment.',
      'location': 'SEC-7B NORTHEAST',
      'actionText': 'VIEW MAP',
      'color': AppColors.tertiaryContainer,
      'icon': Icons.landslide,
      'group': 'Hari Ini',
    },
    {
      'title': 'Heavy Rainfall Warning',
      'level': 'WASPADA',
      'time': '08:45',
      'description': 'Precipitation rates exceeding 50mm/hr in District Delta. Monitor drainage systems.',
      'location': 'Resolved automatically',
      'actionText': '',
      'color': AppColors.warningAmber,
      'icon': Icons.water_drop,
      'locationIcon': Icons.history,
      'group': 'Kemarin',
    },
    {
      'title': 'System Integrity Check',
      'level': 'AMAN',
      'time': '02:00',
      'description': 'Routine diagnostics completed successfully. All sensor arrays operating nominally.',
      'location': '',
      'actionText': '',
      'color': AppColors.safeGreen,
      'icon': Icons.verified,
      'opacity': 0.75,
      'group': 'Kemarin',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter logic
    final filteredAlerts = _alertsData.where((alert) {
      final text = '${alert['title']} ${alert['description']} ${alert['level']}'.toLowerCase();
      return text.contains(_searchQuery.toLowerCase());
    }).toList();

    final hariIniAlerts = filteredAlerts.where((a) => a['group'] == 'Hari Ini').toList();
    final kemarinAlerts = filteredAlerts.where((a) => a['group'] == 'Kemarin').toList();

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
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.borderMuted),
              color: AppColors.surfaceMain,
            ),
            child: const Icon(Icons.person, size: 20, color: AppColors.textSecondary),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.borderMuted, height: 1),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header & Filter
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Alerts & Logs',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_list),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.surfaceContainerHigh,
                  foregroundColor: AppColors.textSecondary,
                  side: const BorderSide(color: AppColors.borderMuted),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Search Field
          TextField(
            onChanged: (val) {
              setState(() {
                _searchQuery = val;
              });
            },
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Cari alert...',
              hintStyle: const TextStyle(color: AppColors.textSecondary),
              prefixIcon: const Icon(Icons.search, color: AppColors.accentCyan),
              filled: true,
              fillColor: AppColors.surfaceContainerHigh,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
          const SizedBox(height: 24),

          if (filteredAlerts.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('Tidak ada alert yang sesuai.', style: TextStyle(color: AppColors.textSecondary)),
              ),
            ),

          if (hariIniAlerts.isNotEmpty) ...[
            _buildSectionHeader(context, 'Hari Ini'),
            const SizedBox(height: 12),
            ...hariIniAlerts.map((a) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildAlertCard(
                context,
                title: a['title'],
                level: a['level'],
                time: a['time'],
                description: a['description'],
                location: a['location'],
                actionText: a['actionText'],
                color: a['color'],
                icon: a['icon'],
                locationIcon: a['locationIcon'] ?? Icons.location_on,
                opacity: a['opacity'] ?? 1.0,
              ),
            )),
            const SizedBox(height: 20),
          ],

          if (kemarinAlerts.isNotEmpty) ...[
            _buildSectionHeader(context, 'Kemarin'),
            const SizedBox(height: 12),
            ...kemarinAlerts.map((a) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildAlertCard(
                context,
                title: a['title'],
                level: a['level'],
                time: a['time'],
                description: a['description'],
                location: a['location'],
                actionText: a['actionText'],
                color: a['color'],
                icon: a['icon'],
                locationIcon: a['locationIcon'] ?? Icons.location_on,
                opacity: a['opacity'] ?? 1.0,
              ),
            )),
            const SizedBox(height: 20),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderMuted)),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAlertCard(
    BuildContext context, {
    required String title,
    required String level,
    required String time,
    required String description,
    required String location,
    required String actionText,
    required Color color,
    required IconData icon,
    IconData locationIcon = Icons.location_on,
    double opacity = 1.0,
  }) {
    return Opacity(
      opacity: opacity,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer.withAlpha(204),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withAlpha(76)),
          boxShadow: [
            if (opacity == 1.0)
              BoxShadow(
                color: color.withAlpha(25),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 4,
                child: Container(color: color),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: color.withAlpha(51),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(icon, color: color, size: 20),
                              ),
                              const SizedBox(width: 12),
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
                                      level,
                                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: color,
                                        fontFamily: 'Space Grotesk',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          time,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.textSecondary,
                            fontFamily: 'Space Grotesk',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    if (location.isNotEmpty || actionText.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (location.isNotEmpty)
                            Row(
                              children: [
                                Icon(locationIcon, size: 14, color: AppColors.textSecondary),
                                const SizedBox(width: 4),
                                Text(
                                  location,
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.textSecondary,
                                    fontFamily: 'Space Grotesk',
                                  ),
                                ),
                              ],
                            ),
                          if (actionText.isNotEmpty)
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: color,
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                actionText,
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Space Grotesk',
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
