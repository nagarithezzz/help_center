import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool hasNavigated = false;

  @override
  void initState() {
    super.initState();
    initiateNavigation();
  }

  Future<void> initiateNavigation() async {
    await checkDatabase();

    // Add a delay of 5 seconds before navigating to the next screen
    await Future.delayed(Duration(seconds: 3));

    // Navigate to the appropriate screen based on your logic
    if (!hasNavigated) {
      hasNavigated = true;
      if (records.length == 1) {
        Get.offAllNamed(
            '/student/homeScreen'); // Replace with the actual route for HomeScreen
      } else {
        Get.offAllNamed(
            '/loginScreen'); // Replace with the actual route for LoginScreen
      }
    }
  }

  List<Map<String, dynamic>> records = [];

  Future<void> checkDatabase() async {
    final Database database = await openDatabase(
      'user_database.db',
      version: 1,
    );

    try {
      records = await database.query('Users');
      print('Number of records in the database: ${records.length}');
    } catch (e) {
      print('Error checking database: $e');
      hasNavigated = true;
      Get.offAllNamed('/loginScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
