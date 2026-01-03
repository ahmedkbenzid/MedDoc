import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';
import 'package:flutter_application_1/consts/fonts.dart';
import 'package:flutter_application_1/res/components/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Contrôleurs pour récupérer les valeurs
    final TextEditingController nameController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();
    final TextEditingController hoursController = TextEditingController();
    final TextEditingController servicesController = TextEditingController();
    final TextEditingController contactController = TextEditingController();
    final TextEditingController addressController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: AppStyles.bold(title: "Edit Profile", color: AppColors.whiteColor, size: 18),
        backgroundColor: AppColors.blueColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Nom
              AppStyles.bold(title: "Full Name"),
              TextField(controller: nameController, decoration: InputDecoration(hintText: "Dr. John Doe")),
              10.heightBox,
              // Catégorie
              AppStyles.bold(title: "Category"),
              TextField(controller: categoryController, decoration: InputDecoration(hintText: "Cardiologist")),
              10.heightBox,
              // Horaires
              AppStyles.bold(title: "Working Hours"),
              TextField(controller: hoursController, decoration: InputDecoration(hintText: "Mon - Fri | 09:00 AM - 05:00 PM")),
              10.heightBox,
              // Services
              AppStyles.bold(title: "Services"),
              TextField(controller: servicesController, decoration: InputDecoration(hintText: "Cardiology consultations, Heart check-ups")),
              10.heightBox,
              // Contact
              AppStyles.bold(title: "Contact"),
              TextField(controller: contactController, decoration: InputDecoration(hintText: "+216 55 333 000")),
              10.heightBox,
              // Adresse
              AppStyles.bold(title: "Address"),
              TextField(controller: addressController, decoration: InputDecoration(hintText: "123 Medical Street, Tunis")),
              20.heightBox,
              CustomButton(
                buttonText: "Save Changes",
                onTap: () {
                  // Logique pour sauvegarder les modifications (Firebase ou local)
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
