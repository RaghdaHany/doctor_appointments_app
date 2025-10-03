
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointments_app/core/constants/app_assets.dart';
import 'package:doctor_appointments_app/core/constants/app_strings.dart';
import 'package:doctor_appointments_app/core/firebase/firestore_services.dart';
import 'package:doctor_appointments_app/core/utils/text_styles.dart';
import 'package:doctor_appointments_app/features/auth/data/models/doctor_data.dart';
import 'package:doctor_appointments_app/features/patient/home/presentation/widgets/booking_banner_widget.dart';
import 'package:doctor_appointments_app/features/patient/home/presentation/widgets/contacting_banner_widget.dart';
import 'package:doctor_appointments_app/features/patient/home/presentation/widgets/doctor_banner_widget.dart';
import 'package:doctor_appointments_app/features/patient/home/presentation/widgets/no_upcoming_appointments_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: FirestoreServices.getDoctorData(),
          builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppAssets.noSearchSVG, width: 250),
                      Text(
                        AppStrings.noDoctorAvailable,
                        style: TextStyles.getBody(),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              DoctorData doctor = DoctorData.fromJson(
                snapshot.data!.docs[0].data() as Map<String, dynamic>,
              );

              log(doctor.email.toString());
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(50),
                    NoUpcomingAppointmentsWidget(),
                    DoctorBannerWidget(doctorData: doctor,),
                    BookingBannerWidget(doctorData: doctor),
                    ContactingBannerWidget(doctorData: doctor,),
                    // LocationBannerWidget(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
