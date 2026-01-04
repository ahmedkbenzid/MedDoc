import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'package:flutter_application_1/consts/lists.dart';
import 'package:flutter_application_1/consts/strings.dart';
import 'package:flutter_application_1/views/doctor_profile_view/doctor_profile_view.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.blueColor,
        title: AppStyles.bold(
          title: AppStrings.category,
          size: AppSizes.size18,
          color: AppColors. whiteColor
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            mainAxisExtent: 190,
          ),
          itemCount: iconsList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap:  () {
                // Navigate to doctor profile with matching category index
                Get.to(() => DoctorProfileView(doc: {
                  'docName': index < docsNameList.length ? docsNameList[index] : 'Doctor ${index + 1}',
                  'docCategory':  index < category.length ? category[index] : 'Specialist',
                  'docRating': (Random().nextDouble() * 2 + 3).toStringAsFixed(1),
                }));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.bgDarkColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:  CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment:  Alignment.center,
                      child: Image.asset(
                        iconsList[index], 
                        width: 60,
                        color: Vx.randomPrimaryColor
                      ),
                    ),
                    30.heightBox,
                    AppStyles.bold(
                      title: iconsTitleList[index],
                      color: AppColors.textColor,
                      size: AppSizes.size16
                    ),
                    10.heightBox,
                    AppStyles.normal(
                      title: "1 specialists",
                      color: AppColors.textColor.withOpacity(0.5),
                      size: AppSizes.size12,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      )
    );
  }
}