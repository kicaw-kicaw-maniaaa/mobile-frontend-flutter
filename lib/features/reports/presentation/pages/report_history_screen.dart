import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class ReportHistoryScreen extends StatelessWidget {
  const ReportHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          Row(
            children: [
              _buildActionButton(context, Icons.filter_list, 'Filter'),
              const SizedBox(width: 8),
              _buildActionButton(context, Icons.sort, 'Date'),
            ],
          ),
          const SizedBox(height: 24),

          // Cards
          _buildReportCard(
            context,
            title: 'Terrain Instability Detected',
            status: 'Pending',
            statusColor: AppColors.warningAmber,
            description: 'Significant soil displacement observed along Sector 7G perimeter scanning grid. Structural integrity of secondary retaining wall may be compromised due to recent hydrological shifts.',
            location: '48°52\'3.9"N 2°19\'59.9"E',
            time: '2023-10-27T14:32:00Z',
            refId: 'REF: RPT-894-ALPHA',
            icon: Icons.landslide,
            showImage: true,
          ),
          const SizedBox(height: 16),
          _buildReportCard(
            context,
            title: 'Hydrological Override',
            status: 'Verified',
            statusColor: AppColors.safeGreen,
            description: 'Water levels in Sub-basement C have exceeded operational thresholds by 14%. Pumps engaged, but drainage velocity is below optimal parameters.',
            time: '2023-10-26T08:15:22Z',
            refId: 'REF: RPT-893-BETA',
            icon: Icons.flood,
          ),
          const SizedBox(height: 16),
          _buildReportCard(
            context,
            title: 'Telemetry Loss',
            status: 'Resolved',
            statusColor: AppColors.textSecondary,
            description: '',
            time: '2023-10-25T22:01:45Z',
            refId: '',
            icon: Icons.sensors_off,
            opacity: 0.7,
          ),
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
                  color: statusColor.withAlpha(200),
                  boxShadow: [
                    BoxShadow(
                      color: statusColor.withAlpha(128),
                      blurRadius: 10,
                    ),
                  ],
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
