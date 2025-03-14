import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PeriodTrackerWidget extends StatelessWidget {
  final int daysLeft;
  final double progressValue; // 0.0 à 1.0
  final int selectedDayIndex; // Index du jour sélectionné

  const PeriodTrackerWidget({
    Key? key,
    required this.daysLeft,
    required this.progressValue,
    required this.selectedDayIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> days = [
      "Lun.",
      "Mar.",
      "Mer.",
      "Jeu.",
      "Ven.",
      "Sam.",
      "Dim."
    ];
    List<int> dates = [3, 4, 5, 6, 7, 8, 9]; // Exemples de dates

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Section supérieure avec les jours de la semaine
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(days.length, (index) {
              bool isSelected = index == selectedDayIndex;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.teal : Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "${dates[index]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      days[index],
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.teal : Colors.black54,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 16.0),

        // Titre "Période traqueur"
        const Text(
          "Période traqueur",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16.0),

        // Cercle de progression
        CircularPercentIndicator(
          radius: 80.0,
          lineWidth: 12.0,
          percent: progressValue,
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: Colors.white,
          progressColor: progressValue > 0.5 ? Colors.red : Colors.teal,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Période dans",
                style: TextStyle(fontSize: 14.0, color: Colors.black54),
              ),
              Text(
                "$daysLeft jours",
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4.0),
              const Text(
                "Attention, vous êtes dans une zone rouge.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.0, color: Colors.black54),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24.0),

        // Bouton "Mettre à jour le cycle"
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          onPressed: () {
            // Action lors du clic
          },
          child: const Text(
            "Mettre à jour le cycle",
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ],
    );
  }
}
