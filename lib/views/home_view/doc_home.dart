import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'package:flutter_application_1/consts/images.dart';
import 'package:flutter_application_1/views/doctor/doctor_appointment/agenda_view.dart';
import 'package:flutter_application_1/views/doctor/doctor_appointment/appointment_request_view.dart';
import 'package:flutter_application_1/views/doctor/doctor_profile/profile_view.dart';
import 'package:flutter_application_1/views/doctor/doctor_communication/message_list_view.dart';
import 'package:flutter_application_1/views/doctor/patient_records/patient_list_view.dart';
import 'package:flutter_application_1/views/settings_view/settings_view.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_application_1/views/doctor/reminders/reminders_view.dart';


class DocHome extends StatefulWidget {
  const DocHome({super.key});

  @override
  State<DocHome> createState() => _DocHomeState();
}

class _DocHomeState extends State<DocHome> {
  int selectedIndex = 0;

  // Liste des écrans disponibles
  final List<Widget> screenList = [
    const DoctorHomeView(),
    AgendaView(),
    AppointmentRequestView(),
    const MessageListView(),
    const RemindersView(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white.withOpacity(0.5),
        selectedItemColor: AppColors.whiteColor,
        selectedLabelStyle: TextStyle(color: AppColors.whiteColor),
        selectedIconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.blueColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: const [
          
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Agenda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.request_page),
            label: "Requests",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Messages",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications), // icône pour les rappels
            label: "Reminders",              // nouveau label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

// Doctor Home View
class DoctorHomeView extends StatelessWidget {
  const DoctorHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(
          title: "Doctor Dashboard",
          color: AppColors.whiteColor,
          size: AppSizes.size18,
        ),
        backgroundColor: AppColors.blueColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section avec boutons Profil et Dossiers Patients
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.blueColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Image.asset(AppAssets.imgSignup),
                    ),
                    15.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppStyles.bold(
                            title: "Welcome Dr. John",
                            color: AppColors.whiteColor,
                            size: AppSizes.size16,
                          ),
                          5.heightBox,
                          AppStyles.normal(
                            title: "Have a nice day!",
                            color: AppColors.whiteColor.withOpacity(0.8),
                            size: AppSizes.size12,
                          ),
                        ],
                      ),
                    ),
                    // Bouton Profil
                    IconButton(
                      icon: const Icon(Icons.person, color: Colors.white),
                      tooltip: "Mon Profil",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProfileView(),
                          ),
                        );
                      },
                    ),
                    // Bouton Dossiers Patients
                    IconButton(
                      icon: const Icon(Icons.folder, color: Colors.white),
                      tooltip: "Dossiers Patients",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PatientListView(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              20.heightBox,

              // Quick Stats
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.bgDarkColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.people,
                            size: 40,
                            color: AppColors.blueColor,
                          ),
                          10.heightBox,
                          AppStyles.bold(
                            title: "24",
                            color: AppColors.textColor,
                            size: AppSizes.size18,
                          ),
                          AppStyles.normal(
                            title: "Today's Appointments",
                            color: AppColors.textColor.withOpacity(0.6),
                            size: AppSizes.size12,
                            alignment: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  10.widthBox,
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.bgDarkColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.person,
                            size: 40,
                            color: AppColors.blueColor,
                          ),
                          10.heightBox,
                          AppStyles.bold(
                            title: "342",
                            color: AppColors.textColor,
                            size: AppSizes.size18,
                          ),
                          AppStyles.normal(
                            title: "Total Patients",
                            color: AppColors.textColor.withOpacity(0.6),
                            size: AppSizes.size12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              20.heightBox,

              // Upcoming Appointments Section
              AppStyles.bold(
                title: "Upcoming Appointments",
                color: AppColors.blueColor,
                size: AppSizes.size18,
              ),
              10.heightBox,

              // Appointments List (mock data)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.bgDarkColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          child: Image.asset(AppAssets.imgSignup),
                        ),
                        12.widthBox,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppStyles.bold(
                                title: "Patient ${index + 1}",
                                size: AppSizes.size14,
                                color: AppColors.textColor,
                              ),
                              5.heightBox,
                              AppStyles.normal(
                                title: "10:${(index + 1) * 10} AM",
                                color: AppColors.textColor.withOpacity(0.6),
                                size: AppSizes.size12,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: AppColors.blueColor,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
