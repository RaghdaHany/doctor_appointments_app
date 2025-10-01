import 'dart:developer';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:doctor_appointments_app/core/constants/app_constants.dart';

Future<String?> uploadImageToCloudinary(File imageFile) async {
  final cloudinary = CloudinaryPublic(
    AppConstants.cloudName,
    AppConstants.uploadPresetName,
    cache: false,
  );

  try {
    CloudinaryResponse response = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(
        imageFile.path,
        resourceType: CloudinaryResourceType.Image,
      ),
    );
    return response.secureUrl; // Returns the secure URL of the uploaded image
  } on CloudinaryException catch (e) {
    log(e.message.toString());
    return null;
  }
}
