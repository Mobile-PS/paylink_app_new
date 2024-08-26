import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';
import '../../../../views/auth/sign_in/forgot_password_otp_screen/forgot_password_otp_screen_mobile.dart';

class ForgotPasswordOtpScreen extends StatelessWidget {
  const ForgotPasswordOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: ForgotPasswordOtpScreenMobile(),
    );
  }
}