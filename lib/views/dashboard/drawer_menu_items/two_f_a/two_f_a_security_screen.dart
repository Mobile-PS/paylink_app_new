
import '../../../../../views/dashboard/drawer_menu_items/two_f_a/two_f_a_security_screen_mobile.dart';

import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';

class TwoFaSecurityScreen extends StatelessWidget {
  const TwoFaSecurityScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: TwoFaSecurityScreenMobile(
      ),
    );
  }
}