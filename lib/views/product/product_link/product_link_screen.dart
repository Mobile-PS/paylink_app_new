import '/utils/responsive_layout.dart';
import '/views/product/product_link/product_link_screen_mobile.dart';

import '../../../utils/basic_screen_imports.dart';

class ProductLinkScreen extends StatelessWidget {
  const ProductLinkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: ProductLinkScreenMobile());
  }
}
