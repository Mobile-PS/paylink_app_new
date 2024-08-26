import 'package:paylink/views/dashboard/invoice/invoice_log/invoice_log_screen_mobile.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';

class InvoiceLogScreen extends StatelessWidget {
  const InvoiceLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: InvoiceLogScreenMobile(),
    );
  }
}