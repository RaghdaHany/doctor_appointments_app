import 'dart:io';

import 'package:doctor_appointments_app/components/buttons/main_button.dart';
import 'package:doctor_appointments_app/components/dialogs/loading_dialog.dart';
import 'package:doctor_appointments_app/components/inputs/phone_textFormField.dart';
import 'package:doctor_appointments_app/components/inputs/string_text_form_field.dart';
import 'package:doctor_appointments_app/core/constants/app_assets.dart';
import 'package:doctor_appointments_app/core/constants/app_colors.dart';
import 'package:doctor_appointments_app/core/constants/app_strings.dart';
import 'package:doctor_appointments_app/core/constants/specialization.dart';
import 'package:doctor_appointments_app/core/extensions/navigation.dart';
import 'package:doctor_appointments_app/core/routers/routes.dart';
import 'package:doctor_appointments_app/core/services/cloudinary_images.dart';
import 'package:doctor_appointments_app/core/utils/text_styles.dart';
import 'package:doctor_appointments_app/features/auth/data/models/doctor_data.dart';
import 'package:doctor_appointments_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:doctor_appointments_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class DoctorRegistrationScreen extends StatefulWidget {
  const DoctorRegistrationScreen({super.key});

  @override
  State<DoctorRegistrationScreen> createState() =>
      _DoctorRegistrationScreenState();
}

class _DoctorRegistrationScreenState extends State<DoctorRegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phone1 = TextEditingController();
  final TextEditingController _phone2 = TextEditingController();
  String _specialization = specialization[0];

  late String _startTime = DateFormat(
    'hh',
  ).format(DateTime(2023, 9, 7, 10, 00));
  late String _endTime = DateFormat('hh').format(DateTime(2023, 9, 7, 22, 00));

  String? _imagePath;
  File? file;
  String? profileUrl;

  String? userID;
  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    userID = FirebaseAuth.instance.currentUser!.uid;
  }

  Future<void> _pickImage() async {
    _getUser();
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        file = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.fillProfile)),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            context.pushToBase(Routes.doctorHomeRoute);
          } else if (state is AuthErrorState) {
            context.pop();
            showMainDialog(context, state.error);
          } else if (state is AuthLoadingState) {
            showLoadingDialog(context);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundColor: AppColors.primaryColor,
                            child: CircleAvatar(
                              radius: 75,
                              backgroundImage:
                                  (_imagePath != null)
                                      ? FileImage(File(_imagePath!))
                                      : const AssetImage(
                                        AppAssets.userImageSvg,
                                      ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: () async {
                                await _pickImage();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(AppAssets.editSVG),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                        child: Row(
                          children: [
                            Text(
                              AppStrings.specialization,
                              style: TextStyles.getBody(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          iconEnabledColor: AppColors.primaryColor,
                          icon: const Icon(Icons.expand_circle_down_outlined),
                          value: _specialization,
                          onChanged: (String? newValue) {
                            setState(() {
                              _specialization = newValue ?? specialization[0];
                            });
                          },
                          items:
                              specialization.map((element) {
                                return DropdownMenuItem(
                                  value: element,
                                  child: Text(element),
                                );
                              }).toList(),
                        ),
                      ),
                      const Gap(10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              AppStrings.bio,
                              style: TextStyles.getBody(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      StringTextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        controller: _bio,
                        hintText: AppStrings.bioHint,

                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.bioError;
                          } else {
                            return null;
                          }
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              AppStrings.address,
                              style: TextStyles.getBody(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      StringTextFormField(
                        keyboardType: TextInputType.text,
                        controller: _address,
                        maxLines: 3,
                        hintText: AppStrings.addressHint,

                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.addressError;
                          } else {
                            return null;
                          }
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    AppStrings.workingHours,
                                    style: TextStyles.getBody(
                                      fontSize: 15,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    AppStrings.to,
                                    style: TextStyles.getBody(
                                      fontSize: 15,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: StringTextFormField(
                              readOnly: true,
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  await showStartTimePicker();
                                },
                                icon: const Icon(
                                  Icons.watch_later_outlined,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              hintText: _startTime,
                            ),
                          ),
                          const SizedBox(width: 10),

                          Expanded(
                            child: StringTextFormField(
                              readOnly: true,
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  await showEndTimePicker();
                                },
                                icon: const Icon(
                                  Icons.watch_later_outlined,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              hintText: _endTime,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              AppStrings.phone1,
                              style: TextStyles.getBody(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PhoneTextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _phone1,

                        hintText: '+20xxxxxxxxxx',

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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              AppStrings.phone2,
                              style: TextStyles.getBody(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PhoneTextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _phone2,
                        hintText: '+20xxxxxxxxxx',

                        validator: (value) {
                          if (value!.isNotEmpty && value.length < 11) {
                            return AppStrings.errorPhoneValidation;
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(top: 25.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: MainButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                if (file != null) {
                  profileUrl = await uploadImageToCloudinary(File(file!.path));
                }
                context.read<AuthCubit>().registerDoctorData(
                  DoctorData(
                    uid: userID,
                    image: profileUrl,
                    phone1: _phone1.text,
                    phone2: _phone2.text,
                    address: _address.text,
                    specialization: _specialization,
                    openHour: _startTime,
                    closeHour: _endTime,
                    bio: _bio.text,
                  ),
                );
              } 
            },
            text: AppAssets.register,
          ),
        ),
      ),
    );
  }

  Future<void> showStartTimePicker() async {
    final MaterialLocalizations localizations = MaterialLocalizations.of(
      context,
    );

    final startTimePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (startTimePicked != null) {
      final String formattedStartTime = localizations.formatTimeOfDay(
        startTimePicked,
        alwaysUse24HourFormat: false,
      );
      setState(() {
        _startTime = formattedStartTime.toString();
      });
    }
  }

  Future<void> showEndTimePicker() async {
    final MaterialLocalizations localizations = MaterialLocalizations.of(
      context,
    );

    final endTimePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (endTimePicked != null) {
      final String formattedEndTime = localizations.formatTimeOfDay(
        endTimePicked,
        alwaysUse24HourFormat: false,
      );
      setState(() {
        _endTime = formattedEndTime.toString();
      });
    }
  }
}
