import 'package:doctor_appointments_app/core/constants/app_assets.dart';
import 'package:doctor_appointments_app/core/constants/app_colors.dart';
import 'package:doctor_appointments_app/core/constants/app_strings.dart';
import 'package:doctor_appointments_app/core/services/whatsapp_launcher.dart';
import 'package:doctor_appointments_app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ContactingBannerWidget extends StatelessWidget {
  const ContactingBannerWidget({super.key});

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
                        AppStrings.contactingBannerTextOne,
                        style: TextStyles.getHeadLine1(
                          color: AppColors.primaryColor,
                          fontSize: 15,
                        ),
                      ),

                      Text(
                        AppStrings.contactingBannerTextTwo,
                        style: TextStyles.getBody(
                          color: AppColors.primaryColor,
                          fontSize: 15,
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          sendWhatsAppMessage('01282177436', 'Is Anyone available for chat?');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primaryColor,  //text color
                          elevation: 2,
                          backgroundColor: AppColors.skyBlueColor,  //button background color
                        ),
                        child: Text(
                          AppStrings.contactingBannerTextThree,

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
                    AppAssets.contactingBannerImage,
                    width: 120,
                    height: 120,
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
