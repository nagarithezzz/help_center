import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/data_controller.dart';
import 'package:hc/models/incident.dart';
import 'package:hc/screens/student/home_screen/home_screen.dart';
import 'package:hc/utils/utils.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class AddScreen extends StatelessWidget {
  final String? title;
  final Incident? incident;

  const AddScreen({Key? key, this.title, this.incident}) : super(key: key);

  static String routeName = "/addScreen";

  @override
  Widget build(BuildContext context) {
    String screenTitle = title ?? "Raise Incident";
    TextEditingController desc = TextEditingController();
    DataController controller = Get.put(DataController());
    String? selectedSubCategory;
    File? selectedFile;
    controller.fetchCategories();
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
                  const Text(
                    "Category",
                    style: TextStyle(fontSize: 16),
                  ),
                  Obx(() {
                    List<DropdownMenuItem<String>> dropdownItems =
                        controller.categories
                            .map((category) => DropdownMenuItem<String>(
                                  value: category
                                      .toString(), // Ensure the value is a string
                                  child: Text(category.toString()),
                                ))
                            .toList();

                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(),
                      ),
                      child: DropdownButton<String>(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(10),
                        underline: Container(),
                        hint: const Text("Select"),
                        items: dropdownItems,
                        onChanged: (selectedCategory) {
                          if (selectedCategory != null) {
                            controller.fetchSubCategories(selectedCategory);
                          }
                          print("Selected category: $selectedCategory");
                          selectedSubCategory = null;
                        },
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Sub Category",
                    style: TextStyle(fontSize: 16),
                  ),
                  Obx(() {
                    List<DropdownMenuItem<String>> subCategoryDropdownItems =
                        controller.subCategories
                            .map((subCategory) => DropdownMenuItem<String>(
                                  value: subCategory['subcategoryName'],
                                  child: Text(subCategory['subcategoryName']),
                                ))
                            .toList();
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(),
                      ),
                      child: DropdownButton<String>(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(10),
                        underline: Container(),
                        hint: const Text("Select"),
                        items: subCategoryDropdownItems,
                        onChanged: (selectedSubCategory) {
                          print("Selected subcategory: $selectedSubCategory");
                        },
                      ),
                    );
                  })
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
                maxLines:
                    null, // Set maxLines to null or a higher value for multi-line input
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Column(
                    children: [
                      Text("Upload file"),
                      Text(
                        "(if required)",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf', 'jpeg', 'jpg', 'png'],
                      );

                      if (result != null) {
                        if (result.files.length == 1) {
                          selectedFile = File(result.files.single.path!);
                          print("Selected file: ${selectedFile?.path}");
                        } else {
                          print("Please select only one file.");
                        }
                      } else {
                        print("File selection canceled.");
                      }
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
                            "Upload files",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const SizedBox(
                height: 24,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 180,
                    decoration: BoxDecoration(
                        color: UIParameters.primaryColor,
                        borderRadius: BorderRadius.circular(24)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Center(
                        child: Text(
                          "Create incident",
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
