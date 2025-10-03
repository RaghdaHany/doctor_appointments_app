import 'package:doctor_appointments_app/components/buttons/main_button.dart';
import 'package:doctor_appointments_app/components/dialogs/loading_dialog.dart';
import 'package:doctor_appointments_app/components/inputs/phone_textFormField.dart';
import 'package:doctor_appointments_app/components/inputs/string_text_form_field.dart';
import 'package:doctor_appointments_app/core/constants/app_colors.dart';
import 'package:doctor_appointments_app/core/constants/app_strings.dart';
import 'package:doctor_appointments_app/core/firebase/firestore_services.dart';
import 'package:doctor_appointments_app/core/services/shared_pref.dart';
import 'package:doctor_appointments_app/core/utils/text_styles.dart';
import 'package:doctor_appointments_app/features/auth/data/models/doctor_data.dart';
import 'package:doctor_appointments_app/features/patient/booking/data/appointment_data.dart';
import 'package:doctor_appointments_app/features/patient/booking/data/available_slots.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingAppointmentScreen extends StatefulWidget {
  const BookingAppointmentScreen({super.key, required this.doctorData});

  final DoctorData doctorData;

  @override
  State<BookingAppointmentScreen> createState() =>
      _BookingAppointmentScreenState();
}

class _BookingAppointmentScreenState extends State<BookingAppointmentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String? dateUTC;
  String? bookingHour;

  int selectedSlot = -1;
  List<int> times = [];

  Future<void> getAvailableTimes(DateTime selectedDate) async {
    times = getAvailableAppointments(
      selectedDate,
      widget.doctorData.openHour ?? "0",
      widget.doctorData.closeHour ?? "0",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        foregroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(
          AppStrings.bookAppointment,
          style: TextStyles.getHeadLine1(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            AppStrings.patientName,
                            style: TextStyles.getBody(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    StringTextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) return AppStrings.enterPatientName;
                        return null;
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            AppStrings.patientAge,
                            style: TextStyles.getBody(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    PhoneTextFormField(
                      keyboardType: TextInputType.number,
                      controller: _ageController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.enterPatientAge;
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 7),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            AppStrings.patientPhone,
                            style: TextStyles.getBody(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    PhoneTextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.enterPatientPhone;
                        } else if (value.length < 11) {
                          return AppStrings.errorPhoneValidation;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 7),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            AppStrings.bookingDate,
                            style: TextStyles.getBody(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      readOnly: true,
                      onTap: () {
                        selectDate(context);
                      },
                      controller: _dateController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.enterDate;
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      style: TextStyles.getBody(),
                      decoration: InputDecoration(
                        hintText: AppStrings.enterBookingDate,
                        suffixIcon: Icon(
                          Icons.date_range_outlined,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            AppStrings.appointmentTime,
                            style: TextStyles.getBody(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Wrap(
                      spacing: 8.0,
                      children:
                          times.map((hour) {
                            return ChoiceChip(
                              backgroundColor: AppColors.whiteColor,
                              showCheckmark: false,
                              checkmarkColor: AppColors.primaryColor,
                              // avatar: const Icon(Icons.abc),
                              selectedColor: AppColors.primaryColor,
                              label: Text(
                                '${(hour < 10) ? '0' : ''}${hour.toString()}:00',
                                style: TextStyle(
                                  color:
                                      hour == selectedSlot
                                          ? AppColors.whiteColor
                                          : AppColors.primaryColor,
                                ),
                              ),
                              selected: hour == selectedSlot,
                              onSelected: (selected) {
                                setState(() {
                                  selectedSlot = hour;
                                  bookingHour =
                                      '${(hour < 10) ? '0' : ''}${hour.toString()}:00'; // to send to firebase(hh:mm)
                                });
                              },
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),


      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
          child: MainButton(
            text: AppStrings.confirmBooking,
            onPressed: () async {
              if (_formKey.currentState!.validate() && selectedSlot != -1) {
                await FirestoreServices.createAppointment(
                  AppointmentModel(
                    patientID: SharedPref.getUserToken(),
                    doctorID: widget.doctorData.uid,
                    patientName: _nameController.text,
                    patientPhone: _phoneController.text,
                    description: _descriptionController.text,
                    doctorName: widget.doctorData.name,
                    doctorImage: widget.doctorData.image,
                    location: widget.doctorData.address,
                    date: DateTime.parse('$dateUTC $bookingHour:00'),
                    isComplete: false,
                    age: _ageController.text,
                  ),
                );
                showAlertDialog(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    ).then((date) {
      if (date != null) {
        setState(() {
          _dateController.text = DateFormat(
            'dd-MM-yyyy',
          ).format(date); // to display the date in the text field
          dateUTC = DateFormat(
            'yyyy-MM-dd',
          ).format(date); // to send the date to firebase
          getAvailableTimes(date); // to get available times
        });
      }
    });
  }
}
