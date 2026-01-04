import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/fonts.dart';
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

  // Liste d'adresses prédéfinies en Tunisie
  static final List<Map<String, dynamic>> _sampleLocations = [
    {
      'latitude': 36.8065,
      'longitude': 10.1815,
      'address': 'Avenue Habib Bourguiba, Tunis 1000, Tunisia',
    },
    {
      'latitude': 36.8500,
      'longitude': 10.1950,
      'address': 'Rue de la Liberté, La Marsa, Tunis, Tunisia',
    },
    {
      'latitude': 36.7525,
      'longitude': 10.2300,
      'address': 'Centre Ville, Hammam Lif, Ben Arous, Tunisia',
    },
    {
      'latitude': 36.8380,
      'longitude': 10.1658,
      'address': 'Avenue de la République, Le Bardo, Tunis, Tunisia',
    },
    {
      'latitude': 36.8625,
      'longitude': 10.3272,
      'address': 'Avenue Farhat Hached, Ariana, Tunisia',
    },
    {
      'latitude': 36.8189,
      'longitude': 10.1658,
      'address': 'Rue Ibn Khaldoun, Manouba, Tunisia',
    },
    {
      'latitude': 36.7987,
      'longitude': 10.1710,
      'address': 'Avenue Mohamed V, Bab Bhar, Tunis, Tunisia',
    },
    {
      'latitude': 36.8430,
      'longitude': 10.2400,
      'address': 'Rue de Carthage, Carthage, Tunisia',
    },
  ];

  Map<String, dynamic> _getLocation() {
    // Si le docteur a déjà une localisation définie
    if (doc['docLatitude'] != null && doc['docLongitude'] != null) {
      return {
        'latitude': doc['docLatitude'],
        'longitude': doc['docLongitude'],
        'address': doc['docAddress'] ?? 'Address not available',
      };
    }
    
    // Sinon, générer une adresse aléatoire basée sur l'ID ou le nom du docteur
    final random = Random(doc['docName']?.hashCode ?? Random().nextInt(1000));
    final location = _sampleLocations[random.nextInt(_sampleLocations.length)];
    
    return location;
  }

  @override
  Widget build(BuildContext context) {
    // Obtenir la localisation (réelle ou générée)
    final location = _getLocation();
    final double latitude = location['latitude'];
    final double longitude = location['longitude'];
    final String address = location['address'];

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textColor),
          onPressed: () => Get.back(),
        ),
        title: AppStyles.bold(
          title: "Doctor Profile",
          size: AppSizes.size18,
          color: AppColors.textColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Info Card
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.blueColor.withOpacity(0.1),
                    backgroundImage: (doc['docImage'] != null && doc['docImage'].toString().isNotEmpty)
                        ? AssetImage(doc['docImage']) as ImageProvider
                        : null,
                    child: (doc['docImage'] == null || doc['docImage'].toString().isEmpty)
                        ? Icon(Icons.person, size: 50, color: AppColors.blueColor)
                        : null,
                  ),
                  16.widthBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppStyles.bold(
                          title: doc['docName'] ?? 'Doctor Name',
                          size: AppSizes.size20,
                        ),
                        4.heightBox,
                        AppStyles.normal(
                          title: doc['docCategory'] ?? 'Specialist',
                          color: AppColors.textColor.withOpacity(0.6),
                          size: AppSizes.size14,
                        ),
                        8.heightBox,
                        Row(
                          children: [
                            Icon(Icons.star, color: AppColors.blueColor, size: 18),
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
                color: AppColors.textColor.withOpacity(0.6),
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
              AppStyles.bold(title: "Location", size: AppSizes.size16),
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
                clipBehavior: Clip.antiAlias,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(latitude, longitude),
                    initialZoom: 15.0,
                    interactionOptions: InteractionOptions(
                      flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
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
                            size: 40,
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
                  Get.to(() => BookAppointmentView(
                    docName: doc['docName'] ?? 'Doctor',
                    docSpeciality: doc['docCategory'] ?? 'Specialist',
                    docImage: doc['docImage'] ?? '',
                    docRating: doc['docRating'] ?? '4.7',
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