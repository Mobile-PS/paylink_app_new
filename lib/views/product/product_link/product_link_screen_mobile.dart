import '../../../backend/services/api_endpoint.dart';
import '../../../routes/routes.dart';
import '/backend/utils/custom_loading_api.dart';

import '/widgets/common/no_data_widget.dart';

import '../../../controller/product/product_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/product/product_link_item_widget.dart';

class ProductLinkScreenMobile extends StatelessWidget {
  ProductLinkScreenMobile({super.key});

  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (onPop) {
          Get.offAllNamed(Routes.productListScreen);
        },
        child: Scaffold(
          appBar: PrimaryAppBar(
            Strings.productLinks,
            onTap: () {
              Get.offAllNamed(Routes.productListScreen);
            },
          ),
          body: Obx(() => controller.isProductLinkLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context)),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(Routes.productLinkStoreScreen);
            },
            elevation: 3,
            backgroundColor: CustomColor.primaryLightColor,
            shape: const CircleBorder(),
            child: Icon(
              Icons.add,
              size: Dimensions.iconSizeLarge,
              color: Colors.white,
            ),
          ),
        ));
  }

  _bodyWidget(BuildContext context) {
    var data = controller.productLinkListModel.data.productLinks;
    return data.isEmpty
        ? const NoDataWidget(text: Strings.noLinkFound)
        : RefreshIndicator(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ProductLinkItemWidget(
                  status: data[index].productLinks.status == 1
                      ? "Active"
                      : "Inactive",
                  title: data[index].productLinks.price,
                  amount: data[index].productLinks.currency,
                  onEditInvoice: () {
                    controller
                        .linkEditInfoProcess(
                            data[index].productLinks.id.toString())
                        .then((value) =>
                            Get.toNamed(Routes.productLinkEditScreen));
                  },
                  onDeleteInvoice: () {
                    controller
                        .productLinkDeleteProcess(
                            data[index].productLinks.id.toString())
                        .then(
                          (value) => controller.productLinkGetProcess(
                            data[index].productLinks.productId.toString(),
                          ),
                        );
                  },
                  onCopyInvoice: () {
                    controller.copyLinkController.text =
                        "${ApiEndpoint.mainDomain}/product-link/share/${data[index].productLinks.token}";
                    controller.onCopyTap;
                  },
                  onStatusUpdate: () {
                    controller
                        .productLinkStatusUpdateProcess(
                            data[index].productLinks.id.toString(),
                            data[index].productLinks.status == 1 ? "0" : "1")
                        .then(
                          (value) => controller.productLinkGetProcess(
                            data[index].productLinks.productId.toString(),
                          ),
                        );
                  },
                  quantity: data[index].productLinks.qty.toString(),
                );
              },
              itemCount: data.length,
            ),
            onRefresh: () async {
              controller.productLinkGetProcess(
                controller.productId.value,
              );
            });
  }
}
