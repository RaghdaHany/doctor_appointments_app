import 'dart:io';
import 'package:doctor_appointments_app/core/constants/app_assets.dart';
import 'package:doctor_appointments_app/core/constants/app_colors.dart';
import 'package:doctor_appointments_app/core/constants/app_strings.dart';
import 'package:doctor_appointments_app/core/extensions/navigation.dart';
import 'package:doctor_appointments_app/core/firebase/firestore_services.dart';
import 'package:doctor_appointments_app/core/routers/routes.dart';
import 'package:doctor_appointments_app/core/services/cloudinary_images.dart';
import 'package:doctor_appointments_app/core/services/shared_pref.dart';
import 'package:doctor_appointments_app/features/auth/data/models/doctor_data.dart';
import 'package:doctor_appointments_app/features/patient/profile/widgets/profile_menu_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  String? userId;
  File? file;
  String? profileUrl;

  Future<void> _getUser() async {
    userId = FirebaseAuth.instance.currentUser?.uid;
  }

  Future _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> _pickImage() async {
    _getUser();
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        file = File(pickedFile.path);
      });
    }

    if (file != null) {
      profileUrl = await uploadImageToCloudinary(File(file!.path));

      FirestoreServices.updateDoctor(
        DoctorData(uid: userId, image: profileUrl),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.profile),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primaryColor,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: FirestoreServices.getDoctorProfileById(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            var userData = DoctorData.fromJson(
              snapshot.data?.data() as Map<String, dynamic>,
            );

            return Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.primaryColor,
                        child: CircleAvatar(
                          backgroundColor: AppColors.whiteColor,
                          radius: 58,
                          backgroundImage:
                              (userData.image != null)
                                  ? NetworkImage(userData.image ?? '')
                                  : const AssetImage(AppAssets.userImageSvg),
                        ),
                      ),
                      Positioned(
                        bottom: -2,
                        right: -2,
                        child: GestureDetector(
                          onTap: () async {
                            await _pickImage();
                          },
                          child: Container(
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: SvgPicture.asset(AppAssets.editSVG),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  userData.name ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  userData.phone1 ?? '',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),

                Expanded(
                  child: ListView(
                    children: [
                      ProfileMenuItem(
                        icon: Icons.person_outline,
                        text: "Edit Profile",
                        onTap: () {
                          context.pushTo(Routes.editDoctorProfileRoute);
                        },
                      ),

                      ProfileMenuItem(
                        icon: Icons.settings_outlined,
                        text: "Settings",
                        onTap: () {},
                      ),

                      ProfileMenuItem(
                        icon: Icons.logout,
                        text: "Log Out",
                        onTap: () {
                          SharedPref.clear();
                          _signOut();
                          context.pushToBase(Routes.welcome);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
