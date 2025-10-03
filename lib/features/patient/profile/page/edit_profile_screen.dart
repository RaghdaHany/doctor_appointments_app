import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointments_app/components/buttons/main_button.dart';
import 'package:doctor_appointments_app/core/constants/app_assets.dart';
import 'package:doctor_appointments_app/core/constants/app_colors.dart';
import 'package:doctor_appointments_app/core/constants/app_strings.dart';
import 'package:doctor_appointments_app/core/utils/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  List labelName = ["name", "phone", ];

  List value = ["name", "phone", ];

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Text(AppStrings.editProfile),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('patients')
              .doc(user!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            var userData = snapshot.data;
            return ListView(
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                labelName.length,
                (index) => InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        var con = TextEditingController(
                          text:
                              userData?[value[index]] == '' ||
                                  userData?[value[index]] == null
                              ? ''
                              : userData?[value[index]],
                        );
                        var form = GlobalKey<FormState>();
                        return SimpleDialog(
                          alignment: Alignment.center,
                          contentPadding: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          children: [
                            Form(
                              key: form,
                              child: Column(
                                children: [
                                  Text(
                                    'Enter ${labelName[index]}',
                                    style: TextStyles.getBody(
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: con,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.whiteColor,
                                    ),
                                   
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Enter ${labelName[index]}.';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  MainButton(
                                    text: AppAssets.saveEdits,
                                    onPressed: () {
                                      if (form.currentState!.validate()) {
                                        updateData(value[index], con.text);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 16,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.primaryColor),
                      color: AppColors.whiteColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          labelName[index],
                          style: TextStyles.getHeadLine1(
                            fontSize: 15,
                          ),
                        ),
                        Gap(10),
                        Text(
                          userData?[value[index]] == '' ||
                                  userData?[value[index]] == null
                              ? 'Not Added'
                              : userData?[value[index]],
                          style: TextStyles.getBody(),
                        ),

                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> updateData(String key, value) async {
    FirebaseFirestore.instance.collection('patients').doc(user!.uid).update({
      key: value,
    });
    if (key == "name") {
      await user?.updateDisplayName(value);
    }
    Navigator.pop(context);
  }
}