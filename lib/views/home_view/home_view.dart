import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/lists.dart';
import 'package:flutter_application_1/res/components/custum_textfield.dart';
import 'package:flutter_application_1/views/doctor_profile_view/doctor_profile_view.dart';
import 'package:get/route_manager.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(title: "${AppStrings.welcome} User", color: AppColors.whiteColor,size: AppSizes.size18),
        backgroundColor: AppColors.blueColor,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            color: AppColors.blueColor,
            child: Row(
              children: [
                Expanded(
                  child: CustumTextfield(
                    hint: AppStrings.search,
                    textColor: AppColors.whiteColor,
                    borderColor: AppColors.whiteColor,
                  ),
                ),
                10.widthBox,
                IconButton(
                  onPressed: () {}, 
                  icon:Icon(
                    Icons.search, 
                    color: AppColors.whiteColor))
              ],
            ),
          ),
          20.heightBox,
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                  width: 250,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index){
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(12),
                          margin: const EdgeInsets.only(right: 8),
                          child: Column(
                            children: [
                              Image.asset(
                                iconsList[index],
                              width: 30
                              ,color: AppColors.whiteColor,
                              ),
                              5.heightBox,
                              AppStyles.normal(
                                title: iconsTitleList[index],
                                color: AppColors.whiteColor ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                20.heightBox,
                Align(
                  alignment: Alignment.centerLeft,
                  child:AppStyles.bold(title: "Popular Doctors", color: AppColors.blueColor, size: AppSizes.size18)

                ),
                10.heightBox,
                SizedBox(
                  height: 150,
                child: SingleChildScrollView(
  physics: const BouncingScrollPhysics(),
  child: Wrap(
    spacing: 8,        // espace horizontal
    runSpacing: 8,    // espace vertical (retour à la ligne)
    children: List.generate(3, (index) {
      return GestureDetector(
        onTap: () {
          Get.to(() => DoctorProfileView(doc: {
            'docName': docsNameList[index],
            'docCategory': category[index],
            'docRating': '4.7', // You can replace this with actual rating if available
          }));
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppColors.bgDarkColor,
            borderRadius: BorderRadius.circular(12),
          ),
          height: 150,
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  color: AppColors.blueColor,
                  child: Image.asset(
                    docsList[index],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              AppStyles.normal(
                title: docsNameList[index],
                alignment: TextAlign.center,
              ),
              AppStyles.normal(
                alignment: TextAlign.center,
                title: category[index],
                color: Colors.black54,
              ),
            ],
          ),
        ),
      );
    }),
  ),
),

                ),
                5.heightBox,
                GestureDetector(
                  onTap: (){},
                  child: Align(
                    alignment: Alignment.centerRight,
                    child:  AppStyles.normal(title: "view all"),
                  ),
                ),
                20.heightBox,
                Row(
                  children: List.generate(4, (index) => Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.blueColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 100,
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.icBody,
                          width: 25,
                          color: AppColors.whiteColor,

                        ),
                        5.heightBox,
                        AppStyles.normal(title: "Lab Tests", color: AppColors.whiteColor),
                      ],
                    ),
                  )),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}