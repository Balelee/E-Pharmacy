import 'package:url_launcher/url_launcher.dart';

class MapHelper {
  static Future<void> openMap(String lat, String lng) async {
    final Uri googleMapsAppUrl = Uri.parse("geo:$lat,$lng?q=$lat,$lng");
    final Uri googleMapsWebUrl = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$lat,$lng",
    );

    try {
      // On tente directement d’ouvrir l’app
      bool launched = await launchUrl(
        googleMapsAppUrl,
        mode: LaunchMode.externalApplication,
      );

      // Si ça échoue, on passe par le navigateur web
      if (!launched) {
        await launchUrl(
          googleMapsWebUrl,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      // En dernier recours, ouvrir dans un navigateur web
      await launchUrl(
        googleMapsWebUrl,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
