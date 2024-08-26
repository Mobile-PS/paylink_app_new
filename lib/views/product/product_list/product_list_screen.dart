import 'package:paylink/utils/responsive_layout.dart';
import 'package:paylink/views/product/product_list/product_list_screen_mobile.dart';

import '../../../utils/basic_screen_imports.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileScaffold: ProductListScreenMobile());
  }
}
