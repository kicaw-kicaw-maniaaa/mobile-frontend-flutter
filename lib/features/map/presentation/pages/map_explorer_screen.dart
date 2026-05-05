import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:ui' as ui;
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/location_risk_detail_sheet.dart';
import 'dart:async';
import 'dart:math';

class MapExplorerScreen extends StatefulWidget {
  const MapExplorerScreen({super.key});

  @override
  State<MapExplorerScreen> createState() => _MapExplorerScreenState();
}

class _MapExplorerScreenState extends State<MapExplorerScreen> {
  final MapController _mapController = MapController();
  Timer? _scanTimer;
  int _secureCount = 12;
  int _criticalCount = 1;

  @override
  void initState() {
    super.initState();
    _startScanSimulation();
  }

  void _startScanSimulation() {
    _scanTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _secureCount = 10 + Random().nextInt(5); // 10 to 14
          _criticalCount = Random().nextInt(3); // 0 to 2
        });
      }
    });
  }

  @override
  void dispose() {
    _scanTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Flutter Map Layer
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(-6.200000, 106.816666), // Jakarta center
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.spataguard.app',
              ),
              // Dummy Zones Polygon Layer
              PolygonLayer(
                polygons: [
                  // Safe Zone
                  Polygon(
                    points: const [
                      LatLng(-6.19, 106.81),
                      LatLng(-6.19, 106.82),
                      LatLng(-6.20, 106.82),
                      LatLng(-6.20, 106.81),
                    ],
                    color: AppColors.safeGreen.withAlpha(50),
                    borderColor: AppColors.safeGreen,
                    borderStrokeWidth: 2,
                  ),
                  // Danger Zone
                  Polygon(
                    points: const [
                      LatLng(-6.21, 106.83),
                      LatLng(-6.21, 106.84),
                      LatLng(-6.22, 106.84),
                      LatLng(-6.22, 106.83),
                    ],
                    color: AppColors.dangerRose.withAlpha(80),
                    borderColor: AppColors.dangerRose,
                    borderStrokeWidth: 2,
                  ),
                ],
              ),
              // Region Markers (Interactive)
              MarkerLayer(
                markers: [
                  // User Location / Region A
                  Marker(
                    point: const LatLng(-6.200000, 106.816666),
                    width: 48,
                    height: 48,
                    child: GestureDetector(
                      onTap: () {
                        LocationRiskDetailSheet.show(context);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.accentCyan.withAlpha(50),
                            ),
                          ),
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.accentCyan.withAlpha(100),
                            ),
                          ),
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.accentCyan,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.accentCyan,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Danger Zone Marker
                  Marker(
                    point: const LatLng(-6.215, 106.835),
                    width: 40,
                    height: 40,
                    child: GestureDetector(
                      onTap: () {
                        LocationRiskDetailSheet.show(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.surfaceMain.withAlpha(200),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.dangerRose),
                          boxShadow: [
                            BoxShadow(color: AppColors.dangerRose.withAlpha(100), blurRadius: 10),
                          ],
                        ),
                        child: const Icon(Icons.warning, color: AppColors.dangerRose, size: 20),
                      ),
                    ),
                  ),
                  // Safe Zone Marker
                  Marker(
                    point: const LatLng(-6.195, 106.815),
                    width: 40,
                    height: 40,
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Kawasan Aman: Tidak ada risiko terdeteksi.'),
                            backgroundColor: AppColors.safeGreen,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.surfaceMain.withAlpha(200),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.safeGreen),
                          boxShadow: [
                            BoxShadow(color: AppColors.safeGreen.withAlpha(100), blurRadius: 10),
                          ],
                        ),
                        child: const Icon(Icons.verified, color: AppColors.safeGreen, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Custom Top App Bar (Glassmorphism)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 100, // Includes safe area
                  padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer.withAlpha(200),
                    border: const Border(
                      bottom: BorderSide(color: AppColors.borderMuted, width: 1),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.shield, color: AppColors.accentCyan),
                            onPressed: () {},
                          ),
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
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.search, color: AppColors.accentCyan),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: AppColors.surfaceMain,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                ),
                                builder: (context) => Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Cari koordinat atau zona...',
                                          hintStyle: TextStyle(color: AppColors.textSecondary),
                                          prefixIcon: const Icon(Icons.search, color: AppColors.accentCyan),
                                          filled: true,
                                          fillColor: AppColors.surfaceContainer,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      const Text('Riwayat Pencarian Kosong', style: TextStyle(color: AppColors.textSecondary)),
                                      const SizedBox(height: 24),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          Container(
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Active Scan Card (Top Right, below AppBar)
          Positioned(
            top: 120,
            right: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer.withAlpha(200),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderMuted),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.radar, color: AppColors.accentCyan, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'Active Scan',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceMain.withAlpha(128),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.borderMuted),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('SECURE', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 8)),
                                  Text('$_secureCount Active', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.safeGreen)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceMain.withAlpha(128),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.borderMuted),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('CRITICAL', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 8)),
                                  Text('$_criticalCount Detected', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: _criticalCount > 0 ? AppColors.dangerRose : AppColors.safeGreen)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Floating Action Button (Add Report)
          Positioned(
            bottom: 24,
            right: 24,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.warningAmber,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.warningAmber.withAlpha(150),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.add, size: 32, color: AppColors.onPrimary),
                onPressed: () {
                  context.go('/report');
                },
              ),
            ),
          ),
          
          // Map Controls (Layers)
          Positioned(
            bottom: 104,
            right: 24,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.surfaceContainer.withAlpha(200),
                border: Border.all(color: AppColors.borderMuted),
              ),
              child: IconButton(
                icon: const Icon(Icons.layers, color: AppColors.accentCyan),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Map Layers menu akan tersedia setelah integrasi data spasial.'),
                      backgroundColor: AppColors.surfaceContainerHigh,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
