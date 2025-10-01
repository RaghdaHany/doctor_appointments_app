
import 'package:doctor_appointments_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StringTextFormField extends StatelessWidget {
  const StringTextFormField({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.prefixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.suffixIcon,
    this.maxLines ,
  });

  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      readOnly: readOnly,
      maxLines: maxLines,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },

      style: const TextStyle(color: AppColors.primaryColor),

      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'^\s+'))],
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),

      hintText: hintText,
      hintStyle: TextStyle(color: AppColors.darkGreyColor),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    
      // prefixIconConstraints: BoxConstraints(maxWidth: 50),
      ),
    );
  }
}
