import 'package:flutter_html/flutter_html.dart';
import '../../../../../backend/utils/custom_loading_api.dart';
import '../../../../../controller/drawer/money_out_controller/money_out_controller.dart';
import '../../../../../routes/routes.dart';
import '../../../../../utils/basic_screen_imports.dart';

class MoneyOutManualScreenMobile extends StatelessWidget {
  MoneyOutManualScreenMobile({super.key});
  final controller = Get.put(MoneyOutController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) async {
        Get.offAllNamed(Routes.dashboardScreen);

      },
      canPop: true,
      child: Scaffold(
        appBar:  const PrimaryAppBar( Strings.evidenceNote),
        body: Obx(
              () => controller.isLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingHorizontalSize * 0.7,
        vertical: Dimensions.paddingVerticalSize * 0.7,
      ),
      child: Form(
        key: formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            _descriptionWidget(context),
            ...controller.inputFields.map((element) {
              return element;
            }),
            _buttonWidget(context)
          ],
        ),
      ),
    );
  }
  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.marginSizeVertical),
      child: Obx(() => controller.isInsertLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
        title: Strings.payNow.tr,
        onPressed: () {
         Get.toNamed(Routes.moneyOutPreviewScreen);
        },
      )),
    );
  }

  _descriptionWidget(BuildContext context) {
    final data = controller.moneyOutInsertModel.data;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.paddingVerticalSize * 0.5,
          horizontal: Dimensions.paddingHorizontalSize * 0.2),
      margin:
      EdgeInsets.symmetric(vertical: Dimensions.marginSizeVertical * 0.4),
      decoration: BoxDecoration(
          color: CustomColor.primaryLightColor,
          borderRadius: BorderRadius.circular(Dimensions.radius),
          border: Border.all(
            width: 0.8,
            color: Theme.of(context).primaryColor,
          )),
      child:
      Html(
        data: Get.isDarkMode
            ? data.details.replaceAll(
            'color:hsl(0, 0%, 0%)', 'color:hsl(0, 0%, 100%)')
            : data.details,
      ),
    );
  }
}