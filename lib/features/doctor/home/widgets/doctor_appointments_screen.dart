import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointments_app/core/constants/app_assets.dart';
import 'package:doctor_appointments_app/core/constants/app_colors.dart';
import 'package:doctor_appointments_app/core/constants/app_strings.dart';
import 'package:doctor_appointments_app/core/firebase/firestore_services.dart';
import 'package:doctor_appointments_app/core/utils/text_styles.dart';
import 'package:doctor_appointments_app/features/patient/booking/data/appointment_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class DoctorAppointmentsScreen extends StatefulWidget {
  const DoctorAppointmentsScreen({super.key});

  @override
  State<DoctorAppointmentsScreen> createState() =>
      _DoctorAppointmentsScreenState();
}

class _DoctorAppointmentsScreenState extends State<DoctorAppointmentsScreen> {

  String _dateFormatter(DateTime date) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);
    return formattedDate;
  }

  String _timeFormatter(DateTime date) {
    String formattedTime = DateFormat('hh:mm').format(date);
    return formattedTime;
  }

  void showAlertDialog(BuildContext context, String docID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(AppStrings.deleteAppointment),
          ),
          content: Text(AppStrings.sureDelete),
          actions: [
            TextButton(
              child: Text(AppStrings.no),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(AppStrings.yes),
              onPressed: () async {
                await FirestoreServices.deleteAppointment(docID);
                context.pop();
              },
            ),
          ],
        );
      },
    ).then((value) => setState(() {}));
  }

  bool _compareDate(DateTime date) {
    if (_dateFormatter(DateTime.now()).compareTo(_dateFormatter(date)) == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: FirestoreServices.getDoctorAppointment(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          log(snapshot.error.toString());
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return snapshot.data!.docs.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.noUpcomingScheduleImage, width: 250),
                    Text(
                      AppStrings.noUpcomingAppointment,
                      style: TextStyles.getBody(),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  var appointment = AppointmentModel.fromJson(
                    snapshot.data!.docs[index].data() as Map<String, dynamic>,
                  );
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                    
                      children: [
                        const SizedBox(height: 15),
                    
                        Container(
                          width: double.infinity,
                          height: 200,
                    
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(4, 4),
                                blurRadius: 5,
                                color: AppColors.greyColor.withValues(alpha: .8),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            appointment.patientName ?? '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyles.getHeadLine1(
                                              fontSize: 18,
                                            ),
                                          ),
                    
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                size: 15,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  appointment.location ?? '',
                                                  style: TextStyles.getSmall(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow
                                                          .ellipsis, // Truncates with ..
                                                ),
                                              ),
                                            ],
                                          ),
                    
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.calendar_month_rounded,
                                                color: AppColors.primaryColor,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                _dateFormatter(
                                                  appointment.date ??
                                                      DateTime.now(),
                                                ),
                                                style: TextStyles.getBody(),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                _compareDate(
                                                      appointment.date ??
                                                          DateTime.now(),
                                                    )
                                                    ? AppStrings.today
                                                    : "",
                                                style: TextStyles.getBody(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                    
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.watch_later_outlined,
                                                color: AppColors.primaryColor,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                _timeFormatter(
                                                  appointment.date ??
                                                      DateTime.now(),
                                                ),
                                                style: TextStyles.getBody(),
                                              ),
                                            ],
                                          ),
                    
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor:
                                                    AppColors.whiteColor,
                                                backgroundColor:
                                                    AppColors.primaryColor,
                                              ),
                                              onPressed: () {
                                                showAlertDialog(
                                                  context,
                                                  snapshot.data!.docs[index].id,
                                                );
                                              },
                                              child: Text(
                                                AppStrings.deleteAppointment,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
        },
      ),
    );
  }
}
