import 'package:e_pharma/app/widgets/periode_tracker_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tracker_period_controller.dart';

class TrackerPeriodView extends GetView<TrackerPeriodController> {
  const TrackerPeriodView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TrackerPeriodView'),
        centerTitle: true,
      ),
      body: Center(
        child: PeriodTrackerWidget(
          daysLeft: 4,
          progressValue: 0.7,
          selectedDayIndex: 3,
        ),
      ),
    );
  }
}
