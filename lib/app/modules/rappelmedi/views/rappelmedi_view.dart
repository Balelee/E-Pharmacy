import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/widgets/custom_button.dart';
import 'package:pharmix/app/widgets/custom_dropdown_field.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/custom_text_form_field.dart';
import 'package:pharmix/app/widgets/custom_toast.dart';
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
          text: "Rappel mécadiments",
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomToast(
                  icon: Icons.info_outline,
                  message:
                      "Pour un bon respect de votre traitement, n’oubliez pas d’ajouter vos médicaments afin de recevoir des rappels précis.",
                  backgroundColor: AppColors.primary.withOpacity(0.6),
                ),
                SizedBox(height: 15),
                CustomText(
                  textAlign: TextAlign.center,
                  text: 'Aujourdh\'hui',
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
                            ((startDay - 1 + index) % controller.daysInMonth) +
                                1;
                        DateTime date = DateTime(
                          controller.currentDate.year,
                          controller.currentDate.month,
                          displayDay,
                        );
                        String dayName = DateFormat('E', 'fr_FR').format(date);
                        String dayNumber = DateFormat('d').format(date);
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
                                backgroundColor:
                                    displayDay == controller.currentDate.day
                                        ? AppColors.primary
                                        : Colors.grey.shade300,
                                child: Text(
                                  dayNumber,
                                  style: TextStyle(
                                    color:
                                        displayDay == controller.currentDate.day
                                            ? Colors.white
                                            : Colors.black,
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
                controller.takeProductS.isEmpty
                    ? Column(
                        children: [
                          CustomText(
                            textAlign: TextAlign.center,
                            text: "Ajoutez votre premier rappel",
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                              left: 50.0,
                              right: 50,
                            ),
                            child: CustomText(
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                              text:
                                  'We make it easier for you to take the right medication at the right time, every day',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Prendre",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.takeProductS.length,
                            itemBuilder: (context, index) {
                              final takeproducts =
                                  controller.takeProductS[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
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
                                    SizedBox(width: 12),
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
                                                text:
                                                    takeproducts['productName']
                                                        .toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.textPrimary,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: CustomText(
                                                  text:
                                                      "(${takeproducts['form']})",
                                                  style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0),
                                                child: CustomText(
                                                  text:
                                                      "${takeproducts['takeQuantity']}, à ${takeproducts['takeHour']}",
                                                  style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              Icon(
                                                Icons.check_circle_outline,
                                                color: AppColors.textSecondary
                                                    .withOpacity(0.4),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: CustomText(
                                              text: takeproducts['startDate'],
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.textPrimary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
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
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(20),
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Ajouter un rappel",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 18),
                    CustomTextFormField(
                      hintText: "Nom de médicament",
                      hintStyle: TextStyle(
                          color: AppColors.textSecondary, fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      hintText: "JJ/MM/AAAA",
                      suffix: Icon(
                        Icons.calendar_month,
                        color: AppColors.textSecondary,
                      ),
                      hintStyle: TextStyle(
                          color: AppColors.textSecondary, fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(
                      hintText: "Ex: 23h:45min",
                      suffix: Icon(
                        Icons.access_alarm,
                        color: AppColors.textSecondary,
                      ),
                      hintStyle: TextStyle(
                          color: AppColors.textSecondary, fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    CustomDropdownFormField<String>(
                      hintText: "Type médicament",
                      hintStyle: TextStyle(
                          color: AppColors.textSecondary, fontSize: 14),
                      value: controller.selectedForm.value.isEmpty
                          ? null
                          : controller.selectedForm.value,
                      onChanged: (value) {
                        controller.selectedForm.value = value ?? "";
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'Comprimé',
                          child: Text('Comprimé'),
                        ),
                        DropdownMenuItem(
                          value: 'Sirop',
                          child: Text('Sirop'),
                        ),
                        DropdownMenuItem(
                          value: 'Injection',
                          child: Text('Injection'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Répeter",
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Obx(
                          () => Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.textSecondary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
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
                        SizedBox(
                          height: 8,
                        ),
                        Obx(
                          () => Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.textSecondary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: controller.hourOptions.map((option) {
                                bool isSelected =
                                    controller.selectedhour.value == option;

                                return GestureDetector(
                                  onTap: () {
                                    controller.selectedhour.value = option;
                                  },
                                  child: Container(
                                    width: 130,
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
                                        fontSize: 13,
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
                      onPressed: () {},
                      buttonTitle: "Enrégister",
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                    )
                  ],
                ),
              );
            },
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
