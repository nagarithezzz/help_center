import 'package:get/get.dart';
import 'package:hc/controllers/auth_controller.dart';
import 'package:hc/controllers/data_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    // Initialize AuthController first
    Get.put(AuthController());
    Get.put(DataController());
  }
}
