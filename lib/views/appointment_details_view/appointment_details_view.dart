import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/res/components/custom_button.dart';
import 'package:get/get.dart';

class AppointmentDetailsView extends StatelessWidget {
  final String docName;
  final String docSpeciality;
  final String selectedDate;
  final int selectedDay;
  final String selectedTime;

  const AppointmentDetailsView({
    super.key,
    required this.docName,
    required this.docSpeciality,
    required this.selectedDate,
    required this.selectedDay,
    required this.selectedTime,
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
          title: "Appointment",
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
              // Doctor Info
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.blueColor.withOpacity(0.1),
                    child: Icon(Icons.person, size: 40, color: AppColors.blueColor),
                  ),
                  16.widthBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppStyles.bold(title: docName, size: AppSizes.size18),
                        4.heightBox,
                        AppStyles.normal(
                          title: docSpeciality,
                          color: AppColors.textColor.withOpacity(0.6),
                          size: AppSizes.size14,
                        ),
                        8.heightBox,
                        Row(
                          children: [
                            Icon(Icons.star, color: AppColors.blueColor, size: 18),
                            4.widthBox,
                            AppStyles.bold(title: "4.7", size: AppSizes.size14),
                            16.widthBox,
                            Icon(Icons.location_on, 
                              color: AppColors.textColor.withOpacity(0.6), 
                              size: 18,
                            ),
                            4.widthBox,
                            AppStyles.normal(
                              title: "800m away",
                              color: AppColors.textColor.withOpacity(0.6),
                              size: AppSizes.size12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              24.heightBox,

              // Date Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppStyles.bold(title: "Date", size: AppSizes.size16),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: AppStyles.normal(
                      title: "Change",
                      color: AppColors.textColor.withOpacity(0.6),
                      size: AppSizes.size14,
                    ),
                  ),
                ],
              ),
              12.heightBox,
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.blueColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, 
                      color: AppColors.blueColor, 
                      size: 20,
                    ),
                    12.widthBox,
                    Expanded(
                      child: AppStyles.normal(
                        title: selectedDate,
                        size: AppSizes.size14,
                      ),
                    ),
                  ],
                ),
              ),
              24.heightBox,

              // Reason Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppStyles.bold(title: "Reason", size: AppSizes.size16),
                  GestureDetector(
                    onTap: () {},
                    child: AppStyles.normal(
                      title: "Change",
                      color: AppColors.textColor.withOpacity(0.6),
                      size: AppSizes.size14,
                    ),
                  ),
                ],
              ),
              12.heightBox,
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.blueColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, 
                      color: AppColors.blueColor, 
                      size: 20,
                    ),
                    12.widthBox,
                    AppStyles.normal(
                      title: "Chest pain",
                      size: AppSizes.size14,
                    ),
                  ],
                ),
              ),
              24.heightBox,

              // Payment Detail
              AppStyles.bold(title: "Payment Detail", size: AppSizes.size16),
              16.heightBox,
              _buildPaymentRow("Consultation", "\$60.00"),
              12.heightBox,
              _buildPaymentRow("Admin Fee", "\$01.00"),
              12.heightBox,
              _buildPaymentRow("Additional Discount", "-", isDiscount: true),
              16.heightBox,
              Divider(color: AppColors.textColor.withOpacity(0.2)),
              12.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppStyles.bold(title: "Total", size: AppSizes.size16),
                  AppStyles.bold(
                    title: "\$61.00",
                    size: AppSizes.size16,
                    color: AppColors.blueColor,
                  ),
                ],
              ),
              24.heightBox,

              // Payment Method
              AppStyles.bold(title: "Payment Method", size: AppSizes.size16),
              16.heightBox,
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.textColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: AppStyles.bold(
                            title: "VISA",
                            color: Colors.blue.shade900,
                            size: AppSizes.size14,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: AppStyles.normal(
                        title: "Change",
                        color: AppColors.textColor.withOpacity(0.6),
                        size: AppSizes.size14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppStyles.normal(
                  title: "Total",
                  color: AppColors.textColor.withOpacity(0.6),
                  size: AppSizes.size12,
                ),
                AppStyles.bold(
                  title: "\$ 61.00",
                  size: AppSizes.size20,
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: CustomButton(
                  buttonText: "Booking",
                  onTap: () {
                    Get.snackbar(
                      'Success',
                      'Appointment booked successfully!',
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentRow(String label, String amount, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppStyles.normal(
          title: label,
          color: AppColors.textColor.withOpacity(0.6),
          size: AppSizes.size14,
        ),
        AppStyles.normal(
          title: amount,
          size: AppSizes.size14,
        ),
      ],
    );
  }
}