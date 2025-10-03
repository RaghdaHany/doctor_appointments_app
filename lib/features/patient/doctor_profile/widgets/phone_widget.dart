import 'package:doctor_appointments_app/core/constants/app_colors.dart';
import 'package:doctor_appointments_app/core/services/dial_services.dart';
import 'package:flutter/material.dart';

class PhoneWidget extends StatelessWidget {
  const PhoneWidget({super.key, required this.phone});

  final String phone;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.phone_in_talk_outlined),
        TextButton(
          child: Text(
            phone,
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: AppColors.blueColor,
              fontSize: 16,
              color: AppColors.blueColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            openDialer(phone);
          },
        ),
      ],
    );
  }
}
