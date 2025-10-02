import 'package:doctor_appointments_app/features/patient/home/presentation/widgets/booking_banner_widget.dart';
import 'package:doctor_appointments_app/features/patient/home/presentation/widgets/contacting_banner_widget.dart';
import 'package:doctor_appointments_app/features/patient/home/presentation/widgets/doctor_banner_widget.dart';
import 'package:doctor_appointments_app/features/patient/home/presentation/widgets/no_upcoming_appointments_widget.dart';
import 'package:flutter/material.dart';
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
      body: SingleChildScrollView(
        child: Column(children: [
          Gap(50), 
          NoUpcomingAppointmentsWidget(),
          DoctorBannerWidget(),
          BookingBannerWidget(),
          ContactingBannerWidget(),
          // LocationBannerWidget(),
          ]),
      ),
    );
  }
}
