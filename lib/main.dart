import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/consts.dart';
import 'package:flutter_application_1/consts/supabase_config.dart';
import 'package:flutter_application_1/controllers/appointment_controller.dart';
import 'package:flutter_application_1/views/login_view/login_view.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
  );
  
  // Initialiser le contrôleur globalement
  Get.put(AppointmentController());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: AppFonts.nunito) ,
      debugShowCheckedModeBanner: false,
      home: const LoginView(),
    );
  }
  
}

