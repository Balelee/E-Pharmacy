import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/routes/app_pages.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';
import 'package:pharmix/app/utils/constants/app_constant.dart';
import 'package:pharmix/app/utils/helpers/map_helper.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/request_filter.dart';
import '../controllers/client_feed_back_request_controller.dart';

class ClientFeedBackRequestView
    extends GetView<ClientFeedBackRequestController> {
  const ClientFeedBackRequestView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: BackButton(
          onPressed: () {
            Get.toNamed(
              AppPages.PRODUIT_LIST,
            );
          },
          color: Colors.white,
        ),
        title: Obx(
          () => CustomText(
            text: controller.isProcessing.value
                ? 'Traitement encours'
                : 'Commandes traitées',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(25),
          child: Obx(() {
            var totalPharCount = controller.totalPharfeedbackRequest.value;
            return totalPharCount >= 1
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    decoration: BoxDecoration(color: AppColors.info),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomText(
                        text:
                            "${totalPharCount.toString()} ${totalPharCount == 1 ? 'pharmacie a' : 'pharmacies ont'} recus votre requette",
                        overflow: TextOverflow.visible,
                        style: AppTextStyles.caption.copyWith(
                            fontSize: 13.0, color: AppColors.secondary),
                      ),
                    ),
                  )
                : SizedBox.shrink();
          }),
        ),
      ),
      body: Obx(() {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 18.0, horizontal: AppConstant.haurizontalPadding),
              child: Container(
                decoration: BoxDecoration(
                    color: Get.theme.cardColor,
                    borderRadius: BorderRadius.circular(10)),
                child: RequestFilterWidget(),
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final slideAnimation = Tween<Offset>(
                    begin: const Offset(0.0, 0.1),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.linear,
                  ));

                  return SlideTransition(
                    position: slideAnimation,
                    child: child,
                  );
                },
                child: controller.isProcessing.value
                    ? Container(
                        key: const ValueKey('processing'),
                        color: Colors.white.withOpacity(0.8),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 60),
                                child: LinearProgressIndicator(
                                  minHeight: 4,
                                  backgroundColor: Colors.grey[300],
                                  color: Colors.blueAccent,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: CustomText(
                                  text: controller.currentProcessingMessage,
                                  style: AppTextStyles.heading3.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 12),
                              CustomText(
                                text:
                                    "Temps écoulé : ${controller.elapsedTime}",
                                style: AppTextStyles.caption.copyWith(
                                  color: Colors.black54,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : controller.requests.isEmpty
                        ? const Center(
                            key: ValueKey('empty'),
                            child: CustomText(
                                text:
                                    'Aucune commande traitée pour l’instant.'),
                          )
                        : Expanded(
                            child: ListView.builder(
                              key: const ValueKey('requests'),
                              padding: const EdgeInsets.all(12),
                              itemCount: controller.requests.length,
                              itemBuilder: (context, index) {
                                final request = controller.requests[index];
                                return Card(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (request.status.toLowerCase() !=
                                            'expiré')
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: Get.width / 2,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.amber.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: CustomText(
                                                      text:
                                                          "Pharmacie ${request.pharmacy!.name.toString()}",
                                                      overflow:
                                                          TextOverflow.visible,
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.error
                                                            .withOpacity(0.1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            Icons.location_on,
                                                            size: 13,
                                                            color:
                                                                AppColors.error,
                                                          ),
                                                          const SizedBox(
                                                              width: 4),
                                                          Obx(() {
                                                            final distance =
                                                                controller
                                                                        .distances[
                                                                    request.id];
                                                            if (distance ==
                                                                null) {
                                                              return SizedBox(
                                                                width: 10,
                                                                height: 10,
                                                                child:
                                                                    const CircularProgressIndicator(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  strokeWidth:
                                                                      3,
                                                                  color:
                                                                      AppColors
                                                                          .error,
                                                                ),
                                                              );
                                                            } else {
                                                              return CustomText(
                                                                text:
                                                                    "Situé: ${controller.formatDistance(distance)}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      AppColors
                                                                          .error,
                                                                ),
                                                              );
                                                            }
                                                          }),
                                                        ],
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      final lat = request
                                                          .pharmacy!.latitude;
                                                      final lng = request
                                                          .pharmacy!.longitude;
                                                      if (lat != null &&
                                                          lng != null) {
                                                        MapHelper.openMap(
                                                            lat, lng);
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.phone,
                                                      color: Colors.blue,
                                                      size: 14,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8.0),
                                                      child: CustomText(
                                                        text: request.pharmacy!
                                                                .phone ??
                                                            'inconnu',
                                                        style: AppTextStyles
                                                            .caption
                                                            .copyWith(
                                                                fontSize: 13),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        const SizedBox(height: 3),
                                        ExpansionTile(
                                          childrenPadding:
                                              const EdgeInsets.all(3),
                                          initiallyExpanded: true,
                                          shape: Border.all(
                                              color: Colors.transparent),
                                          tilePadding: EdgeInsets.all(0.0),
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                text:
                                                    'Requette n°${request.requestId}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  request.status.toUpperCase(),
                                                  style: AppTextStyles.caption
                                                      .copyWith(
                                                          color: Colors.white,
                                                          fontSize: 10),
                                                ),
                                              ),
                                            ],
                                          ),
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ...request.details!
                                                    .map((item) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 6),
                                                          child: Container(
                                                            decoration: const BoxDecoration(
                                                                border: Border(
                                                                    bottom: BorderSide(
                                                                        width:
                                                                            0.1))),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                CustomText(
                                                                  text:
                                                                      '${item.requestDetail?.productName}',
                                                                  style: AppTextStyles
                                                                      .bodyText1Bold,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .visible,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        CustomText(
                                                                            text:
                                                                                'Quantite dispo : ${item.quantity}'),
                                                                        CustomText(
                                                                            text:
                                                                                'Prix dispo : ${item.price.toStringAsFixed(0)} FCFA'),
                                                                        CustomText(
                                                                            text:
                                                                                'Total : ${item.total.toStringAsFixed(0)} FCFA'),
                                                                      ],
                                                                    ),
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          3.0),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color: item.available
                                                                                ? Colors.green
                                                                                : Colors.red),
                                                                        borderRadius:
                                                                            BorderRadius.circular(60),
                                                                      ),
                                                                      child:
                                                                          Icon(
                                                                        item.available
                                                                            ? Icons.check
                                                                            : Icons.close,
                                                                        color: item.available
                                                                            ? Colors.green
                                                                            : Colors.red,
                                                                        size:
                                                                            20,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8.0),
                                                    child: CustomText(
                                                      text:
                                                          'Total: ${request.details!.fold<double>(0, (sum, e) => sum + e.total).toStringAsFixed(0)} FCFA',
                                                      style: AppTextStyles
                                                          .heading3
                                                          .copyWith(
                                                              fontSize: 17.0,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
