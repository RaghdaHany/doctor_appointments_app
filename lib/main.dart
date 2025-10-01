import 'package:doctor_appointments_app/core/firebase/firestore_services.dart';
import 'package:doctor_appointments_app/core/routers/routes.dart';
import 'package:doctor_appointments_app/core/services/shared_pref.dart';
import 'package:doctor_appointments_app/core/utils/themes.dart';
import 'package:doctor_appointments_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPref.init();
  FirestoreServices.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme(),
      routerConfig: Routes.routers,
    );
  }
}
