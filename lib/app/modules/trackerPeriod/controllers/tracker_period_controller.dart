import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TrackerPeriodController extends GetxController {
  final List<DateTime> daysList = List.generate(
    7,
    (index) => DateTime.now().add(Duration(days: index)),
  );
  int daysUntilPeriod = 4;
  String get formattedDate {
    return DateFormat('EEE. d MMM', 'fr').format(DateTime.now());
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
