// ignore_for_file: use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logbook/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _rotateController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    // Controller untuk animasi fade (memudar)
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Controller untuk animasi scale (pembesaran)
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Controller untuk animasi rotasi
    _rotateController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // Fade Animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Scale Animation
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Rotate Animation
    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _rotateController, curve: Curves.linear));

    // Mulai semua animasi
    _fadeController.forward();
    _scaleController.forward();
    _rotateController.forward();

    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final auth = context.read<AuthProvider>();

    // Misalnya: Firebase.initializeApp(), atau FirebaseMessaging.instance.requestPermission()
    // atau untuk mengecek status login tersimpan, seperti:
    // User? currentUser = FirebaseAuth.instance.currentUser;
    // await auth.initUser(currentUser);
    // (Jika auth.initUser mengupdate status auth.isLoggedIn secara internal)

    // Simulasi loading selama 2 detik
    await Future.delayed(const Duration(seconds: 2));

    // Navigasi berdasarkan status login
    if (mounted) {
      if (auth.isLoggedIn) {
        final role = auth.userRole;
        context.go(role == 'teacher' ? '/teacher' : '/dashboard');
      } else {
        context.go('/login');
      }
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green.shade900,
              Colors.green.shade700,
              Colors.teal.shade600,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Rotating Container dengan Icon
              AnimatedBuilder(
                animation: _rotateController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotateAnimation.value * 2 * 3.14159,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.lightGreen.shade300,
                              Colors.lime.shade200,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.lightGreen.withOpacity(0.5),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.book_rounded,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),

              // Text "LOGBOOK PKL" dengan fade animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          Colors.lightGreen.shade200,
                          Colors.lime.shade200,
                        ],
                      ).createShader(bounds),
                      child: const Text(
                        'LOGBOOK PKL',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Praktik Kerja Lapangan',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.lightGreen.shade200,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80),

              // Loading dots animation
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 3; i++)
                    AnimatedBuilder(
                      animation: _fadeController,
                      builder: (context, child) {
                        final baseOpacity = 0.3;
                        final maxOpacity = 1.0;
                        final cycleTime = _fadeController.value;

                        // Buat efek delay untuk setiap dot
                        final delay = (i * 0.15);
                        final adjustedTime = (cycleTime * 1.5 + delay) % 1.0;

                        final opacity = adjustedTime < 0.5
                            ? baseOpacity +
                                  (maxOpacity - baseOpacity) *
                                      (adjustedTime * 2)
                            : baseOpacity +
                                  (maxOpacity - baseOpacity) *
                                      (2 - adjustedTime * 2);

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.lightGreen.shade300.withOpacity(
                                opacity,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
