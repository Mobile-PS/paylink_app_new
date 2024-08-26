import '../../../../extensions/custom_extensions.dart';

class ApiEndpoint {
  static const String mainDomain = "https://www.privaa.in";

  static const String baseUrl = "$mainDomain/api/v1";

  //-> basic-settings
  static String basicSettingsURL = '/basic/settings'.addBaseURl();

  //-> Login
  static String loginURL = '/user/login'.addBaseURl();

  //-> Logout
  static String logoutURL = '/user/logout'.addBaseURl();

  //-> Forgot Password
  static String forgotPasswordSendOtpURL =
      '/user/forgot/password/send/otp'.addBaseURl();
  static String forgotOtpVerifyURL =
      '/user/forgot/password/verify'.addBaseURl();
  static String resetPasswordURL = '/user/forgot/password/reset'.addBaseURl();

  //-> Register
  static String registerURL = '/user/register'.addBaseURl();
  static String registerOtpVerifyURL = '/user/email/otp/verify'.addBaseURl();
  static String registerOtpResendURL = '/user/email/resend/code'.addBaseURl();

  //-> Two F A
  static String twoFaGetURL = '/user/profile/google-2fa'.addBaseURl();
  static String twoFaSubmitURL =
      '/user/profile/google-2fa/status/update'.addBaseURl();
  static String twoFaOtoVerifyURL = '/user/google-2fa/otp/verify'.addBaseURl();

  //-> Profile
  static String profileInfoGetURL = '/user/profile'.addBaseURl();
  static String profileUpdateURL = '/user/profile/update'.addBaseURl();

  //->drawer
  static String passwordUpdateURL =
      '/user/profile/password/update'.addBaseURl();

  //-> kyc
  static String kycInfoURL = '/user/profile/kyc/input-fields'.addBaseURl();
  static String kycSubmitURL = '/user/profile/kyc/submit'.addBaseURl();

  //-> dashboard
  static String dashboardGetURL = '/user/dashboard'.addBaseURl();

  //-> payments
  static String paymentLinkGetURL = '/user/payment-links'.addBaseURl();
  static String paymentLinkEditGetURL =
      '/user/payment-links/edit?target='.addBaseURl();
  static String paymentLinkStoreURL = '/user/payment-links/store'.addBaseURl();
  static String paymentLinkUpdateURL =
      '/user/payment-links/update'.addBaseURl();
  static String statusURL = '/user/payment-links/status'.addBaseURl();

  //-> invoice
  static String invoiceGetURL = '/user/invoice'.addBaseURl();
  static String invoiceStoreURL = '/user/invoice/store'.addBaseURl();
  static String invoiceStatusUpdateURL = '/user/invoice/status'.addBaseURl();
  static String invoiceDeleteURL = '/user/invoice/delete'.addBaseURl();
  static String invoiceLinkEditGetURL =
      '/user/invoice/edit?target='.addBaseURl();
  static String invoiceLinkEditPostURL = '/user/invoice/update'.addBaseURl();
  static String invoiceDownloadPostURL =
      '/user/invoice/download/invoice?target='.addBaseURl();

  //-> money-out
  static String moneyOutGetURL = '/user/withdraw/info'.addBaseURl();
  static String moneyOutInsertURL = '/user/withdraw/insert'.addBaseURl();
  static String moneyOutAutomaticConfirmURL =
      '/user/withdraw/automatic/confirmed'.addBaseURl();
  static String moneyOutBanksInfoURL =
      '/user/withdraw/get/flutterwave/banks?trx='.addBaseURl();
  static String moneyOutAutomaticURL =
      '/user/withdraw/automatic/confirmed'.addBaseURl();
  static String moneyOutManualConfirmURL =
      '/user/withdraw/manual/confirmed'.addBaseURl();

  //-> notifications
  static String notificationsGetURL = '/user/notification/list'.addBaseURl();

  //-> delete account
  static String deleteAccountURL = '/user/profile/delete/account'.addBaseURl();

  //=> products
  static String productListURL = "/user/products".addBaseURl();
  static String statusUpdateURL = "/user/products/status".addBaseURl();
  static String productDeleteURL = "/user/products/delete".addBaseURl();
  static String productLinkDeleteURL =
      "/user/product-links/delete".addBaseURl();
  static String productStoreURL = "/user/products/store".addBaseURl();
  static String productUpdateURL = "/user/products/update".addBaseURl();
  static String productEditURL = "/user/products/edit?target=".addBaseURl();
  static String productLinkStoreURL = "/user/product-links/store".addBaseURl();

  static String productLinkUpdateURL =
      "/user/product-links/update".addBaseURl();
  static String productLinksURL =
      "/user/product-links?product_id=".addBaseURl();
  static String productLinkStatusUpdateURL =
      "/user/product-links/status".addBaseURl();
  static String productEditInfoURL =
      "/user/product-links/edit?target=".addBaseURl();
}
