import 'package:get/get.dart';
import 'package:pharmix/generated/locales.g.dart';
import 'package:url_launcher/url_launcher.dart';

class MapHelper {
  static Future<void> openMap(String lat, String lng) async {
    final googleMapsAppUrl = Uri.parse("geo:$lat,$lng?q=$lat,$lng");
    final googleMapsWebUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");

    try {
      if (await canLaunchUrl(googleMapsAppUrl)) {
        await launchUrl(googleMapsAppUrl, mode: LaunchMode.externalApplication);
      } 
      else if (await canLaunchUrl(googleMapsWebUrl)) {
        await launchUrl(googleMapsWebUrl, mode: LaunchMode.externalApplication);
      } 
      else {
        Get.snackbar(LocaleKeys.error.tr, LocaleKeys.impossible_open_map.tr);
      }
    } catch (e) {
      Get.snackbar(LocaleKeys.error.tr, e.toString());
    }
  }
}
