import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'package:flutter_application_1/controllers/appointment_controller.dart';
import 'package:flutter_application_1/views/appointment_details_view/appointment_details_view.dart';
import 'package:get/get.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppointmentController controller = Get.put(AppointmentController());

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
      body: Obx(() {
        if (controller.appointments.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 80,
                  color: AppColors.textColor.withOpacity(0.3),
                ),
                16.heightBox,
                AppStyles.normal(
                  title: "No appointments yet",
                  color: AppColors.textColor.withOpacity(0.5),
                  size: AppSizes.size16,
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: controller.appointments.length,
            itemBuilder: (BuildContext context, int index) {
              final appointment = controller.appointments[index];
              final isConfirmed = appointment['status'] == 'Confirmed';
              final isCancelled = appointment['status'] == 'Cancelled';
              
              return Dismissible(
                key: Key(appointment['docName'] + index.toString()),
                background: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  controller.deleteAppointment(index);
                  Get.snackbar(
                    'Deleted',
                    'Appointment deleted',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                },
                child: Container(
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
                        docImage: appointment['docImage'] ?? '',
                        selectedDate: appointment['date']!,
                        selectedDay: 23,
                        selectedTime: '02:00 PM',
                      ));
                    },
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.blueColor.withOpacity(0.1),
                      backgroundImage: (appointment['docImage'] != null && appointment['docImage'].toString().isNotEmpty)
                          ? AssetImage(appointment['docImage']) as ImageProvider
                          : null,
                      child: (appointment['docImage'] == null || appointment['docImage'].toString().isEmpty)
                          ? Icon(Icons.person, size: 30, color: AppColors.blueColor)
                          : null,
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
                ),
              );
            },
          ),
        );
      }),
    );
  }
}