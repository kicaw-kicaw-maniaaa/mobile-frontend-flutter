import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class LocationRiskDetailSheet extends StatelessWidget {
  const LocationRiskDetailSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LocationRiskDetailSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer.withAlpha(240),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        border: Border(
          top: BorderSide(color: AppColors.borderMuted, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(150),
            blurRadius: 40,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: 48,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.borderMuted,
              borderRadius: BorderRadius.circular(3),
            ),
            margin: const EdgeInsets.only(bottom: 24),
          ),
          
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SITE ALPHA-7',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Zone Critical Alert',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.warning, color: AppColors.dangerRose, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          'Update Terakhir: 14:03:22 UTC',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.surfaceVariant,
                  foregroundColor: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Risk Score Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceMain.withAlpha(128),
              border: Border.all(color: AppColors.dangerRose.withAlpha(76)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overall Risk Index',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '85',
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              color: AppColors.dangerRose,
                              fontWeight: FontWeight.w900,
                              height: 1.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              '/100',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppColors.dangerRose.withAlpha(178),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        value: 0.85,
                        backgroundColor: AppColors.dangerRose.withAlpha(50),
                        color: AppColors.dangerRose,
                        strokeWidth: 8,
                      ),
                    ),
                    const Icon(
                      Icons.warning,
                      color: AppColors.dangerRose,
                      size: 32,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Contributing Factors
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Contributing Factors',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildFactorItem(
            context,
            icon: Icons.waves,
            iconColor: AppColors.accentCyan,
            title: 'Proximity to River (15m)',
            points: '+40 pts',
            pointsColor: AppColors.accentCyan,
          ),
          const SizedBox(height: 8),
          _buildFactorItem(
            context,
            icon: Icons.terrain,
            iconColor: AppColors.warningAmber,
            title: 'Steep Slope (25°)',
            points: '+30 pts',
            pointsColor: AppColors.warningAmber,
          ),
          const SizedBox(height: 8),
          _buildFactorItem(
            context,
            icon: Icons.history_edu,
            iconColor: AppColors.dangerRose,
            title: 'Historical Flood Zone',
            points: '+15 pts',
            pointsColor: AppColors.dangerRose,
          ),
          const SizedBox(height: 32),

          // Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.directions_run),
              label: const Text('Lihat Jalur Evakuasi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentCyan,
                foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 10,
                shadowColor: AppColors.accentCyan.withAlpha(100),
                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFactorItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String points,
    required Color pointsColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withAlpha(76),
        border: Border.all(color: AppColors.borderMuted),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withAlpha(50),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.info_outline, size: 16, color: AppColors.textSecondary),
              ],
            ),
          ),
          Text(
            points,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: pointsColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
