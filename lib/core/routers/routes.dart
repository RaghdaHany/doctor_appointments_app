import 'package:doctor_appointments_app/features/auth/data/models/doctor_data.dart';
import 'package:doctor_appointments_app/features/auth/data/models/user_type.dart';
import 'package:doctor_appointments_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:doctor_appointments_app/features/auth/presentation/page/doctor_register_screen.dart';
import 'package:doctor_appointments_app/features/auth/presentation/page/login_screen.dart';
import 'package:doctor_appointments_app/features/auth/presentation/page/registration_screen.dart';
import 'package:doctor_appointments_app/features/doctor/home/doctor_home_screen.dart';
import 'package:doctor_appointments_app/features/patient/booking/presentation/booking_appointment_screen.dart';
import 'package:doctor_appointments_app/features/patient/doctor_profile/page/doctor_profile_data_screen.dart';
import 'package:doctor_appointments_app/features/patient/main/patient_main_screen.dart';
import 'package:doctor_appointments_app/features/patient/profile/page/edit_profile_screen.dart';
import 'package:doctor_appointments_app/features/splash/splash_screen.dart';
import 'package:doctor_appointments_app/features/welcome/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String doctorRegisterRoute = '/doctorRegistration';
  static const String patientMainRoute = '/patientMain';
  static const String doctorHomeRoute = '/doctorHome';
  static const String doctorProfileRoute = '/doctorProfile';
  static const String bookAppointmentRoute = '/bookAppointment';
  static const String editProfileRoute = '/editProfile';



  static final routers = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),

      GoRoute(path: welcome, builder: (context, state) => WelcomeScreen()),

      GoRoute(
        path: loginRoute,
        builder:
            (context, state) => BlocProvider(
              create: (context) => AuthCubit(),
              child: LoginScreen(userType: state.extra as UserType),
            ),
      ),

      GoRoute(
        path: registerRoute,
        builder:
            (context, state) => BlocProvider(
              create: (context) => AuthCubit(),
              child: RegisterScreen(userType: state.extra as UserType),
            ),
      ),

      GoRoute(
        path: doctorRegisterRoute,
        builder:
            (context, state) => BlocProvider(
              create: (context) => AuthCubit(),
              child: DoctorRegistrationScreen(),
            ),
      ),

      GoRoute(
        path: patientMainRoute,
        builder: (context, state) => PatientMainScreen(),
      ),
      GoRoute(
        path: doctorHomeRoute,
        builder: (context, state) => DoctorHomeScreen(),
      ),

      GoRoute(
        path: doctorProfileRoute,
        builder:
            (context, state) =>
                DoctorProfileDataScreen(doctorData: state.extra as DoctorData),
      ),

      GoRoute(
        path: bookAppointmentRoute,
        builder:
            (context, state) =>
                BookingAppointmentScreen(doctorData: state.extra as DoctorData),
      ),

      GoRoute(
        path: editProfileRoute,
        builder: (context, state) => EditProfileScreen(),
      ),
    ],
  );
}
