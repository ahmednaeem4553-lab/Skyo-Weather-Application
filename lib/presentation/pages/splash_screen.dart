import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animation setup: 0.0 → 1.0 → 0.0
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // total animation time
    );

    _fadeAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 40, // fade in ~1.6s
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 20), // hold 0.8s
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40, // fade out ~1.6s
      ),
    ]).animate(_controller);

    // Start animation
    _controller.forward();

    // Listen for completion → redirect
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Use GetX for navigation
        Get.offAllNamed('/home'); // or Get.offAll(() => const HomePage());
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
      backgroundColor: Color.fromARGB(255, 0, 18, 110),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Skyo Brand Design(without text).png',
                width: 220,
                height: 220,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'SKYO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              Text(
                'Presented by Ahmed Naeem',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
