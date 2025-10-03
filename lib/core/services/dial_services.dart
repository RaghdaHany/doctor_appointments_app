   import 'package:url_launcher/url_launcher.dart';

Future<void> openDialer(String phoneNumber) async {
      final Uri phoneUri = Uri(scheme: "tel", path: phoneNumber);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        // Handle the case where the dialer cannot be launched
        throw 'Could not launch $phoneUri';
      }
    }