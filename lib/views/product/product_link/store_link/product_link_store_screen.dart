import '/utils/responsive_layout.dart';
import '/views/product/product_link/store_link/product_link_store_screen_mobile.dart';

import '../../../../utils/basic_screen_imports.dart';

class ProductLinkStoreScreen extends StatelessWidget {
  const ProductLinkStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: ProductLinkStoreScreenMobile());
  }
}
