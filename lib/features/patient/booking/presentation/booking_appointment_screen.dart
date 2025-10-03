import 'package:doctor_appointments_app/features/auth/data/models/doctor_data.dart';
import 'package:flutter/material.dart';

class BookingAppointmentScreen extends StatefulWidget {
  const BookingAppointmentScreen({super.key, required this.doctorData});
  final DoctorData doctorData;

  @override
  State<BookingAppointmentScreen> createState() => _BookingAppointmentScreenState();
}

class _BookingAppointmentScreenState extends State<BookingAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}