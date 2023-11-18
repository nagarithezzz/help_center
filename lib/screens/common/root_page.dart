import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hc/controllers/auth_controller.dart';
import 'package:hc/utils/utils.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});
  static String routeName = "/";

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: UIParameters.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo/VITLogoEmblem.png",
              scale: 0.5,
              color: Colors.white,
            ),
            const SizedBox(
              height: 36,
            ),
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    ));
  }
}
