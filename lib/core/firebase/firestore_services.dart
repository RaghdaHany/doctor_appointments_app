import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_appointments_app/core/services/shared_pref.dart';
import 'package:doctor_appointments_app/features/auth/data/models/doctor_data.dart';
import 'package:doctor_appointments_app/features/auth/data/models/patient_data.dart';
import 'package:doctor_appointments_app/features/patient/booking/data/appointment_data.dart';

class FirestoreServices {
  static late final FirebaseFirestore _firestore;
  static late final CollectionReference _doctorsCollection;
  static late final CollectionReference _patientsCollection;
  static late final CollectionReference _appointmentsCollection;

  static void init() {
    _firestore = FirebaseFirestore.instance;
    _doctorsCollection = _firestore.collection("doctors");
    _patientsCollection = _firestore.collection("patients");
    _appointmentsCollection = _firestore.collection("appointments");
  }

  static Future<void> createDoctor(DoctorData model) async {
    await _doctorsCollection.doc(model.uid).set(model.toJson());
  }

  static Future<void> updateDoctor(DoctorData model) async {
    await _doctorsCollection.doc(model.uid).update(model.toUpdateData());
  }

  static Future<void> createPatient(PatientData model) async {
    await _patientsCollection.doc(model.uid).set(model.toJson());
  }

  static Future<void> updatePatient(PatientData model) async {
    await _patientsCollection.doc(model.uid).update(model.toUpdateData());
  }

  static Future<QuerySnapshot<Object?>> getDoctorData() async {
    return _doctorsCollection.get();
  }

  static Future<DocumentSnapshot<Object?>> getPatientProfileById() async {
    return _patientsCollection.doc(SharedPref.getUserToken()).get();
  }

   static Future<DocumentSnapshot<Object?>> getDoctorProfileById() async {
    return _doctorsCollection.doc(SharedPref.getUserToken()).get();
  }

  static Future<void> createAppointment(AppointmentModel model) async {
    await _appointmentsCollection.doc().set(model.toJson());
  }

  static Future<QuerySnapshot<Object?>> getPatientAppointment() async {
    return _appointmentsCollection
        .where('patientID', isEqualTo: SharedPref.getUserToken())
        .orderBy('date', descending: false)
        .get();
  }

  static Future<QuerySnapshot<Object?>> getDoctorAppointment() async {
    return _appointmentsCollection
        .where('doctorID', isEqualTo: SharedPref.getUserToken())
        .orderBy('date', descending: false)
        .get();
  }

  static Future<void> deleteAppointment(String docID) async {
    return _appointmentsCollection.doc(docID).delete();
  }
}
