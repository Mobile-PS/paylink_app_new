import 'transaction_log_screen_mobile.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';

class TransactionLogScreen extends StatelessWidget {
  const TransactionLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: TransactionLogScreenMobile(),
    );
  }
}