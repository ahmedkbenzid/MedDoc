import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'package:flutter_application_1/res/components/custom_button.dart';
import 'package:flutter_application_1/views/book_appointment_view/book_appointment_view.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class DoctorProfileView extends StatelessWidget {
  const DoctorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.blueColor,
        title: AppStyles.bold(
          title: "Doctor Name",
          size: AppSizes.size18,
          color: AppColors.whiteColor
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: Image.asset(AppAssets.imgSignup),
                    ),
                    10.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppStyles.bold(title: "Doctor Name",size: AppSizes.size14,color: AppColors.textColor),
                          AppStyles.bold(title: "Category",size: AppSizes.size14,color: AppColors.textColor.withOpacity(0.5)),
                          const Spacer(),
                          VxRating(
                            selectionColor: AppColors.yellowColor,
                            onRatingUpdate: (value){},
                            maxRating: 5,
                            count: 5,
                            value: 4,
                            stepInt: true,
                      
                          )
                        ],
                      ),
                    ),
                    AppStyles.bold(title: "See all reviews",size: AppSizes.size12,color: AppColors.blueColor),
                  ],
                ),
              ),
              10.heightBox,
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.whiteColor,
          
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: AppStyles.bold(title: "Phone Number", color: AppColors.textColor,),
                      subtitle: AppStyles.normal(
                        title: "+216 55 333 000", 
                        color: AppColors.textColor.withOpacity(0.5),
                        size: AppSizes.size12
                      ),
                      trailing: Container(
                        width: 50,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.yellowColor,
                        ),
                        child: Icon(
                          Icons.phone, 
                          color: AppColors.whiteColor,
                        )
                      ),
                    ),
                    10.heightBox,
                    AppStyles.bold(title: "About", color: AppColors.textColor,size: AppSizes.size16),
                    5.heightBox,
                    AppStyles.normal(title: "This is the about section of a doctor", color: AppColors.textColor.withOpacity(0.5), size: AppSizes.size12),
                    10.heightBox,
                    AppStyles.bold(title: "Address", color: AppColors.textColor,size: AppSizes.size16),
                    5.heightBox,
                    AppStyles.normal(title: "Address of a doctor", color: AppColors.textColor.withOpacity(0.5), size: AppSizes.size12),
                    10.heightBox,
                    AppStyles.bold(title: "Working Time", color: AppColors.textColor,size: AppSizes.size16),
                    5.heightBox,
                    AppStyles.normal(title: "09:00 AM to 12:00 PM", color: AppColors.textColor.withOpacity(0.5), size: AppSizes.size12),
                    10.heightBox,
                    AppStyles.bold(title: "Services", color: AppColors.textColor,size: AppSizes.size16),
                    5.heightBox,
                    AppStyles.normal(title: "This is the service section of a doctor", color: AppColors.textColor.withOpacity(0.5), size: AppSizes.size12),
                    10.heightBox,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomButton(
          onTap: (){
            Get.to(() => BookAppointmentView());
          } , 
          buttonText: "Book an appointment",
        ),
      ),
    );
  }
}