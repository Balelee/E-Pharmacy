import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/cummon/controllers/navigation_controller.dart';
import 'package:pharmix/app/data/enums/orderstatus.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/utils/helpers/bottomSheet_helper.dart';
import 'package:pharmix/app/widgets/custom_button.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/custom_toast.dart';
import 'package:pharmix/generated/locales.g.dart';
import '../controllers/pharmacien_controller.dart';

class PharmacienView extends GetView<PharmacienController> {
  const PharmacienView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(
        () => PageView(
          controller: NavigationController.to.pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            NavigationController.to.currentIndex.value = index;
          },
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 20),
                    color: AppColors.background,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${LocaleKeys.welcome.tr} dans pharmacie",
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFF202938),
                              ),
                            ),
                            Text(
                              "${controller.user.user?.pharmacie?.pharmacieName}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(
                                      0xFF202938,
                                    ),
                                  ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0x1A202938),
                                ),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: const Icon(Icons.notifications_outlined,
                                  size: 20),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 21,
                                height: 21,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  controller.notificationCount.value.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 22,
                            left: 22,
                            top: 3,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  controller.showToast.value
                                      ? CustomToast(
                                          icon: Icons.info_outline,
                                          message:
                                              "Cher auxiliaire, Merci de vérifier chaque commande client afin de valider ou annuler selon la situation.",
                                          backgroundColor: AppColors.success,
                                          onClose: () {
                                            controller.showToast.value = false;
                                          },
                                        )
                                      : SizedBox.shrink(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Commande recentes",
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF202938),
                                        ),
                                      ),
                                      Container(
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: AppColors.background,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.green.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 6,
                                              offset: Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: PopupMenuButton<String>(
                                          padding: EdgeInsets.zero,
                                          color: AppColors.background,
                                          icon: Icon(
                                            Icons.sort,
                                            size: 25,
                                            color: AppColors.textSecondary,
                                          ),
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              value: 'traite',
                                              child: Text(
                                                "Commd validé",
                                                style: TextStyle(
                                                    color: AppColors
                                                        .textSecondary),
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 'annule',
                                              child: Text(
                                                "Commd annulé",
                                                style: TextStyle(
                                                    color: AppColors
                                                        .textSecondary),
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 'Tous',
                                              child: Text(
                                                "Tous les commandes",
                                                style: TextStyle(
                                                    color: AppColors
                                                        .textSecondary),
                                              ),
                                            ),
                                          ],
                                          onSelected: (value) async {
                                            if (value == 'traite') {
                                              await controller
                                                  .fetchOrdersByStatus(
                                                      'traite');
                                            } else if (value == 'annule') {
                                              await controller
                                                  .fetchOrdersByStatus(
                                                      'annule');
                                            } else {
                                              controller.selectedStatus.value =
                                                  '';
                                              controller.loadOrdersData();
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: controller.orders.isEmpty
                                    ? Get.height / 5
                                    : 0,
                              ),
                              controller.orders.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          CircularProgressIndicator(
                                            color: Colors.green,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: CustomText(
                                              text: "Aucune commande recente",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: controller.orders.length,
                                      itemBuilder: (context, index) {
                                        final order = controller.orders[index];
                                        return GestureDetector(
                                          onTap: () {
                                            if (Get.isBottomSheetOpen ==
                                                false) {
                                              BottomsheetHelper
                                                  .commandeDetailBottomSheet(
                                                      order: order);
                                            }
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 12),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  spreadRadius: 1,
                                                  blurRadius: 6,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: Material(
                                              elevation: 2,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.white,
                                              child: ListTile(
                                                contentPadding:
                                                    const EdgeInsets.all(12),
                                                title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CustomText(
                                                      text:
                                                          'Commande #${order.id}',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .blue.shade100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: CustomText(
                                                        text:
                                                            order.status.label,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12,
                                                          color: order.status
                                                                      .label ==
                                                                  "Traité"
                                                              ? Colors.green
                                                              : order.status
                                                                          .label ==
                                                                      "Annulé"
                                                                  ? Colors.red
                                                                  : Colors.blue,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(height: 6),
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          const TextSpan(
                                                            text: 'Client : ',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .black87,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: '-------',
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          const TextSpan(
                                                            text:
                                                                'Montant total : ',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .black87,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "${order.amount.toString()} CFA",
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    CustomButton.primaryButton(
                                                        height: 30,
                                                        elevation: 0.0,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 0.0),
                                                        onPressed: () {
                                                          if (Get.isBottomSheetOpen ==
                                                              false) {
                                                            BottomsheetHelper
                                                                .commandeDetailBottomSheet(
                                                                    order:
                                                                        order);
                                                          }
                                                        },
                                                        buttonTitle: order
                                                                    .status
                                                                    .label !=
                                                                "Traité"
                                                            ? "Traiter"
                                                            : "Déja traité",
                                                        backgroundColor: order
                                                                    .status
                                                                    .label !=
                                                                "Traité"
                                                            ? AppColors.success
                                                            : Colors.grey)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        final nav = NavigationController.to;
        return Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: AppColors.background,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Commande',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: "Historique",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payment),
                label: "Paiement",
              ),
            ],
            onTap: (index) {
              nav.pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
              );
              nav.currentIndex.value = index;
            },
            currentIndex: nav.currentIndex.value,
            selectedItemColor: AppColors.success,
            unselectedItemColor: const Color(0xFF202938),
            type: BottomNavigationBarType.fixed,
            elevation: 8,
          ),
        );
      }),
    );
  }
}
