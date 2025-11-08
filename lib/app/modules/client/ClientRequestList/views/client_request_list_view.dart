import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pharmix/app/data/models/request.dart';
import 'package:pharmix/app/modules/client/ClientRequestList/controllers/client_request_list_controller.dart';
import 'package:pharmix/app/themes/app_colors.dart';
import 'package:pharmix/app/themes/app_text_styles.dart';
import 'package:pharmix/app/utils/constants/app_constant.dart';
import 'package:pharmix/app/widgets/custom_text.dart';
import 'package:pharmix/app/widgets/request_card.dart';
import 'package:pharmix/app/widgets/request_filter.dart';
import 'package:pharmix/generated/locales.g.dart';

class ClientRequestListView extends GetView<ClientRequestListController> {
  const ClientRequestListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Mes réquettes",
          style: AppTextStyles.heading3,
        ),
        centerTitle: true,
      ),
      body: Column(
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
            child: PagingListener<int, Request>(
              controller: controller.pagingController,
              builder: (context, state, fetchNextPage) {
                return PagedListView<int, Request>(
                  state: state,
                  fetchNextPage: fetchNextPage,
                  builderDelegate: PagedChildBuilderDelegate<Request>(
                    itemBuilder: (context, pharmacy, index) {
                      return RequestCard(
                        request: pharmacy,
                        onCancel: () {
                          // controller.cancelRequest(pharmacy.id);
                        },
                      );
                    },
                    firstPageProgressIndicatorBuilder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                    newPageProgressIndicatorBuilder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                    noMoreItemsIndicatorBuilder: (_) =>
                        const Center(child: Text('Fin')),
                    firstPageErrorIndicatorBuilder: (_) =>
                        Center(child: Text('Erreur: ')),
                    invisibleItemsThreshold: 5,
                    noItemsFoundIndicatorBuilder: (context) => Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/no_data.png',
                            width: Get.width / 4,
                            fit: BoxFit.contain,
                          ),
                          CustomText(
                            text: LocaleKeys.introuvable_pharmacie_msg.tr,
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
