
import '../../../../../views/dashboard/invoice/preview_screen/preview_screen_mobile.dart';

import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: PreviewScreenMobile(),
    );
  }
}