import '../../../../../controller/drawer/two_fa_security_controller/two_fa_security_controller.dart';
import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../widgets/others/title_subtitle_widget.dart';
import '../../../../backend/utils/custom_loading_api.dart';

class TwoFaSecurityScreenMobile extends StatelessWidget {
  TwoFaSecurityScreenMobile({super.key});

  final controller = Get.put(TwoFaSecurityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(Strings.twoFASecurity),
      body: Obx(() => controller.isLoading
          ? const CustomLoadingAPI()
          : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: mainCenter,
      children: [
        _qrCodeWidget(context),
        _titleSubTitleWidget(context),
        _enableButtonWidget(context),
      ],
    ).paddingSymmetric(horizontal: Dimensions.marginSizeHorizontal * 0.8);
  }

  _qrCodeWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingHorizontalSize * .2,
          vertical: Dimensions.paddingHorizontalSize * .2),
      margin: EdgeInsets.symmetric(
          horizontal: Dimensions.marginSizeHorizontal * 2,
          vertical: Dimensions.marginSizeVertical * 2),
      decoration: BoxDecoration(
        color: CustomColor.whiteColor,
        borderRadius: BorderRadius.circular(
          Dimensions.radius,
        ),
      ),
      child: Center(
        child: Image.network(
          controller.qrCode.value,
          scale: 1,
        ),
      ),
    );
  }

  _enableButtonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.marginSizeVertical),
      child: Obx(
        () => controller.isSubmitLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: controller.status.value == 0
                    ? Strings.enable
                    : Strings.disable,
                onPressed: () {
                  controller.onEnableOrDisable;
                },
              ),
      ),
    );
  }

  _titleSubTitleWidget(BuildContext context) {
    return TitleSubTitleWidget(
      title: Strings.enable2faSecurity,
      subTitle: Strings.weWillAskFor,
      isCenterText: true,
      subTitleFontSize: Dimensions.headingTextSize4 * 0.9,
    );
  }
}