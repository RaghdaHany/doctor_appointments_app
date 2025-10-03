import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  String? patientID;
  String? doctorID;
  String? patientName;
  String? patientPhone;
  String? description;
  String? doctorName;
  String? doctorImage;
  String? location;
  DateTime? date;
  bool? isComplete;
  String? age;

  AppointmentModel({
    this.patientID,
    this.doctorID,
    this.patientName,
    this.patientPhone,
    this.description,
    this.doctorName,
    this.doctorImage,
    this.location,
    this.date,
    this.isComplete,
    this.age,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      patientID: json['patientID'],
      doctorID: json['doctorID'],
      patientName: json['patientName'],
      patientPhone: json['patientPhone'],
      description: json['description'],
      doctorName: json['doctor'],
      doctorImage: json['doctorImage'],
      location: json['location'],
      date: (json['date'] as Timestamp).toDate(),
      isComplete: json['isComplete'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() => {
    'patientID': patientID,
    'doctorID': doctorID,
    'patientName': patientName,
    'patientPhone': patientPhone,
    'description': description,
    'doctor': doctorName,
    'doctorImage': doctorImage,

    'location': location,
    'date': date,
    'isComplete': isComplete,
    'age': age,
  };
}
