import 'package:get/get.dart';
import 'package:paylink/views/product/product_edit/product_edit_screen.dart';
import 'package:paylink/views/product/product_link/product_link_screen.dart';
import 'package:paylink/views/product/product_link/store_link/product_link_store_screen.dart';
import 'package:paylink/views/product/product_list/product_list_screen.dart';
import 'package:paylink/views/product/product_store/product_store_screen.dart';
import '../views/dashboard/drawer_menu_items/money_out/money_out_automatic_screen/money_out_automatic_screen.dart';
import '../views/product/product_link/product_link_edit/product_link_edit_screen.dart';
import '/views/dashboard/payments_screen/payments_edit/payments_edit_screen.dart';
import '/views/onboard_screen/onboard_screen.dart';

import '../../../../routes/routes.dart';
import '../bindings/splash_screen_binding.dart';
import '../views/auth/sign_in/two_fa_otp_verification_screen/two_fa_otp_verification_screen.dart';
import '../views/dashboard/dashboard_screen/dashboard_screen.dart';
import '../views/dashboard/drawer_menu_items/change_password/change_password_screen.dart';
import '../views/dashboard/drawer_menu_items/money_out/money_out_manual_screen/money_out_manual_screen.dart';
import '../views/dashboard/drawer_menu_items/money_out/money_out_preview_screen/money_out_preview_screen.dart';
import '../views/dashboard/drawer_menu_items/money_out/money_out_screen/money_out_screen.dart';
import '../views/dashboard/drawer_menu_items/notifications/notifications_screen.dart';
import '../views/dashboard/drawer_menu_items/payment_log/payment_log_screen.dart';
import '../views/dashboard/invoice/invoice_log/invoice_log_screen.dart';
import '../views/dashboard/transaction_log/transaction_log_screen.dart';
import '../views/dashboard/drawer_menu_items/two_f_a/two_f_a_security_screen.dart';
import '../views/dashboard/invoice/invoice_screen/invoice_screen.dart';
import '../views/dashboard/invoice/preview_screen/preview_screen.dart';
import '../views/dashboard/payments_screen/payments_screen.dart';
import '../views/dashboard/update_profile/update_profile_screen.dart';
import '../views/auth/sign_in/forgot_password_otp_screen/forgot_password_otp_screen.dart';
import '../views/auth/sign_in/reset_password_screen/reset_password_screen.dart';
import '../views/auth/sign_in/sign_in_screen/sign_in_screen.dart';
import '../views/auth/sign_up/email_verification_screen/email_verification_screen.dart';
import '../views/auth/sign_up/sign_up_screen/sign_up_screen.dart';
import '../views/kyc_verification/kyc_verification_screen.dart';
import '../views/splash_screen/splash_screen.dart';
import '../widgets/others/flutter_web_screen.dart';

class RoutePageList {
  static var list = [
    GetPage(
      name: Routes.splashScreen,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(name: Routes.onboardScreen, page: () => const OnboardScreen()),
    GetPage(
        name: Routes.productListScreen, page: () => const ProductListScreen()),
    GetPage(
      name: Routes.signInScreen,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: Routes.forgotPasswordOtpScreen,
      page: () => const ForgotPasswordOtpScreen(),
    ),
    GetPage(
      name: Routes.productLinkStoreScreen,
      page: () => const ProductLinkStoreScreen(),
    ),
    GetPage(
      name: Routes.resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
    ),
    GetPage(
      name: Routes.resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
    ),
    GetPage(
      name: Routes.signUpScreen,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: Routes.emailVerificationScreen,
      page: () => const EmailVerificationScreen(),
    ),
    GetPage(
      name: Routes.dashboardScreen,
      page: () => const DashboardScreen(),
    ),
    GetPage(
      name: Routes.twoFaSecurityScreen,
      page: () => const TwoFaSecurityScreen(),
    ),
    GetPage(
      name: Routes.paymentLogScreen,
      page: () => const PaymentLogScreen(),
    ),
    GetPage(
      name: Routes.transactionLogScreen,
      page: () => const TransactionLogScreen(),
    ),
    GetPage(
      name: Routes.kycVerificationScreen,
      page: () => const KycVerificationScreen(),
    ),
    GetPage(
      name: Routes.productLinkListScreen,
      page: () => const ProductLinkScreen(),
    ),
    GetPage(
      name: Routes.twoFaOtpVerificationScreen,
      page: () => const TwoFaOtpVerificationScreen(),
    ),
    GetPage(
      name: Routes.moneyOutScreen,
      page: () => const MoneyOutScreen(),
    ),
    GetPage(
      name: Routes.moneyOutManualScreen,
      page: () => const MoneyOutManualScreen(),
    ),
    GetPage(
      name: Routes.moneyOutPreviewScreen,
      page: () => const MoneyOutPreviewScreen(),
    ),
    GetPage(
      name: Routes.changePasswordScreen,
      page: () => ChangePasswordScreen(),
    ),
    GetPage(
      name: Routes.updateProfileScreen,
      page: () => const UpdateProfileScreen(),
    ),
    GetPage(
      name: Routes.paymentsScreen,
      page: () => const PaymentsScreen(),
    ),
    GetPage(
      name: Routes.paymentsEditScreen,
      page: () => const PaymentsEditScreen(),
    ),
    GetPage(
      name: Routes.invoiceLogScreen,
      page: () => const InvoiceLogScreen(),
    ),
    GetPage(
      name: Routes.invoiceScreen,
      page: () => const InvoiceScreen(),
    ),
    GetPage(
      name: Routes.previewScreen,
      page: () => const PreviewScreen(),
    ),
    GetPage(
      name: Routes.flutterWebScreen,
      page: () => FlutterWebScreen(),
    ),
    GetPage(
      name: Routes.notificationsScreen,
      page: () => const NotificationsScreen(),
    ),
    GetPage(
      name: Routes.productStoreScreen,
      page: () => const ProductStoreScreen(),
    ),
    GetPage(
      name: Routes.productEditScreen,
      page: () => ProductEditScreenMobile(),
    ),
    GetPage(
      name: Routes.productLinkEditScreen,
      page: () => const ProductLinkEditScreen(),
    ),
    GetPage(
      name: Routes.moneyOutAutomaticScreen,
      page: () => MoneyOutAutomaticInsertScreen(),
    ),
  ];
}
