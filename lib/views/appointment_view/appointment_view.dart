import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'package:flutter_application_1/consts/images.dart';
import 'package:flutter_application_1/views/appointment_details_view/appointment_details_view.dart';
import 'package:get/get.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample appointment data
    final List<Map<String, String>> appointments = [
      {
        'docName': 'Dr. John Smith',
        'docSpeciality': 'Cardiologist',
        'date': 'Wednesday, Jun 23, 2021 | 02:00 PM',
        'status': 'Confirmed',
      },
      {
        'docName': 'Dr. Sarah Johnson',
        'docSpeciality': 'Dentist',
        'date': 'Thursday, Jun 24, 2021 | 10:00 AM',
        'status': 'Pending',
      },
      {
        'docName': 'Dr. Michael Brown',
        'docSpeciality': 'Orthopedic',
        'date': 'Friday, Jun 25, 2021 | 03:00 PM',
        'status': 'Confirmed',
      },
      {
        'docName': 'Dr. Emily Davis',
        'docSpeciality': 'Dermatologist',
        'date': 'Monday, Jun 28, 2021 | 11:00 AM',
        'status': 'Cancelled',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.blueColor,
        title: AppStyles.bold(
          title: "My Appointments",
          size: AppSizes.size18,
          color: AppColors.whiteColor
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: appointments.length,
          itemBuilder: (BuildContext context, int index) {
            final appointment = appointments[index];
            final isConfirmed = appointment['status'] == 'Confirmed';
            final isCancelled = appointment['status'] == 'Cancelled';
            
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                onTap: () {
                  Get.to(() => AppointmentDetailsView(
                    docName: appointment['docName']!,
                    docSpeciality: appointment['docSpeciality']!,
                    selectedDate: appointment['date']!,
                    selectedDay: 23,
                    selectedTime: '02:00 PM',
                  ));
                },
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.blueColor.withOpacity(0.1),
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: AppColors.blueColor,
                  ),
                ),
                title: AppStyles.bold(
                  title: appointment['docName']!,
                  size: AppSizes.size16,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    4.heightBox,
                    AppStyles.normal(
                      title: appointment['docSpeciality']!,
                      color: AppColors.textColor.withOpacity(0.6),
                      size: AppSizes.size14,
                    ),
                    6.heightBox,
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: AppColors.textColor.withOpacity(0.5),
                        ),
                        4.widthBox,
                        Flexible(
                          child: AppStyles.normal(
                            title: appointment['date']!,
                            color: AppColors.textColor.withOpacity(0.5),
                            size: AppSizes.size12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isCancelled
                        ? Colors.red.withOpacity(0.1)
                        : isConfirmed
                            ? Colors.green.withOpacity(0.1)
                            : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: AppStyles.normal(
                    title: appointment['status']!,
                    color: isCancelled
                        ? Colors.red
                        : isConfirmed
                            ? Colors.green
                            : Colors.orange,
                    size: AppSizes.size12,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}