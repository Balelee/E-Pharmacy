
import 'package:get/get.dart';
import 'package:pharmix/generated/locales.g.dart';
import 'package:url_launcher/url_launcher.dart';

class MapHelper {
  static Future<void> openMap(String lat, String lng) async {
    final googleMapsUrl = Uri.parse("comgooglemaps://?q=$lat,$lng");
    final webUrl =
        Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");

    try {
      if (await canLaunchUrl(googleMapsUrl)) {
        await launchUrl(googleMapsUrl);
      } else if (await canLaunchUrl(webUrl)) {
        await launchUrl(webUrl, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(LocaleKeys.error.tr, LocaleKeys.impossible_open_map.tr);
      }
    } catch (e) {
      Get.snackbar(LocaleKeys.error.tr, e.toString());
    }
  }
}
