import 'package:get/get.dart';
import 'package:hc/screens/common/add_screen/add_screen.dart';
import 'package:hc/screens/common/edit_screen/edit_screen.dart';
import 'package:hc/screens/common/loading_screen/loading_screen.dart';
import 'package:hc/screens/common/login_screen/login_screen.dart';
import 'package:hc/screens/common/root_page.dart';
import 'package:hc/screens/student/all_incidents_screen/all_incidents_screen.dart';
import 'package:hc/screens/student/home_screen/home_screen.dart';

class Approutes {
  static List<GetPage> routes() => [
        GetPage(name: RootScreen.routeName, page: () => const RootScreen()),
        GetPage(name: LoginScreen.routeName, page: () => const LoginScreen()),
        GetPage(
            name: LoadingScreen.routeName, page: () => const LoadingScreen()),
        GetPage(name: AddScreen.routeName, page: () => const AddScreen()),
        GetPage(name: HomeScreen.routeName, page: () => const HomeScreen()),
        GetPage(name: EditScreen.routeName, page: () => const EditScreen()),
        GetPage(
            name: AllIncidentsScreen.routeName,
            page: () => const AllIncidentsScreen())
      ];
}
