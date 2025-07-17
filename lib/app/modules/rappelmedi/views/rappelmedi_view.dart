import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/widgets/custom_button.dart';
import 'package:pharmix/app/widgets/custom_dropdown_field.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/custom_text_form_field.dart';
import 'package:pharmix/app/widgets/custom_toast.dart';
import 'package:pharmix/generated/locales.g.dart';
import '../controllers/rappelmedi_controller.dart';

class RappelmediView extends GetView<RappelmediController> {
  const RappelmediView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: AppColors.primary,
        leading: BackButton(
          color: AppColors.background,
          onPressed: () {
            Get.back();
          },
        ),
        title: CustomText(
          text: LocaleKeys.appbar_msg_prise.tr,
          style: TextStyle(
            fontSize: 20,
            color: AppColors.background,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.access_alarm,
              color: AppColors.background,
            ),
          ),
        ],
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.showToast.value
                  ? CustomToast(
                      icon: Icons.info_outline,
                      message: LocaleKeys.prise_toast_msg.tr,
                      backgroundColor: AppColors.primary.withOpacity(0.6),
                      onClose: () {
                        controller.showToast.value = false;
                      },
                    )
                  : SizedBox.shrink(),
              SizedBox(height: 15),
              CustomText(
                textAlign: TextAlign.center,
                text: LocaleKeys.today.tr,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  CustomText(
                    textAlign: TextAlign.center,
                    text: DateFormat('d MMMM yyyy', 'fr_FR')
                        .format(DateTime.now()),
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              SizedBox(
                height: 90,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: controller.scrollController,
                    itemCount: controller.daysInMonth,
                    itemBuilder: (context, index) {
                      int startDay = controller.currentDate.day;
                      int displayDay =
                          ((startDay - 1 + index) % controller.daysInMonth) + 1;
                      DateTime date = DateTime(
                        controller.currentDate.year,
                        controller.currentDate.month,
                        displayDay,
                      );
                      String dayName = DateFormat('E', 'fr_FR').format(date);
                      String dayNumber = DateFormat('d').format(date);
                      bool isReminderDay = controller.pills.any((pill) {
                        final pillDate =
                            DateTime.parse(pill.startDate.toString());
                        return pillDate.year == date.year &&
                            pillDate.month == date.month &&
                            pillDate.day == date.day;
                      });
                      Color circleColor = isReminderDay
                          ? Colors.amber.shade300
                          : (displayDay == controller.currentDate.day
                              ? AppColors.primary
                              : Colors.grey.shade300);

                      Color textColor = isReminderDay ||
                              displayDay == controller.currentDate.day
                          ? Colors.white
                          : Colors.black;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: dayName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 8),
                            CircleAvatar(
                              radius: 22,
                              backgroundColor: circleColor,
                              child: Text(
                                dayNumber,
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(height: 40),
              Expanded(
                child: controller.pills.isEmpty
                    ? Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                textAlign: TextAlign.center,
                                text: LocaleKeys.title_ajout_rappel.tr,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 12, left: 50.0, right: 50),
                                child: CustomText(
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.visible,
                                  text: LocaleKeys.msg_prise_product.tr,
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: LocaleKeys.prendre.tr,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 5),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.pills.length,
                              itemBuilder: (context, index) {
                                final takeproducts = controller.pills[index];
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: AppColors.primary,
                                        child: Icon(
                                          Icons.medication,
                                          color: AppColors.background,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: takeproducts
                                                      .medicineName
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.textPrimary,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: CustomText(
                                                    text:
                                                        "(${takeproducts.form})",
                                                    style: const TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0),
                                                  child: CustomText(
                                                    text:
                                                        "${takeproducts.frequency}, à ${takeproducts.reminderTime}",
                                                    style: const TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomText(
                                                    text:
                                                        DateFormat("dd-MM-yyyy")
                                                            .format(takeproducts
                                                                .startDate),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          AppColors.textPrimary,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller
                                                          .onDeletePressed(
                                                              takeproducts);
                                                    },
                                                    child: Icon(
                                                      Icons.delete,
                                                      size: 18,
                                                      color: AppColors.error,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Get.bottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: LocaleKeys.ajout_rappel.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 18),
                    CustomTextFormField(
                      controller: controller.pillnameController,
                      hintText: LocaleKeys.name_medication.tr,
                      hintStyle: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      hintText: "JJ/MM/AAAA",
                      controller: controller.dateController,
                      suffix: Icon(
                        Icons.calendar_month,
                        color: AppColors.textSecondary,
                      ),
                      hintStyle: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.zero,
                              content: Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                      primary: AppColors.primary),
                                ),
                                child: CalendarDatePicker(
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  onDateChanged: (pickedDate) {
                                    Navigator.pop(context);
                                    controller.dateController.text =
                                        "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      hintText: "Ex: 08:00, 12:00, 18:00",
                      controller: controller.timeController,
                      isReadOnly: true,
                      onTap: () async {
                        while (true) {
                          final TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime == null) break;

                          bool exists = controller.selectedTimes.any(
                            (t) =>
                                t.hour == pickedTime.hour &&
                                t.minute == pickedTime.minute,
                          );

                          if (!exists) {
                            controller.selectedTimes.add(pickedTime);
                            controller.timeController.text = controller
                                .selectedTimes
                                .map((t) =>
                                    "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}")
                                .join(', ');
                          } else {}
                        }
                      },
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.access_alarm,
                                color: AppColors.textSecondary),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () async {
                              while (true) {
                                final TimeOfDay? pickedTime =
                                    await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (pickedTime == null) break;

                                bool exists = controller.selectedTimes.any(
                                  (t) =>
                                      t.hour == pickedTime.hour &&
                                      t.minute == pickedTime.minute,
                                );

                                if (!exists) {
                                  controller.selectedTimes.add(pickedTime);
                                  controller.timeController.text = controller
                                      .selectedTimes
                                      .map((t) =>
                                          "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}")
                                      .join(', ');
                                }
                              }
                            },
                          ),
                          SizedBox(width: 4),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () {
                              controller.selectedTimes.clear();
                              controller.timeController.clear();
                            },
                          ),
                        ],
                      ),
                      hintStyle: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomDropdownFormField<String>(
                      hintText: LocaleKeys.type_medication.tr,
                      hintStyle: TextStyle(
                          color: AppColors.textSecondary, fontSize: 14),
                      value: controller.selectedForm.value.isEmpty
                          ? null
                          : controller.selectedForm.value,
                      onChanged: (value) {
                        controller.selectedForm.value = value ?? "";
                      },
                      items: [
                        DropdownMenuItem(
                          value: LocaleKeys.comprime.tr,
                          child: Text(
                            LocaleKeys.comprime.tr,
                          ),
                        ),
                        DropdownMenuItem(
                          value: LocaleKeys.sirop.tr,
                          child: Text(
                            LocaleKeys.sirop.tr,
                          ),
                        ),
                        DropdownMenuItem(
                          value: LocaleKeys.injection.tr,
                          child: Text(
                            LocaleKeys.injection.tr,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: LocaleKeys.repeter.tr,
                          color: const Color.fromARGB(255, 33, 33, 33),
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.textSecondary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: controller.timeOptions.map((option) {
                                bool isSelected =
                                    controller.selectedTime.value == option;
                                return GestureDetector(
                                  onTap: () {
                                    controller.selectedTime.value = option;
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 45,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.blue
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      option,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomButton.primaryButton(
                      onPressed: () {
                        final name = controller.pillnameController.text.trim();
                        final dateText = controller.dateController.text.trim();
                        final form = controller.selectedForm.value;
                        final repeat = controller.selectedTime.value;
                        if (name.isEmpty ||
                            dateText.isEmpty ||
                            controller.selectedTimes.isEmpty ||
                            form.isEmpty ||
                            repeat.isEmpty) {
                          Get.snackbar(
                            LocaleKeys.error.tr,
                            LocaleKeys.empty_field_msg.tr,
                            colorText: AppColors.background,
                          );
                          return;
                        }
                        final rawDateText =
                            controller.dateController.text.trim();
                        DateTime parsedDate;

                        try {
                          parsedDate =
                              DateFormat('dd/MM/yyyy').parseStrict(rawDateText);
                        } catch (e) {
                          Get.snackbar(
                            LocaleKeys.error.tr,
                            LocaleKeys.invalid_date.tr,
                            colorText: AppColors.background,
                          );
                          return;
                        }
                        final formattedDate =
                            DateFormat('yyyy-MM-dd').format(parsedDate);
                        final formData = {
                          "medicine_name": name,
                          "start_date": formattedDate,
                          "reminder_time": controller.selectedTimes
                              .map((t) =>
                                  "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}")
                              .join(','),
                          "frequency": repeat,
                          "form": form,
                        };

                        controller.submitPill(formData);
                        controller.clearFields();
                        Navigator.pop(context);
                      },
                      buttonTitle: LocaleKeys.enregister.tr,
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: AppColors.background,
          size: 30,
        ),
      ),
    );
  }
}
