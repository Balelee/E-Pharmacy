import 'package:e_pharma/app/modules/trackerPeriod/controllers/tracker_period_controller.dart';
import 'package:e_pharma/app/modules/trackerPeriod/views/editpage_view.dart';
import 'package:e_pharma/app/themes/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarView extends GetView<TrackerPeriodController> {
  const CalendarView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColors.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.thermostat,
                color: Colors.white,
                size: 25,
              ),
            ),
            const Text(
              'Calendrier',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: Get.width / 3,
              child: FloatingActionButton.extended(
                onPressed: () {
                  showDialog(
                    context: Get.context!,
                    builder: (context) {
                      return EditpageView();
                    },
                  );
                },
                backgroundColor: AppColors.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                label: const Text(
                  "Éditer votre cycle",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: controller.monthCount.value,
        itemBuilder: (context, index) {
          DateTime currentMonth = DateTime(
              controller.startMonth.year, controller.startMonth.month + index);
          String monthLabel = DateFormat.yMMMM('fr_FR')
              .format(currentMonth)
              .capitalize
              .toString();
          List<DateTime> days = controller.getDaysInMonth(currentMonth);
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  monthLabel,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: controller.weekDays
                      .map((d) => Expanded(
                            child: Center(
                              child: Text(
                                d,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 4),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: days.length + days.first.weekday - 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, dayIndex) {
                    if (dayIndex < days.first.weekday - 1) {
                      return const SizedBox();
                    }
                    final day = days[dayIndex - (days.first.weekday - 1)];
                    return Obx(
                      () => GestureDetector(
                        onTap: () {
                          if (controller.selectedDays
                              .any((d) => controller.isSameDay(d, day))) {
                            controller.selectedDays.removeWhere(
                                (d) => controller.isSameDay(d, day));
                          } else {
                            controller.selectedDays.add(day);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: AppColors.primary,
                            ),
                            color: controller.getDayColor(day),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${day.day}',
                                style: TextStyle(
                                  color: controller.getNumberColor(day),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                controller.getDayLabel(day),
                                style: TextStyle(
                                  color: controller.getNumberColor(day),
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
