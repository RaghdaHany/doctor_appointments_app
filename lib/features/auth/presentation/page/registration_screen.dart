import 'package:doctor_appointments_app/components/buttons/main_button.dart';
import 'package:doctor_appointments_app/components/dialogs/loading_dialog.dart';
import 'package:doctor_appointments_app/components/inputs/password_text_form_field.dart';
import 'package:doctor_appointments_app/components/inputs/phone_textFormField.dart';
import 'package:doctor_appointments_app/components/inputs/string_text_form_field.dart';
import 'package:doctor_appointments_app/core/constants/app_assets.dart';
import 'package:doctor_appointments_app/core/constants/app_colors.dart';
import 'package:doctor_appointments_app/core/constants/app_strings.dart';
import 'package:doctor_appointments_app/core/extensions/navigation.dart';
import 'package:doctor_appointments_app/core/extensions/validations.dart';
import 'package:doctor_appointments_app/core/routers/routes.dart';
import 'package:doctor_appointments_app/core/utils/text_styles.dart';
import 'package:doctor_appointments_app/features/auth/data/models/user_type.dart';
import 'package:doctor_appointments_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:doctor_appointments_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.userType});

  final UserType userType;
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          if (widget.userType == UserType.doctor) {
            context.pushToBase(Routes.doctorRegisterRoute);
          } else {
            context.pushToBase(Routes.patientMainRoute);
          }
        } else if (state is AuthErrorState) {
          context.pop();
          showMainDialog(context, state.error);
        } else if (state is AuthLoadingState) {
          showLoadingDialog(context);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gap(70),
                  SvgPicture.asset(
                    AppAssets.logoTransparentSVG,
                    width: 70,
                    height: 70,
                  ),
                  Gap(5),
                  Text(AppStrings.appName, style: TextStyles.getHeadLine2()),
                  Gap(30),
                  Text(
                    AppStrings.createAccount,
                    style: TextStyles.getHeadLine1(),
                  ),
                  Gap(5),

                  Text(
                    AppStrings.registrationMsgText,
                    style: TextStyles.getBody(),
                  ),
                  Gap(60),

                  StringTextFormField(
                    keyboardType: TextInputType.name,
                    controller: _nameController,
                    hintText: AppStrings.nameHintText,
                    prefixIcon: IconButton(
                      onPressed: null,
                      icon: SvgPicture.asset(AppAssets.userSVG),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return AppStrings.emptyNameValidation;
                      return null;
                    },
                  ),

                  Gap(15),
                  StringTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    hintText: AppStrings.emailHintText,
                    prefixIcon: IconButton(
                      onPressed: null,
                      icon: SvgPicture.asset(AppAssets.emailSVG),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStrings.emptyEmailValidation;
                      } else if (!isEmailValid(value)) {
                        return AppStrings.errorEmailValidation;
                      } else {
                        return null;
                      }
                    },
                  ),

                  Gap(15),
                  PasswordTextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    hintText: AppStrings.passwordHintText,
                    obscureText: isVisible,
                    prefixIcon: IconButton(
                      onPressed: null,
                      icon: SvgPicture.asset(AppAssets.lockSVG),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: Icon(
                        (!isVisible)
                            ? Icons.remove_red_eye
                            : Icons.visibility_off_rounded,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStrings.emptyPasswordValidation;
                      } else if (value.length < 8) {
                        return AppStrings.lessThanEightPasswordValidation;
                      }
                      return null;
                    },
                  ),
                  Gap(15),
                  PhoneTextFormField(
                    keyboardType: TextInputType.phone,
                    controller: _phoneNumberController,
                    hintText: AppStrings.phoneHintText,
                    prefixIcon: IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.phone_in_talk_outlined,
                        color: AppColors.darkGreyColor,
                        size: 20,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStrings.emptyPhoneValidation;
                      } else if (value.length < 11) {
                        return AppStrings.errorPhoneValidation;
                      } else {
                        return null;
                      }
                    },
                  ),

                  const Gap(20),
                  MainButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().register(
                          widget.userType,
                          _nameController.text,
                          _emailController.text,
                          _passwordController.text,
                          _phoneNumberController.text,
                        );
                      }
                    },
                    text: (AppStrings.signUp),
                  ),

                  Gap(30),

                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.doHaveAccount,
                          style: TextStyles.getBody(
                            color: AppColors.darkGreyColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.pushWithReplacement(
                              Routes.loginRoute,
                              extra: widget.userType,
                            );
                          },
                          child: Text(
                            AppStrings.signIn,
                            style: TextStyles.getBody(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
