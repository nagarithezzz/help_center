// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart' as dio; // Using an alias for dio
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:hc/models/incident.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class DataController extends GetxController {
  RxStatus isloading = RxStatus.loading();

  double uploadProgress = 0.0; // Progress variable
  bool isUploading = false; // Indicates whether a file is being uploaded

  //for dropdowns
  //Note: Load all these data from the API in starting of the app
  //add onInit() funtion
  @override
  void onInit() {
    super.onInit();
    fetchAll();
  }

  RxList<Incident> all_Incident = RxList();
  RxList<Incident> pending_incidents = RxList();
  RxString searchbox = "".obs;
  RxString fileName = "".obs;
  RxInt solved = 2.obs;
  RxInt total = 8.obs;

  RxMap<String, List<String>> category = RxMap({
    "ACADEMICS": [
      "COURSE REGISTRATION",
      "INTERNSHIP",
      "LMS",
      "MOODLE",
      "OTHERS",
      "PROJECT -RESEARCH",
      "WEBINAR",
      "WORKSHOP"
    ],
    "ADMISSION": [
      "ADMISSION -RELATED",
      "HOSTEL-ALLOTMENTS",
      "OTHERS",
      "PAYMENTS"
    ],
    "COE-Controller of Examinations": [
      "CERTIFICATE VERIFICATION",
      "CERTIFICATES",
      "EXAMINATIONS",
      "OTHERS",
      "TRANSCRIPTS"
    ],
    "COURSE REGISTRATION": [
      "LOGIN Incident",
      "REGISTRATION Incident",
      "OTHERS"
    ],
  });
  RxList<String> sub_category = RxList([]);

  RxString category_value = RxString("ACADEMICS");
  RxString sub_category_value = RxString("INTERNSHIP");

  //for file handle
  Rx<dio.MultipartFile?> filePart = Rx<dio.MultipartFile?>(null);

  // Function to handle file upload
  Future<void> uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path ?? "");
      String fileName = file.path.split("/").last;

      // Create a MultipartFile from the selected file
      dio.MultipartFile uploadedFile = await dio.MultipartFile.fromFile(
        file.path,
        filename: fileName,
      );

      // Update the reactive variable directly
      filePart.value = uploadedFile;
    }
  }

// Function to handle API request
  Future<void> handleApiRequest(Incident incident) async {
    try {
// Optional: Add an interceptor for debugging

      if (filePart.value != null) {
        // Get the MultipartFile for upload

        // Create FormData with the file and other form fields
        /*FormData formData = FormData.fromMap({
        'file': clonedFilePart,
        // Include other form fields if needed
        'incidentType': incident.type,
        // Add more fields as necessary
      });

      // Make a POST request with Dio
      Response response = await dioInstance.post(
        'your_upload_url_here', // Replace with your API endpoint
        data: formData,
        onSendProgress: (sent, total) {
          // Calculate the progress percentage and update the state
          uploadProgress = sent / total;
        },
      );

      // Handle the response as needed
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
    } */

        // Rest of your code

        isloading = RxStatus.success();
        Get.toNamed("student/homeScreen");
      }
    } catch (e) {
      isloading = RxStatus.error();
      Get.toNamed("/errorScreen", arguments: "An error occurred: $e");
    }
  }

  Future<void> fetchAll() async {
    try {
      isloading = RxStatus.loading();
      String jsonData = await rootBundle.loadString("assets/data/data.json");
      Map<String, dynamic> data = json.decode(jsonData);

      List<dynamic> complaints = data['complaints'];
      for (var complaint in complaints) {
        Incident newIncident = Incident.fromJson(complaint);
        all_Incident.add(newIncident);
        if (newIncident.status != "CLOSED") {
          pending_incidents.add(newIncident);
        }
      }
      isloading = RxStatus.success();
      // Get.toNamed(HomeScreen.routeName);
    } catch (e) {
      isloading = RxStatus.error();
      Get.toNamed("/errorScreen", arguments: "An error occurred: $e");
    }
  }
}
