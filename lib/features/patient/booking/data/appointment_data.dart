import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  String? patientID;
  String? doctorID;
  String? patientName;
  String? patientPhone;
  String? description;
  String? doctorName;
  String? location;
  DateTime? date;
  bool? isComplete;
  double? rating;

  AppointmentModel({
    this.patientID,
    this.doctorID,
    this.patientName,
    this.patientPhone,
    this.description,
    this.doctorName,
    this.location,
    this.date,
    this.isComplete,
    this.rating,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      patientID: json['patientID'],
      doctorID: json['doctorID'],
      patientName: json['patientName'],
      patientPhone: json['patientPhone'],
      description: json['description'],
      doctorName: json['doctor'],
      location: json['location'],
      date: (json['date'] as Timestamp).toDate(),
      isComplete: json['isComplete'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() => {
    'patientID': patientID,
    'doctorID': doctorID,
    'patientName': patientName,
    'patientPhone': patientPhone,
    'description': description,
    'doctor': doctorName,
    'location': location,
    'date': date,
    'isComplete': isComplete,
    'rating': rating,
  };
}