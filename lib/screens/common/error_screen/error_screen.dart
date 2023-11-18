import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;
  static String routeName = "/errorScreen";
  const ErrorScreen({Key? key, required this.errorMessage}) : super(key: key);

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
              Center(
                child: Text(
                  "Error occurred: $errorMessage", // Display the error message
                  style: TextStyle(
                    color:
                        UIParameters.primaryColor, // Customize the text color
                    fontSize: 16, // Customize the font size
                  ),
                ),
              ),
              const SizedBox(
                height: 24, // Add spacing between the image and text
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 140,
                  decoration: BoxDecoration(
                      color: UIParameters.primaryColor,
                      borderRadius: BorderRadius.circular(24)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Center(
                      child: Text(
                        "Go Back",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
