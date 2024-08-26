import '../../../../../../../../../views/dashboard/drawer_menu_items/money_out/money_out_manual_screen/money_out_manual_screen_mobile.dart';
import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';

class MoneyOutManualScreen extends StatelessWidget {
  const MoneyOutManualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: MoneyOutManualScreenMobile(),
    );
  }
}