import 'package:doctor_appointments_app/components/buttons/main_button.dart';
import 'package:doctor_appointments_app/core/constants/app_assets.dart';
import 'package:doctor_appointments_app/core/constants/app_colors.dart';
import 'package:doctor_appointments_app/core/constants/app_strings.dart';
import 'package:doctor_appointments_app/core/extensions/navigation.dart';
import 'package:doctor_appointments_app/core/routers/routes.dart';
import 'package:doctor_appointments_app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum DialogType { success, error }

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withValues(alpha: .4),
    builder: (context) => Lottie.asset(AppAssets.loading),
  );
}

showMainDialog(
  BuildContext context,
  String message, [
  DialogType type = DialogType.error,
]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: type == DialogType.success ? Colors.green : Colors.red,
      content: Text(message),
    ),
  );
}

void showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      alignment: Alignment.center,
      backgroundColor: AppColors.whiteColor,
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Text(
        AppStrings.appointmentBooked,
        textAlign: TextAlign.center,
        style: TextStyles.getTitle(color: AppColors.primaryColor),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MainButton(
              width: 100,
              height: 35,
              onPressed: () {
                context.pushToBase(Routes.patientMainRoute);
              },
              text: AppStrings.ok,
            ),
          ],
        ),
      ],
    ),
  );
}