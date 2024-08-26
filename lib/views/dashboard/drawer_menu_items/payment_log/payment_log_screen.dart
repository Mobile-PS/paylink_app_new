import '/views/dashboard/drawer_menu_items/payment_log/payment_log_screen_mobile.dart';

import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';

class PaymentLogScreen extends StatelessWidget {
  const PaymentLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: PaymentLogScreenMobile(),
    );
  }
}