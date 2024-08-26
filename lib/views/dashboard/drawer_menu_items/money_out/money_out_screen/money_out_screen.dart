import '/views/dashboard/drawer_menu_items/money_out/money_out_screen/money_out_screen_mobile.dart';

import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';

class MoneyOutScreen extends StatelessWidget {
  const MoneyOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: MoneyOutScreenMobile(),
    );
  }
}