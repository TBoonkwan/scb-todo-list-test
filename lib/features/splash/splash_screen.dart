import 'package:flutter/material.dart';
import 'package:scb_test/core/delegate/app_starter_delegate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with AppStarterDelegate {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String destination = checkIsShouldShowPin();
      Navigator.of(context).popAndPushNamed(destination);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
