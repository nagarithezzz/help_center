import 'package:flutter/material.dart';
import 'package:hc/utils/utils.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});
  static String routeName = "/loadingScreen";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo/VITLogoEmblem.png",
              scale: 0.5,
              color: UIParameters.primaryColor,
            ),
            const SizedBox(
              height: 36,
            ),
            CircularProgressIndicator(
              color: UIParameters.primaryColor,
            )
          ],
        ),
      ),
    ));
  }
}
