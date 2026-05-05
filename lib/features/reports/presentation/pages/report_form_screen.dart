import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({super.key});

  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  String? _selectedKejadian;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceContainer.withAlpha(200),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textSecondary),
          onPressed: () {
            // Using GoRouter to go back or to the map tab
            context.go('/map');
          },
        ),
        title: Text(
          'Buat Laporan',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.accentCyan,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.borderMuted,
            height: 1,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tipe Kejadian
                _buildSectionContainer(
                  title: 'Tipe Kejadian',
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.outlineVariant),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedKejadian,
                        isExpanded: true,
                        dropdownColor: AppColors.surfaceContainer,
                        hint: Text(
                          'Pilih jenis kejadian...',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        icon: const Icon(Icons.arrow_drop_down, color: AppColors.textSecondary),
                        items: const [
                          DropdownMenuItem(value: 'infrastruktur', child: Text('Kerusakan Infrastruktur')),
                          DropdownMenuItem(value: 'keamanan', child: Text('Gangguan Keamanan')),
                          DropdownMenuItem(value: 'lingkungan', child: Text('Isu Lingkungan')),
                          DropdownMenuItem(value: 'lainnya', child: Text('Lainnya')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedKejadian = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Deskripsi Singkat
                _buildSectionContainer(
                  title: 'Deskripsi Singkat',
                  child: TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Jelaskan detail kejadian yang Anda amati...',
                      hintStyle: TextStyle(color: AppColors.textSecondary),
                      filled: true,
                      fillColor: AppColors.surfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.outlineVariant),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.outlineVariant),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.accentCyan),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Lokasi Otomatis
                _buildSectionContainer(
                  title: 'Lokasi Otomatis',
                  headerTrailing: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.my_location, size: 16, color: AppColors.accentCyan),
                    label: Text(
                      'Perbarui',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.accentCyan,
                        fontFamily: 'Space Grotesk',
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceDim,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.outlineVariant),
                        ),
                        child: Stack(
                          children: [
                            // Fake map image overlay
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.accentCyan.withAlpha(20),
                                      AppColors.surfaceMain.withAlpha(150),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              left: 8,
                              child: Text(
                                'LAT: -6.2088  LON: 106.8456',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppColors.accentCyan,
                                  fontFamily: 'Space Grotesk',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Jl. Jend. Sudirman Kav. 52-53, Jakarta Selatan',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Bukti Visual
                _buildSectionContainer(
                  title: 'Bukti Visual',
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.outlineVariant,
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // Fake dashed border using solid for now
                      child: Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                    color: AppColors.surfaceVariant,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.photo_camera, size: 32, color: AppColors.textSecondary),
                                ),
                                const SizedBox(width: 16),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                    color: AppColors.surfaceVariant,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.image, size: 32, color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Ketuk untuk Mengunggah',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Mendukung JPG, PNG (Max 5MB)',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Fixed Bottom Action
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer.withAlpha(230),
                border: const Border(top: BorderSide(color: AppColors.borderMuted)),
              ),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.send),
                label: const Text('Kirim Laporan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.warningAmber,
                  foregroundColor: AppColors.onTertiaryContainer,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 10,
                  shadowColor: AppColors.warningAmber.withAlpha(100),
                  textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionContainer({
    required String title,
    Widget? headerTrailing,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer.withAlpha(204), // 80% opacity
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderMuted),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (headerTrailing != null) headerTrailing,
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
