import '/utils/responsive_layout.dart';
import '/views/product/product_link/product_link_edit/product_link_edit_screen_mobile.dart';

import '../../../../utils/basic_screen_imports.dart';

class ProductLinkEditScreen extends StatelessWidget {
  const ProductLinkEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: ProductLinkEditScreenMobile());
  }
}
