import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hc/screens/common/error_screen/error_screen.dart';
import 'package:hc/screens/common/login_screen/login_screen.dart';
import 'package:hc/screens/student/home_screen/home_screen.dart';

class AuthController extends GetxController {
  RxStatus isloading = RxStatus.loading();

  @override
  void onInit() {
    fetchUserInfoFromSqflite();
    super.onInit();
  }

  RxString? fetchedUsername;
  RxString? fetchedPasswd;
  Future<void> fetchUserInfoFromSqflite() async {
    try {
      final Database database = await openDatabase(
        'user_database.db',
        version: 1,
      );

      final List<Map<String, dynamic>> records = await database.query('Users',
          where: 'id = ?', whereArgs: [1], limit: 1);

      if (records.isNotEmpty) {
        fetchedUsername = records[0]['userId'].obs;
        fetchedPasswd = records[0]['userEmail'].obs;
      }
    } catch (e) {
      print('Error fetching user info from Sqflite: $e');
    }
  }

  Future<void> logOut() async {
    try {
      final Database database = await openDatabase(
        'user_database.db',
        version: 1,
      );
      await database.execute('DROP TABLE IF EXISTS Users');

      await Future.delayed(const Duration(seconds: 2));
      isloading = RxStatus.success();
      Get.toNamed(LoginScreen.routeName);
    } catch (e) {
      isloading = RxStatus.error();
      Get.toNamed(ErrorScreen.routeName, arguments: "An error occurred: $e");
    }
  }
}
