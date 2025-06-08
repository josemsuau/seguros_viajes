import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../../controllers/dashboard_controller.dart';
import '../../../routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayAnimation, transfor;
  late Animation<double> fadeAnimation;
  late AnimationController animationController;
  // final DashboardController dashboardController = DashboardController.to;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    animation = Tween(begin: 0.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    transfor = BorderRadiusTween(
            begin: BorderRadius.circular(125.0),
            end: BorderRadius.circular(0.0))
        .animate(
            CurvedAnimation(parent: animationController, curve: Curves.ease));
    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();
    Timer(const Duration(seconds: 3), () async {
      // await dashboardController.checkToken();
      await redirect();
    });
  }

  Future<void> redirect() async {
    await Future.delayed(Duration.zero);
    if (!mounted) {
      return;
    }
    Get.offNamedUntil(Routes.home, (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:const Color(0xFFEFF5F5),
        body: Center(
          child: Image.asset('assets/logo/logo6.png',
          ),
        ));
  }
}
