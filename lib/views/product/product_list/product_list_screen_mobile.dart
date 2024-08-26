import '../../../routes/routes.dart';
import '/widgets/common/no_data_widget.dart';

import '/backend/services/api_endpoint.dart';
import '/backend/utils/custom_loading_api.dart';

import '../../../controller/product/product_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/product/product_item_widget.dart';

class ProductListScreenMobile extends StatelessWidget {
  ProductListScreenMobile({super.key});

  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (onPop) async {
        await Get.offAllNamed(Routes.dashboardScreen);
      },
      child: Scaffold(
        appBar: PrimaryAppBar(
          Strings.products,
          onTap: () {
            Get.offAllNamed(Routes.dashboardScreen);
          },
        ),
        body: Obx(() =>
        controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context)),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.userImage.value =
            "${ApiEndpoint.mainDomain}/${controller.productListInfoModel.data
                .defaultImage}";
            Get.toNamed(Routes.productStoreScreen);
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
      ),
    );
  }

  //
  _bodyWidget(BuildContext context) {
    var data = controller.productListInfoModel.data.products;
    var imagePath =
        "${ApiEndpoint.mainDomain}/${controller.productListInfoModel.data
        .imagePath}";
    var defaultImage =
        "${ApiEndpoint.mainDomain}/${controller.productListInfoModel.data
        .defaultImage}";
    return data.isEmpty
        ? const NoDataWidget(text: Strings.noProductFound)
        : RefreshIndicator(
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ProductItemWidget(
                status: data[index].status == 1 ? "Active" : "Inactive",
                title: data[index].productName,
                amount: "${data[index].price} ${data[index].currency}",
                onLinkList: () {
                  controller.productId.value = data[index].id.toString();
                  controller
                      .productLinkGetProcess(data[index].id.toString())
                      .then((value) =>
                      Get.toNamed(Routes.productLinkListScreen));
                },
                onEditInvoice: () {
                  controller
                      .productEditInfoProcess(data[index].id.toString())
                      .then(
                          (value) => Get.toNamed(Routes.productEditScreen));
                },
                onDeleteInvoice: () {
                  controller.deleteProcess(data[index].id.toString()).then(
                          (value) => controller.productListInfoGetProcess());
                },
                onStatusUpdate: () {
                  controller
                      .statusUpdateProcess(data[index].id.toString())
                      .then((value) =>
                      controller.productListInfoGetProcess());
                },
                image: data[index].image == null
                    ? defaultImage
                    : "$imagePath/${data[index].image}",
                desc: data[index].desc == null ? "" : "${data[index].desc}",
              );
            }),
        onRefresh: () async {
          await controller.productListInfoGetProcess();
        });
  }
}
