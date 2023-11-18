import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/data_controller.dart';
import 'package:hc/models/incident.dart';
import 'package:hc/screens/student/home_screen/home_screen.dart';
import 'package:hc/utils/utils.dart';

class EditScreen extends StatelessWidget {
  final String? title;
  final Incident? incident;
  final String? selectedCategory;
  final String? selectedSubCategory;
  const EditScreen(
      {Key? key,
      this.title,
      this.incident,
      this.selectedCategory,
      this.selectedSubCategory})
      : super(key: key);

  static String routeName = "/editScreen";

  @override
  Widget build(BuildContext context) {
    String screenTitle = title ?? "Edit Incident";
    TextEditingController desc =
        TextEditingController(text: incident?.description);
    DataController controller = Get.put(DataController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.toNamed(HomeScreen.routeName);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          backgroundColor: UIParameters.primaryColor,
          title: Text(
            screenTitle,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Category", style: TextStyle(fontSize: 16)),
                  // Obx(() {
                  //   final selectedValue =
                  //       selectedCategory ?? controller.category_value.value;
                  //   return Container(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 0, horizontal: 6),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(6),
                  //       border: Border.all(),
                  //     ),
                  //     child: DropdownButton<String>(
                  //       elevation: 8,
                  //       borderRadius: BorderRadius.circular(10),
                  //       underline: Container(),
                  //       hint: const Text("Select"),
                  //       value: selectedValue, // Set the selected value
                  //       items: controller.category.keys
                  //           .where((category) =>
                  //               category ==
                  //               selectedValue) // Filter only the selected category
                  //           .map((String category) {
                  //         return DropdownMenuItem<String>(
                  //           value: category,
                  //           child: Text(
                  //             category,
                  //             style: const TextStyle(fontSize: 12),
                  //           ),
                  //         );
                  //       }).toList(),
                  //       onChanged: (String? newValue) {
                  //         // You can leave this empty to prevent changing the value
                  //       },
                  //     ),
                  //   );
                  // }),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              const Text("Description", style: TextStyle(fontSize: 16)),
              const SizedBox(
                height: 20,
              ),
              TextField(
                cursorColor: UIParameters.primaryColor,
                minLines: 4,
                controller: desc,
                decoration: InputDecoration(
                  hintText: "Add more info here",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                maxLines: null,
              ),
              const SizedBox(
                height: 24,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => HomeScreen());
                  },
                  child: Container(
                    width: 180,
                    decoration: BoxDecoration(
                        color: UIParameters.primaryColor,
                        borderRadius: BorderRadius.circular(24)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Center(
                        child: Text(
                          "Edit incident",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
