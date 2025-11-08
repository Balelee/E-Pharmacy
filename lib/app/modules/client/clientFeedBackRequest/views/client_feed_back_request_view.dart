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
      body:Column(
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
        
          ],
        ),
    );
  }
}
