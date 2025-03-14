import 'package:e_pharma/app/routes/app_pages.dart';
import 'package:e_pharma/app/widgets/custom_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class BienEtreView extends GetView {
  const BienEtreView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BienEtreView'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            CustomCard(
              onTap: () {
                Get.toNamed(AppPages.TRACKER_PERIOD);
              },
              title: "Période traqueur",
              description:
                  "Gardez le contrôle de votre cycle menstruel grâce à un suivi simple, fiable et personnalisé.",
              backgroundColor: Color(0xFFFFE0E0), // Rose pâle
            ),
            CustomCard(
              onTap: () {},
              title: "Accompagnement femme enceinte",
              description:
                  "Suivi de grossesse complet pour vivre chaque étape avec sérénité et confiance.",
              backgroundColor: Color(0xFFDFFFE0), // Vert pâle
            ),
            CustomCard(
              onTap: () {},
              title: "Soutien mental",
              description:
                  "Écoute, conseils et outils pour une meilleure gestion du stress et des émotions.",
              backgroundColor: Color(0xFFFFF5CC), // Jaune pâle
            ),
          ],
        ));
  }
}
