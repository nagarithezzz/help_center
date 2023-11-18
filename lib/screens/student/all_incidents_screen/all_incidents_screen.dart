import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hc/controllers/auth_controller.dart';
import 'package:hc/controllers/data_controller.dart';
import 'package:hc/screens/student/widgets/incident_card.dart';

import '../../../utils/utils.dart';
import '../../common/add_screen/add_screen.dart';

class AllIncidentsScreen extends StatefulWidget {
  const AllIncidentsScreen({super.key});
  static String routeName = "/student/AllIncidentsScreen";
  @override
  State<AllIncidentsScreen> createState() => _AllIncidentsScreenState();
}

class _AllIncidentsScreenState extends State<AllIncidentsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // ignore: unused_field
  AuthController authController = Get.put(AuthController());
  DataController dataController = Get.put(DataController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(color: UIParameters.primaryColor),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.white,
                    ),
                    Column(
                      children: [
                        Text(
                          "VEERA KARTHICK V",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Text(
                          "22BAI1219",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Get.toNamed("/student/homeScreen");
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_box),
              title: const Text('Raise new tickets'),
              onTap: () {
                Get.to(() => AddScreen());
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('View past tickets'),
              onTap: () {
                // Add functionality to navigate to the settings screen here.
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Sign Out'),
              onTap: () {
                authController.logOut();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.white,
                )),
          )
        ],
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            )),
        title: const Text(
          "VITian Help Center",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        elevation: 5,
        backgroundColor: UIParameters.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "All Tickets",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: dataController.all_Incident.length,
                  itemBuilder: (context, index) {
                    return IncidentCard(
                        incident: dataController.all_Incident[index]);
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
