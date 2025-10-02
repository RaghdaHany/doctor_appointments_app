import 'package:doctor_appointments_app/core/constants/app_assets.dart';
import 'package:doctor_appointments_app/core/constants/app_colors.dart';
import 'package:doctor_appointments_app/core/constants/app_strings.dart';
import 'package:doctor_appointments_app/core/routers/routes.dart';
import 'package:doctor_appointments_app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorBannerWidget extends StatelessWidget {
  const DoctorBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushReplacement(Routes.doctorProfileRoute);
      },
      child: Container(
        width: double.infinity,
        height: 120,
        margin: const EdgeInsets.only(left: 15, bottom: 15, top: 10, right: 15),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              offset: const Offset(4, 4),
              blurRadius: 5,
              color: AppColors.greyColor.withValues(alpha: .8),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    AppAssets.doctorBannerImage,
                    width: 110,
                    height: 110,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.doctorBannerTextOne,
                        style: TextStyles.getBody(color: AppColors.primaryColor, fontSize: 15),
                      ),
      
                       Text(
                        AppStrings.doctorBannerTextTwo,
                        style: TextStyles.getBody(color: AppColors.primaryColor, fontSize: 15)
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
