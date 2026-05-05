import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class ReportHistoryScreen extends StatefulWidget {
  const ReportHistoryScreen({super.key});

  @override
  State<ReportHistoryScreen> createState() => _ReportHistoryScreenState();
}

class _ReportHistoryScreenState extends State<ReportHistoryScreen> {
  String _searchQuery = '';

  final List<Map<String, dynamic>> _reportsData = [
    {
      'title': 'Terrain Instability Detected',
      'status': 'Pending',
      'statusColor': AppColors.warningAmber,
      'description': 'Significant soil displacement observed along Sector 7G perimeter scanning grid. Structural integrity of secondary retaining wall may be compromised due to recent hydrological shifts.',
      'location': '48°52\'3.9"N 2°19\'59.9"E',
      'time': '2023-10-27T14:32:00Z',
      'refId': 'REF: RPT-894-ALPHA',
      'icon': Icons.landslide,
      'showImage': true,
    },
    {
      'title': 'Hydrological Override',
      'status': 'Verified',
      'statusColor': AppColors.safeGreen,
      'description': 'Water levels in Sub-basement C have exceeded operational thresholds by 14%. Pumps engaged, but drainage velocity is below optimal parameters.',
      'location': '',
      'time': '2023-10-26T08:15:22Z',
      'refId': 'REF: RPT-893-BETA',
      'icon': Icons.flood,
      'showImage': false,
    },
    {
      'title': 'Telemetry Loss',
      'status': 'Resolved',
      'statusColor': AppColors.textSecondary,
      'description': '',
      'location': '',
      'time': '2023-10-25T22:01:45Z',
      'refId': '',
      'icon': Icons.sensors_off,
      'showImage': false,
      'opacity': 0.7,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredReports = _reportsData.where((r) {
      final text = '${r['title']} ${r['description']} ${r['refId']} ${r['status']}'.toLowerCase();
      return text.contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceContainer.withAlpha(200),
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'System Logs',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.borderMuted, height: 1),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Subtitle and Actions
          Text(
            'Chronological audit of spatial anomalies and user reports.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          // Search Field
          TextField(
            onChanged: (val) {
              setState(() {
                _searchQuery = val;
              });
            },
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Cari laporan...',
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
          const SizedBox(height: 16),
          Row(
            children: [
              _buildActionButton(context, Icons.filter_list, 'Filter'),
              const SizedBox(width: 8),
              _buildActionButton(context, Icons.sort, 'Date'),
            ],
          ),
          const SizedBox(height: 24),

          if (filteredReports.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('Tidak ada laporan yang sesuai.', style: TextStyle(color: AppColors.textSecondary)),
              ),
            ),

          // Cards
          ...filteredReports.map((r) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildReportCard(
              context,
              title: r['title'],
              status: r['status'],
              statusColor: r['statusColor'],
              description: r['description'],
              location: r['location'] ?? '',
              time: r['time'],
              refId: r['refId'] ?? '',
              icon: r['icon'],
              showImage: r['showImage'] ?? false,
              opacity: r['opacity'] ?? 1.0,
            ),
          )),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer.withAlpha(128),
        border: Border.all(color: AppColors.borderMuted),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(
    BuildContext context, {
    required String title,
    required String status,
    required Color statusColor,
    required String description,
    String location = '',
    required String time,
    required String refId,
    required IconData icon,
    bool showImage = false,
    double opacity = 1.0,
  }) {
    return Opacity(
      opacity: opacity,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer.withAlpha(204),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: statusColor.withAlpha(76)),
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
                child: Container(
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(200),
                    boxShadow: [
                      BoxShadow(
                        color: statusColor.withAlpha(128),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
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
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: statusColor.withAlpha(25),
                                  border: Border.all(color: statusColor.withAlpha(50)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(icon, color: statusColor, size: 20),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  title,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(25),
                            border: Border.all(color: statusColor.withAlpha(50)),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              if (status == 'Pending') ...[
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                              ],
                              Text(
                                status.toUpperCase(),
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: statusColor,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (description.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  description,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                if (location.isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.surfaceMain.withAlpha(128),
                                      border: Border.all(color: AppColors.borderMuted),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.my_location, size: 14, color: AppColors.accentCyan),
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
                                  ),
                                ],
                              ],
                            ),
                          ),
                          if (showImage) ...[
                            const SizedBox(width: 12),
                            Container(
                              width: 80,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.borderMuted),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.accentCyan.withAlpha(50),
                                    AppColors.surfaceMain,
                                  ],
                                ),
                              ),
                              child: const Icon(Icons.map, color: AppColors.textSecondary),
                            ),
                          ],
                        ],
                      ),
                    ],
                    const SizedBox(height: 12),
                    const Divider(color: AppColors.borderMuted),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.schedule, size: 16, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              time,
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppColors.textSecondary,
                                fontFamily: 'Space Grotesk',
                              ),
                            ),
                          ],
                        ),
                        if (refId.isNotEmpty)
                          Text(
                            refId,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.accentCyan.withAlpha(128),
                              fontFamily: 'Space Grotesk',
                              letterSpacing: 2.0,
                            ),
                          ),
                      ],
                    ),
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
