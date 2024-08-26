import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';
import '../../../../views/auth/sign_in/two_fa_otp_verification_screen/two_fa_otp_verification_screen_mobile.dart';

class TwoFaOtpVerificationScreen extends StatelessWidget {
  const TwoFaOtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: TwoFaOtpVerificationScreenMobile(),
    );
  }
}