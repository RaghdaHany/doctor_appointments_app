import 'package:doctor_appointments_app/core/constants/app_assets.dart';
import 'package:doctor_appointments_app/core/constants/app_colors.dart';
import 'package:doctor_appointments_app/features/patient/appointments/patient_appointments_screen.dart';
import 'package:doctor_appointments_app/features/patient/home/presentation/page/patient_home_screen.dart';
import 'package:doctor_appointments_app/features/patient/profile/patient_profile_screen.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PatientMainScreen extends StatefulWidget {
  const PatientMainScreen({super.key});

  @override
  State<PatientMainScreen> createState() => _PatientMainScreenState();
}

class _PatientMainScreenState extends State<PatientMainScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    PatientHomeScreen(),
    PatientAppointmentsScreen(),
    PatientProfileScreen(),
    // ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.borderColor)),
          color: AppColors.whiteColor,
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                AppAssets.homeIconSVG,
                colorFilter: ColorFilter.mode(
                  AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
              icon: SvgPicture.asset(AppAssets.homeIconSVG),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                AppAssets.calenderIconSVG,
                colorFilter: ColorFilter.mode(
                  AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
              icon: SvgPicture.asset(AppAssets.calenderIconSVG),
              label: 'Appointments' ,
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                AppAssets.profileIconSVG,
                colorFilter: ColorFilter.mode(
                  AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
              icon: SvgPicture.asset(AppAssets.profileIconSVG),
              label: 'Profile',
            )
          ],
        ),
      ),
    );
  }
}