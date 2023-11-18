import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hc/screens/student/home_screen/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import '../../../controllers/auth_controller.dart';
import '../../../utils/utils.dart';

class InputBox extends StatefulWidget {
  const InputBox({Key? key}) : super(key: key);

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  bool isObscure = true;

  void onTap() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  final AuthController authController = Get.put(AuthController());
  TextEditingController uname = TextEditingController();
  TextEditingController psswd = TextEditingController();

  Future<void> loginUser() async {
    final String url =
        'https://vithelpcenter.vit.ac.in/vitcc-help-center/autoLoginMobile';
    final String clientId = 'HC_MOBILE_APP';
    final String userId = uname.text;
    final String password = psswd.text;

    final Map<String, String> body = {
      'clientId': clientId,
      'userId': userId,
      'password': password,
    };

    final headers = {'Content-Type': 'application/json'}; // Add this line

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == 'SUCCESS') {
        await saveUserToDatabase(jsonResponse);
        Get.offAllNamed('/student/homeScreen');
        print('Login successful!');
      } else {
        Get.defaultDialog(
          title: 'Login Failed',
          middleText: 'Invalid username or password.',
          confirm: ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text('OK'),
          ),
        );
      }
    } else {
      Get.defaultDialog(
        title: 'Server unavailable',
        middleText: 'Please contact SDC.',
        confirm: ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: Text('OK'),
        ),
      );
    }
  }

  Future<void> saveUserToDatabase(Map<String, dynamic> user) async {
    final Database database = await openDatabase(
      'user_database.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE IF NOT EXISTS Users (id INTEGER PRIMARY KEY, userId TEXT, userEmail TEXT)',
        );
      },
    );

    // Ensure the 'Users' table exists
    await database.execute(
      'CREATE TABLE IF NOT EXISTS Users (id INTEGER PRIMARY KEY, userId TEXT, userEmail TEXT)',
    );

    final Map<String, dynamic> userData = {
      'id': 1,
      'userId': user['userId'],
      'userEmail': user['userEmail'],
    };

    await database.insert(
      'Users',
      userData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      height: MediaQuery.of(context).size.height / 3.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextField(
            controller: uname,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: UIParameters.primaryColor,
                ),
              ),
              prefixIcon: const Icon(Icons.account_box_outlined),
              labelText: "User Name",
              labelStyle: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
          TextField(
            controller: psswd,
            obscureText: isObscure,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 43, 71, 110),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: GestureDetector(
                onTap: onTap,
                child: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                ),
              ),
              labelText: "Password",
              labelStyle: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
          GestureDetector(
            onTap: loginUser,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
              decoration: BoxDecoration(
                color: UIParameters.primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                "Sign in",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
