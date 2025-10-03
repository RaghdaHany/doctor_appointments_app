import 'package:doctor_appointments_app/core/constants/app_assets.dart';
import 'package:doctor_appointments_app/core/constants/app_colors.dart';
import 'package:doctor_appointments_app/core/constants/app_strings.dart';
import 'package:doctor_appointments_app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class WelcomingWidget extends StatelessWidget {
  const WelcomingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      margin: const EdgeInsets.only(left: 15, bottom: 15, top: 10, right: 15),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            offset: const Offset(5, 5),
            blurRadius: 25,
            color: AppColors.greyColor.withValues(alpha: .8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.welcome,
                      style: TextStyles.getHeadLine1(),
                    ),
        
                    Text(
                      AppStrings.homeTextOne,
                      style: TextStyles.getHeadLine2(),
                    ),
        
                     Text(
                      AppStrings.homeTextTwo,
                      style: TextStyles.getHeadLine2(),
                    ),
                  ],
                ),
        
                Image.asset(AppAssets.noAppointment, width: 80, height: 80),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
