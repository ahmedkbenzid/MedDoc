import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/res/components/custom_button.dart';
import 'package:flutter_application_1/views/book_appointment_view/book_appointment_view.dart';
import 'package:get/get.dart';

class DoctorProfileView extends StatelessWidget {
  final Map<String, dynamic> doc;

  const DoctorProfileView({
    super.key,
    required this.doc,
  });

  @override
  Widget build(BuildContext context) {
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
                    child: Icon(Icons.person, size: 50, color: AppColors.blueColor),
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

              // Book Appointment Button
              CustomButton(
                buttonText: "Book an appointment",
                onTap: () {
                  Get.to(() => BookAppointmentView(
                    docName: doc['docName'] ?? 'Doctor',
                    docSpeciality: doc['docCategory'] ?? 'Specialist',
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