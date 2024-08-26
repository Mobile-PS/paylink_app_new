import '../../views/kyc_verification/kyc_verification_screen_mobile.dart';

import '../../utils/basic_screen_imports.dart';
import '../../utils/responsive_layout.dart';

class KycVerificationScreen extends StatelessWidget {
  const KycVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  ResponsiveLayout(
      mobileScaffold: KycVerificationScreenMobile(),
    );
  }
}