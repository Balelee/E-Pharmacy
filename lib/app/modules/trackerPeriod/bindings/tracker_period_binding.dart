import 'package:get/get.dart';

import '../controllers/tracker_period_controller.dart';

class TrackerPeriodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackerPeriodController>(
      () => TrackerPeriodController(),
    );
  }
}
