import '../../../../../views/dashboard/invoice/invoice_screen/invoice_screen_mobile.dart';

import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: InvoiceScreenMobile(),
    );
  }
}