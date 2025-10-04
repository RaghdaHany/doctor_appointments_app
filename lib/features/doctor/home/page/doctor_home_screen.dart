import 'package:doctor_appointments_app/core/constants/app_colors.dart';
import 'package:doctor_appointments_app/core/constants/app_strings.dart';
import 'package:doctor_appointments_app/core/extensions/navigation.dart';
import 'package:doctor_appointments_app/core/routers/routes.dart';
import 'package:doctor_appointments_app/core/services/shared_pref.dart';
import 'package:doctor_appointments_app/features/doctor/home/widgets/doctor_appointments_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
   Future _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: const Icon(Icons.logout, color: AppColors.primaryColor),
            onPressed: () {
              SharedPref.clear();
              _signOut();
              context.pushToBase(Routes.welcome);
            },
          ),
        ),
        title: Text(AppStrings.appointmentTime),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: DoctorAppointmentsScreen(),
      ),
    );
  }
}
