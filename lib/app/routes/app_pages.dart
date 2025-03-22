import 'package:get/get.dart';

import '../modules/Login/bindings/login_binding.dart';
import '../modules/Login/views/login_content_view.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/Register/bindings/register_binding.dart';
import '../modules/Register/views/register_view.dart';
import '../modules/detailProduit/bindings/detail_produit_binding.dart';
import '../modules/detailProduit/views/detail_produit_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/orderDetail/bindings/order_detail_binding.dart';
import '../modules/orderDetail/views/order_detail_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/trackerPeriod/bindings/tracker_period_binding.dart';
import '../modules/trackerPeriod/views/tracker_period_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;
  static const REGISTER = Routes.REGISTER;
  static const LOGINCONTENT = Routes.LOGINCONTENT;
  static const HOME = Routes.HOME;
  static const OTP = Routes.OTP;
  static const DETAIL_PRODUIT = Routes.DETAIL_PRODUIT;
  static const TRACKER_PERIOD = Routes.TRACKER_PERIOD;
  static const ORDER_DETAIL = Routes.ORDER_DETAIL;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
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
      name: _Paths.TRACKER_PERIOD,
      page: () => const TrackerPeriodView(),
      binding: TrackerPeriodBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAIL,
      page: () =>  OrderDetailView(),
      binding: OrderDetailBinding(),
    ),
  ];
}
