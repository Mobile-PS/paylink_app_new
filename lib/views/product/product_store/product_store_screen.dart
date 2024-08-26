import '/utils/responsive_layout.dart';
import '/views/product/product_store/product_store_screen_mobile.dart';

import '../../../utils/basic_screen_imports.dart';

class ProductStoreScreen extends StatelessWidget {
  const ProductStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: ProductStoreScreenMobile());
  }
}
