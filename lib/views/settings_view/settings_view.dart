import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/lists.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.blueColor,
        title: AppStyles.bold(
          title: AppStrings.settings,
          size: AppSizes.size18,
          color: AppColors.whiteColor
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: CircleAvatar(child: Image.asset(AppAssets.imgSignup)),
            title: AppStyles.bold(title: "Username"),
            subtitle: AppStyles.normal(title: "user_email@gmail.com"),
          ),
          const Divider(),
          20.heightBox,
          ListView(
            shrinkWrap: true,
            children: List.generate(
              settingsList.length, 
              (index) => ListTile(
                onTap: () {
                  
                },
                leading: Icon(settingsListIcons[index], color: AppColors.blueColor,),
                title: AppStyles.bold(title: settingsList[index],),
              )
            ),
          ),
        ],
      ),
    );
  }
}