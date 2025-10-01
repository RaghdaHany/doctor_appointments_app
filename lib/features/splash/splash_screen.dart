import 'package:doctor_appointments_app/core/constants/app_assets.dart';
import 'package:doctor_appointments_app/core/constants/app_colors.dart';
import 'package:doctor_appointments_app/core/constants/app_fonts.dart';
import 'package:doctor_appointments_app/core/extensions/navigation.dart';
import 'package:doctor_appointments_app/core/routers/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // bool isLoggedIn = SharedPref.getUserId().isNotEmpty;
    // bool isOnboardingShown = SharedPref.getBool(SharedPref.kOnboardingShown);
    
    Future.delayed(const Duration(seconds: 3), () {
      // if (isLoggedIn) {
      // } else {
      //   if (isOnboardingShown) {
      //   } else {
      //   }
      // }
      context.pushWithReplacement(Routes.welcome);
    });
    super.initState();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
         SvgPicture.asset(AppAssets.logoSVG, width: 100 , height: 150),
         Gap(10),
         Text("BookDoc" , style: TextStyle(color: Colors.white , fontSize: 20 , fontWeight: FontWeight.bold , fontFamily: AppFonts.cairoFamily),)

        ])
     ) );
  }
}