import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hc/bindings/initial_bindings.dart';
import 'package:hc/routes/routes.dart';
import 'package:hc/screens/common/login_screen/login_screen.dart';
import 'package:hc/splash_screen/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      getPages: Approutes.routes(),
    );
  }
}
