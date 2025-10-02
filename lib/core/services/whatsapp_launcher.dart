
import 'dart:developer';
import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

Future<void> sendWhatsAppMessage(String phoneNumber, String message) async {

   var androidUrl = "whatsapp://send?phone=+2$phoneNumber&text=$message";
   var iosUrl = "https://wa.me/+2$phoneNumber?text=${Uri.parse(message)}";
   
   try{
      if(Platform.isIOS){
         await launchUrl(Uri.parse(iosUrl));
      }
      else{
         await launchUrl(Uri.parse(androidUrl));
      }
   } on Exception{
     log('WhatsApp is not installed.');
  }
}