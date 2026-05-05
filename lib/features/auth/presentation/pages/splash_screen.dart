import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import 'dart:ui' as ui;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/onboarding');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceMain,
      body: Stack(
        children: [
          // Cyber Grid Background
          Positioned.fill(
            child: CustomPaint(
              painter: GridPainter(),
            ),
          ),
          
          // Ambient Glow Background
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentCyan,
              ),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 120, sigmaY: 120),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          
          // Main Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Container
                  SizedBox(
                    width: 128,
                    height: 128,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Pulse Glow Ring
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.accentCyan.withOpacity(0.5), width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.accentCyan.withOpacity(0.8),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          width: 140,
                          height: 140,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.accentCyan.withOpacity(0.3), width: 1),
                          ),
                          width: 160,
                          height: 160,
                        ),
                        // Placeholder for Logo
                        Icon(
                          Icons.security, // Fallback icon, will update later if there's an asset
                          size: 64,
                          color: AppColors.textPrimary,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Title
                  Text(
                    'SPATAGUARD',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      letterSpacing: 2.0,
                      shadows: [
                        Shadow(
                          color: AppColors.accentCyan.withOpacity(0.5),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Subtitle
                  Text(
                    'Mapping Safety, Securing Future.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                      letterSpacing: 1.0,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Scanning Line Loading Indicator
                  Container(
                    width: 192,
                    height: 2,
                    decoration: BoxDecoration(
                      color: AppColors.borderMuted,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Stack(
                          children: [
                            Positioned(
                              left: _controller.value * 192 - 64,
                              child: Container(
                                width: 64,
                                height: 2,
                                decoration: BoxDecoration(
                                  color: AppColors.accentCyan,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColors.accentCyan,
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // System Status Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sensors,
                        size: 14,
                        color: AppColors.accentCyan.withOpacity(0.7),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'INITIALIZING SECURE UPLINK',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.accentCyan.withOpacity(0.7),
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom Decorative Elements
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SYS.VER.2.4.01',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: 10,
                    color: AppColors.textSecondary.withOpacity(0.5),
                  ),
                ),
                Text(
                  'SECURE: AES-256',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: 10,
                    color: AppColors.accentCyan.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accentCyan.withOpacity(0.05)
      ..strokeWidth = 1;

    const double gridSize = 40.0;
    
    // Draw vertical lines
    for (double i = 0; i < size.width; i += gridSize) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    
    // Draw horizontal lines
    for (double i = 0; i < size.height; i += gridSize) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
