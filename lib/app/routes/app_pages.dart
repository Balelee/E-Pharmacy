import 'package:get/get.dart';

import '../modules/client/ClientOrderList/bindings/client_order_list_binding.dart';
import '../modules/client/ClientOrderList/views/client_order_list_view.dart';
import '../modules/Login/bindings/login_binding.dart';
import '../modules/Login/views/login_content_view.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/client/Register/bindings/register_binding.dart';
import '../modules/client/Register/views/register_view.dart';
import '../modules/client/address/bindings/address_binding.dart';
import '../modules/client/address/views/address_view.dart';
import '../modules/client/clientFeedBackOrder/bindings/client_feed_back_order_binding.dart';
import '../modules/client/clientFeedBackOrder/views/client_feed_back_order_view.dart';
import '../modules/clinique/bindings/clinique_binding.dart';
import '../modules/clinique/views/clinique_view.dart';
import '../modules/client/detailProduit/bindings/detail_produit_binding.dart';
import '../modules/client/detailProduit/views/detail_produit_view.dart';
import '../modules/client/home/bindings/home_binding.dart';
import '../modules/client/home/views/base_view.dart';
import '../modules/client/home/views/basket_view.dart';
import '../modules/client/home/views/product_list_view.dart';
import '../modules/client/orderDetail/bindings/order_detail_binding.dart';
import '../modules/client/orderDetail/views/order_detail_view.dart';
import '../modules/client/otp/bindings/otp_binding.dart';
import '../modules/client/otp/views/otp_view.dart';
import '../modules/client/paiement/bindings/paiement_binding.dart';
import '../modules/client/paiement/views/paiement_view.dart';
import '../modules/pharmacy/pharmacien/bindings/pharmacien_binding.dart';
import '../modules/pharmacy/pharmacien/views/pharmacien_view.dart';
import '../modules/pharmacy/pharmacies/bindings/pharmacies_binding.dart';
import '../modules/pharmacy/pharmacies/views/pharmacies_view.dart';
import '../modules/client/rappelmedi/bindings/rappelmedi_binding.dart';
import '../modules/client/rappelmedi/views/rappelmedi_view.dart';
import '../modules/client/receiptpay/bindings/receiptpay_binding.dart';
import '../modules/client/receiptpay/views/receiptpay_view.dart';
import '../modules/client/searchproduct/bindings/searchproduct_binding.dart';
import '../modules/client/searchproduct/views/searchproduct_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;
  static const REGISTER = Routes.REGISTER;
  static const LOGINCONTENT = Routes.LOGINCONTENT;
  static const BASE = Routes.BASE;
  static const OTP = Routes.OTP;
  static const PRODUIT_LIST = Routes.PRODUIT_LIST;
  static const DETAIL_PRODUIT = Routes.DETAIL_PRODUIT;
  static const BASKET = Routes.BASKET;
  static const RAPPELMEDI = Routes.RAPPELMEDI;
  static const ORDER_DETAIL = Routes.ORDER_DETAIL;
  static const SEARCHPRODUCT = Routes.SEARCHPRODUCT;
  static const PHARMACIEN = Routes.PHARMACIEN;
  static const ORDERPHARMACIEN = Routes.ORDERPHARMACIEN;
  static const CLIENT_ORDER_LIST = Routes.CLIENT_ORDER_LIST;
  static const CLIENT_FEED_BACK_ORDER = Routes.CLIENT_FEED_BACK_ORDER;

  static final routes = [
    GetPage(
      name: _Paths.BASE,
      page: () => const BaseView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PRODUIT_LIST,
      page: () => const ProductListView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BASKET,
      page: () => const BasketView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LOGINCONTENT,
      page: () => const LoginContentView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRODUIT,
      page: () => DetailProduitView(),
      binding: DetailProduitBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAIL,
      page: () => OrderDetailView(),
      binding: OrderDetailBinding(),
    ),
    GetPage(
      name: _Paths.SEARCHPRODUCT,
      page: () => const SearchproductView(),
      binding: SearchproductBinding(),
    ),
    GetPage(
      name: _Paths.PHARMACIES,
      page: () => const PharmaciesView(),
      binding: PharmaciesBinding(),
    ),
    GetPage(
      name: _Paths.RAPPELMEDI,
      page: () => const RappelmediView(),
      binding: RappelmediBinding(),
    ),
    GetPage(
      name: _Paths.CLINIQUE,
      page: () => const CliniqueView(),
      binding: CliniqueBinding(),
    ),
    GetPage(
      name: _Paths.PAIEMENT,
      page: () => const PaiementView(),
      binding: PaiementBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESS,
      page: () => const AddressView(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: _Paths.RECEIPTPAY,
      page: () => const ReceiptpayView(),
      binding: ReceiptpayBinding(),
    ),
    GetPage(
      name: _Paths.PHARMACIEN,
      page: () => const PharmacienView(),
      binding: PharmacienBinding(),
    ),
    GetPage(
      name: _Paths.CLIENT_ORDER_LIST,
      page: () => const ClientOrderListView(),
      binding: ClientOrderListBinding(),
    ),
    GetPage(
      name: _Paths.CLIENT_FEED_BACK_ORDER,
      page: () => const ClientFeedBackOrderView(),
      binding: ClientFeedBackOrderBinding(),
    ),
  ];
}
