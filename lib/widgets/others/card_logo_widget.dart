import '../../../../../widgets/others/custom_image_widget.dart';

import '../../utils/basic_screen_imports.dart';

class CardLogoWidget extends StatelessWidget {
  const CardLogoWidget({super.key, this.height, required this.assetLogoPath});

  final double? height;
  final String assetLogoPath;

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.primaryLightScaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(Dimensions.radius * .5),
      ),
      margin: EdgeInsets.only(right: Dimensions.marginSizeVertical * .25),
      child: CustomImageWidget(
        path: assetLogoPath,
        height: height ?? MediaQuery.of(context).size.height * .15,
        fit: BoxFit.cover,
      ).paddingSymmetric(
          horizontal: isTablet()? Dimensions.paddingHorizontalSize * .6:Dimensions.paddingHorizontalSize * .5,
          vertical: Dimensions.paddingVerticalSize * .5),
    );
  }
}