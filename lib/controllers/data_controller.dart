import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:hc/models/incident.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class DataController extends GetxController {
  RxStatus isloading = RxStatus.loading();

  double uploadProgress = 0.0; // Progress variable
  bool isUploading = false; // Indicates whether a file is being uploaded

  @override
  void onInit() {
    super.onInit();
  }

  RxList<Incident> all_Incident = RxList();
  RxList<Incident> pending_incidents = RxList();
  RxString searchbox = "".obs;
  RxString fileName = "".obs;
  RxInt solved = 2.obs;
  RxInt total = 8.obs;
  RxString selectedCategory = "".obs;

  RxList<String> categories = <String>[].obs;
  RxList<Map<String, dynamic>> subCategories = <Map<String, dynamic>>[].obs;
  Future<void> fetchSubCategories(String selectedCategory) async {
    final String url =
        'https://vithelpcenter.vit.ac.in/vitcc-help-center/getSubCategoryMobile';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'category': selectedCategory,
          'clientId': 'HC_MOBILE_APP',
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> subCategoryList = jsonDecode(response.body);

        subCategories.assignAll(subCategoryList.cast<Map<String, dynamic>>());
      } else {
        print(
            'Failed to load subcategories. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions (network errors, etc.)
      print('Error fetching subcategories: $e');
    }
  }

  Future<void> fetchCategories() async {
    print("Fetching");
    try {
      isloading = RxStatus.loading();

      String apiUrl =
          'https://vithelpcenter.vit.ac.in/vitcc-help-center/getCategorListMobile';

      // Define the request body
      Map<String, dynamic> requestBody = {
        "clientId": "HC_MOBILE_APP",
      };

      dio.Response response = await dio.Dio().post(
        apiUrl,
        data: requestBody,
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> categoriesData =
            List<Map<String, dynamic>>.from(response.data);

        categories.assignAll(
            categoriesData.map((category) => category["categoryName"]));

        isloading = RxStatus.success();
      } else {
        isloading = RxStatus.error();
        Get.toNamed("/errorScreen",
            arguments:
                "Failed to fetch categories. Status code: ${response.statusCode}");
      }
    } catch (e) {
      isloading = RxStatus.error();
      Get.toNamed("/errorScreen", arguments: "An error occurred: $e");
    }
  }

  //for file handle
  Rx<dio.MultipartFile?> filePart = Rx<dio.MultipartFile?>(null);

  // Function to handle file upload
  Future<void> uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path ?? "");
      String fileName = file.path.split("/").last;

      dio.MultipartFile uploadedFile = await dio.MultipartFile.fromFile(
        file.path,
        filename: fileName,
      );

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
}
