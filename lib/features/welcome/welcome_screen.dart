import 'package:doctor_appointments_app/components/buttons/main_button.dart';
import 'package:doctor_appointments_app/core/constants/app_assets.dart';
import 'package:doctor_appointments_app/core/constants/app_colors.dart';
import 'package:doctor_appointments_app/core/constants/app_strings.dart';
import 'package:doctor_appointments_app/core/extensions/navigation.dart';
import 'package:doctor_appointments_app/core/routers/routes.dart';
import 'package:doctor_appointments_app/core/utils/text_styles.dart';
import 'package:doctor_appointments_app/features/auth/data/models/user_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (Stack(
        children: [
          PositionedDirectional(
            top: 100,
            start: 15,
            end: 15,

            child: Column(
              children: [
                SvgPicture.asset(AppAssets.logoTransparentSVG),

                Gap(15),

                Text(AppStrings.welcomeMsg, style: TextStyles.getHeadLine2()),
                Gap(15),

                Text(
                  AppStrings.welcomeMsgBook,
                  style: TextStyles.getHeadLine1(),
                ),
              ],
            ),
          ),

          PositionedDirectional(
            bottom: 50,
            start: 15,
            end: 15,

            child: Column(
              children: [
                Text(AppStrings.loginAs, style: TextStyles.getHeadLine1(),),
                Gap(20),
                MainButton(
                  text: AppStrings.doctor,
                  onPressed: () {
                    context.pushWithExtra(
                      Routes.loginRoute,
                      extra: UserType.doctor,
                    );
                  },
                ),

                Gap(10),

                MainButton(
                  text: AppStrings.patient,
                  onPressed: () {
                    context.pushWithExtra(
                      Routes.loginRoute,
                      extra: UserType.patient,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
