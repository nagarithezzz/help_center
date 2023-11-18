// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hc/models/incident.dart';
import 'package:hc/screens/common/edit_screen/edit_screen.dart';
import 'package:hc/utils/utils.dart';

class IncidentCard extends StatelessWidget {
  final Incident incident;
  // ignore: use_key_in_widget_constructors
  const IncidentCard({Key? key, required this.incident}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* final String formattedDate =
        DateFormat('dd-MM-yyyy').format(incident.createdDate); */

    void _showIncidentDetailsDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Incident Details',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                    onPressed: () {
                      Get.to(() => EditScreen(
                            incident: incident,
                            selectedCategory: incident.category,
                            selectedSubCategory: incident.subCategory,
                          ));
                    },
                    icon: const Icon(Icons.edit))
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(incident.description),
                  const Divider(), // Add a horizontal line for separation
                  const Text(
                    'Sub-Category:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(incident.subCategory,
                      style: const TextStyle(color: Colors.blue)),
                  const Divider(),
                  const Text(
                    'Category:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(incident.category),
                  const Divider(),
                  const Text(
                    'Date:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(incident.createdDate),
                  const Divider(),
                  const Text(
                    'Status:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    incident.status,
                    style: TextStyle(
                      color: incident.status == "Pending"
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                  // Include other incident details here
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Close',
                  style: TextStyle(color: UIParameters.primaryColor),
                ),
              ),
            ],
          );
        },
      );
    }

    return GestureDetector(
      onTap: () {
        _showIncidentDetailsDialog(context);
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.all(8),
        elevation: 4, // Add elevation for a card-like appearance
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                incident.description,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const Text(
                    "Sub-Category: ",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    incident.subCategory,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  const Text(
                    "Category: ",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(incident.category),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  const Text(
                    "Date: ",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(incident.createdDate),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  const Text(
                    "Status: ",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    incident.status,
                    style: TextStyle(
                      color: incident.status == "Pending"
                          ? Colors.red
                          : Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
