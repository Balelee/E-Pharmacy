import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PharmaciesController extends GetxController {
  final pharmacies = [
    {
      'name': 'Pharmacie Centrale',
      'address': '12 Rue de la Santé',
      'phone': '+226 66899087',
      'day': 'Lundi',
      'opening_day': "08:00",
      'closing_day': '12:00',
      'longitude': '',
      'latitude': ''
    },
    {
      'name': 'Pharmacie du Centre',
      'address': '8 Avenue Pasteur',
      'phone': '+226 72446786',
      'day': 'Lundi',
      'opening_day': "08:00",
      'closing_day': '12:00',
      'longitude': '',
      'latitude': ''
    },
    {
      'name': 'Pharmacie de l\'Étoile',
      'address': 'Place de l\'Étoile',
      'phone': '+226 668990875',
      'day': 'Lundi',
      'opening_day': "08:00",
      'closing_day': '12:00',
      'longitude': '',
      'latitude': ''
    },
    {
      'name': 'Pharmacie Lyonnaise',
      'address': 'Rue Victor Hugo, Lyon',
      'phone': '+226 668990870',
      'day': 'Lundi',
      'opening_day': "08:00",
      'closing_day': '12:00',
      'longitude': '',
      'latitude': ''
    },
  ];

  void openMap(String lat, String lng) async {
    final googleMapsUrl = Uri.parse("comgooglemaps://?q=$lat,$lng");
    final webUrl =
        Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else if (await canLaunchUrl(webUrl)) {
      await launchUrl(webUrl, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar("Erreur", "Impossible d’ouvrir Google Maps.");
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
