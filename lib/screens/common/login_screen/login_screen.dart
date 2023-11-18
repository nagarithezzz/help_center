// login_screen.dart

import 'package:flutter/material.dart';
import '../../../utils/utils.dart';
import 'input_box.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String routeName = "/loginScreen";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: UIParameters.primaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 108, horizontal: 36),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    "assets/logo/VITLogoEmblem.png",
                    scale: 0.7,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "Vellore Institute of Technology",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Text(
                    "Chennai Campus",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const InputBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
