import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'package:flutter_application_1/consts/lists.dart';
import 'package:flutter_application_1/res/components/custom_button.dart';
import 'package:flutter_application_1/views/book_appointment_view/book_appointment_view.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math';

class DoctorProfileView extends StatelessWidget {
  final Map<String, dynamic> doc;
  final bool showBookingButton;

  const DoctorProfileView({
    super.key,
    required this.doc,
    this.showBookingButton = true, // default = patient
  });

  // Helper function to get doctor image by name
  String _getDoctorImageByName(String docName) {
    int index = docsNameList.indexWhere((name) => name == docName);
    if (index != -1 && index < docsList.length) {
      return docsList[index];
    }
    return ''; // Return empty if not found
  }

  // Liste d'adresses prédéfinies en Tunisie
  static final List<Map<String, dynamic>> _sampleLocations = [
    {
      'latitude': 36.8065,
      'longitude': 10.1815,
      'address': 'Avenue Habib Bourguiba, Tunis, Tunisia',
    },
    {
      'latitude': 36.8500,
      'longitude': 10.1900,
      'address': 'Rue de la République, La Marsa, Tunisia',
    },
    {
      'latitude': 36.7800,
      'longitude': 10.1700,
      'address': 'Avenue Mohamed V, Ariana, Tunisia',
    },
    {
      'latitude': 35.8256,
      'longitude': 10.6369,
      'address': 'Avenue de la Liberté, Sousse, Tunisia',
    },
    {
      'latitude': 36.8528,
      'longitude': 10.3233,
      'address': 'Centre Ville, Bizerte, Tunisia',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Récupérer une localisation aléatoire
    final location = _sampleLocations[Random().nextInt(_sampleLocations.length)];
    final latitude = location['latitude'];
    final longitude = location['longitude'];
    final address = location['address'];

    // Get doctor image from lists if not provided
    String docImage = doc['docImage'] ??  '';
    if (docImage. isEmpty) {
      docImage = _getDoctorImageByName(doc['docName'] ?? '');
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.blueColor,
        title: AppStyles.bold(
          title: "Doctor Profile",
          size: AppSizes.size18,
          color: AppColors.whiteColor,
        ),
      ),
      body: SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Info Card
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.blueColor. withOpacity(0.1),
                    backgroundImage: docImage.isNotEmpty
                        ? AssetImage(docImage) as ImageProvider
                        : null,
                    child: docImage.isEmpty
                        ? Icon(Icons. person, size: 40, color: AppColors.blueColor)
                        : null,
                  ),
                  16.widthBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppStyles.bold(
                          title: doc['docName'] ?? 'Doctor Name',
                          size:  AppSizes.size20,
                        ),
                        4.heightBox,
                        AppStyles.normal(
                          title: doc['docCategory'] ?? 'Specialist',
                          color:  AppColors.textColor.withOpacity(0.6),
                          size: AppSizes.size14,
                        ),
                        8.heightBox,
                        Row(
                          children:  [
                            Icon(Icons. star, color: AppColors.blueColor, size: 18),
                            4.widthBox,
                            AppStyles.bold(
                              title: doc['docRating'] ?? '4.7',
                              size: AppSizes.size14,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              24.heightBox,

              // About Section
              AppStyles.bold(title: "About", size: AppSizes.size16),
              8.heightBox,
              AppStyles.normal(
                title: doc['docAbout'] ?? "Experienced medical professional dedicated to providing quality healthcare.",
                color: AppColors. textColor.withOpacity(0.6),
                size: AppSizes.size14,
              ),
              24.heightBox,

              // Experience
              AppStyles.bold(title: "Experience", size: AppSizes.size16),
              8.heightBox,
              AppStyles.normal(
                title: "${doc['docExperience'] ?? '5'} years",
                color: AppColors.textColor.withOpacity(0.6),
                size: AppSizes.size14,
              ),
              24.heightBox,

              // Location Section
              AppStyles.bold(title: "Location", size: AppSizes. size16),
              8.heightBox,
              AppStyles.normal(
                title: address,
                color: AppColors.textColor.withOpacity(0.6),
                size: AppSizes.size14,
              ),
              12.heightBox,
              
              // Map Container
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.textColor.withOpacity(0.1)),
                ),
                clipBehavior:  Clip.antiAlias,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(latitude, longitude),
                    initialZoom: 15.0,
                    interactionOptions: InteractionOptions(
                      flags: InteractiveFlag. pinchZoom | InteractiveFlag.drag,
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.flutter_application_1',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(latitude, longitude),
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.location_on,
                            color: AppColors.blueColor,
                            size:  40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              24.heightBox,

              // Book Appointment Button
              if (showBookingButton)
              CustomButton(
                buttonText: "Book an appointment",
                onTap: () {
                  Get. to(() => BookAppointmentView(
                    docName: doc['docName'] ?? 'Doctor',
                    docSpeciality: doc['docCategory'] ?? 'Specialist',
                    docImage: docImage, // Pass the resolved image
                    docRating:  doc['docRating'] ?? '4.7',
              
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}