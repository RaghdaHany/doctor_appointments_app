import 'package:doctor_appointments_app/core/constants/app_strings.dart';
import 'package:doctor_appointments_app/core/firebase/firestore_services.dart';
import 'package:doctor_appointments_app/core/services/shared_pref.dart';
import 'package:doctor_appointments_app/features/auth/data/models/doctor_data.dart';
import 'package:doctor_appointments_app/features/auth/data/models/patient_data.dart';
import 'package:doctor_appointments_app/features/auth/data/models/user_type.dart';
import 'package:doctor_appointments_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthStateInitial());

  Future<void> login(
    UserType userType,
    String emailAddress,
    String password,
  ) async {
    emit(AuthLoadingState());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      if (userType == UserType.doctor) {
        SharedPref.setUserType('doctor');
      } else if (userType == UserType.patient) {
        SharedPref.setUserType('patient');
      }

      User? user = credential.user;

      SharedPref.setUserToken(user?.uid ?? '');
      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthErrorState(AppStrings.noUserRegistered));
      } else if (e.code == 'wrong-password') {
        emit(AuthErrorState(AppStrings.incorrectPassword));
      } else {
        emit(AuthErrorState(AppStrings.registrationError));
      }
    }
  }

  Future<void> register(
    UserType userType,
    String name,
    String emailAddress,
    String password,
    String phoneNumber,
  ) async {
    emit(AuthLoadingState());
    try {
      var userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
      User? user = userCredential.user;
      user?.updateDisplayName(name);

      if (userType == UserType.doctor) {
        await FirestoreServices.createDoctor(
          DoctorData(
            name: name,
            uid: user?.uid ?? '',
            email: emailAddress,
            phone1: phoneNumber,
          ),
        );
        SharedPref.setUserType('doctor');
      } else {
        await FirestoreServices.createPatient(
          PatientData(
            name: name,
            uid: user?.uid ?? '',
            email: emailAddress,
            phone: phoneNumber,
          ),
        );
        SharedPref.setUserType('patient');
      }

      SharedPref.setUserToken(user?.uid ?? '');
      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthErrorState(AppStrings.passwordIsWeak));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthErrorState(AppStrings.emailIsUsed));
      } else {
        emit(AuthErrorState(AppStrings.registrationError));
      }
    } catch (e) {
      emit(AuthErrorState(AppStrings.unExpectedError));
    }
  }

  Future<void> registerDoctorData(DoctorData model) async {
    SharedPref.setDoctorRegister('true');

    emit(AuthLoadingState());
    try {
      await FirestoreServices.updateDoctor(model);
      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthErrorState(AppStrings.registrationError));
    }
  }
}
