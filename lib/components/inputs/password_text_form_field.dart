import 'package:doctor_appointments_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = true,
  });

  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText ;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },

      style: const TextStyle(color: AppColors.primaryColor),

      validator: validator,
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.deny(RegExp(r'^\s+')),
      ],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),

        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.darkGreyColor),

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        // suffixIconConstraints: BoxConstraints(maxWidth: 50),
      ),
    );
  }
}
