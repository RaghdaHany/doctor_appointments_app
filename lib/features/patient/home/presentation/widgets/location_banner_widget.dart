import 'package:doctor_appointments_app/core/constants/app_assets.dart';
import 'package:doctor_appointments_app/core/constants/app_colors.dart';
import 'package:doctor_appointments_app/core/constants/app_strings.dart';
import 'package:doctor_appointments_app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LocationBannerWidget extends StatelessWidget {
  const LocationBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},

      child: Container(
        width: double.infinity,
        height: 140,
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.locationBannerTextOne,
                        style: TextStyles.getHeadLine1(
                          color: AppColors.primaryColor,
                          fontSize: 15,
                        ),
                      ),

                      Text(
                        AppStrings.locationBannerTextTwo,
                        style: TextStyles.getBody(
                          color: AppColors.primaryColor,
                          fontSize: 15,
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primaryColor,  //text color
                          elevation: 2,
                          backgroundColor: AppColors.skyBlueColor,  //button background color
                        ),
                        child: Text(
                          AppStrings.locationBannerTextThree,

                          style: TextStyles.getBody(
                            color: AppColors.primaryColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Gap(15),

                  Image.asset(
                    AppAssets.locationBannerImage,
                    width: 100,
                    height: 100,
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
