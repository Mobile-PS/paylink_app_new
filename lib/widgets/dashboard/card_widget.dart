//import 'package:chart_sparkline/chart_sparkline.dart';

import '../../utils/basic_screen_imports.dart';
import '../others/card_logo_widget.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.title,
    required this.balance,
    required this.cardAssetLogo,
  });

  final String title, balance,  cardAssetLogo;

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Container(
      margin: EdgeInsets.only(right: Dimensions.marginSizeHorizontal * 0.3),
      padding: EdgeInsets.only(
        top: Dimensions.paddingVerticalSize * 1.3,
      ),
      decoration: ShapeDecoration(
        color: CustomColor.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: Dimensions.paddingHorizontalSize,
              right: Dimensions.paddingHorizontalSize,
              bottom: Dimensions.paddingVerticalSize * 0.5,
            ),
            child: Row(
              children: [
                CardLogoWidget(
                  assetLogoPath: cardAssetLogo,
                  height: isTablet()
                      ? Dimensions.heightSize * 2
                      : Dimensions.heightSize * 1.5,
                ),
                Column(
                  mainAxisAlignment: mainCenter,
                  crossAxisAlignment: crossStart,
                  children: [
                    TitleHeading4Widget(
                      text: title,
                      opacity: 0.6,
                      fontWeight: FontWeight.w600,
                    ),
                    TitleHeading4Widget(
                      padding: EdgeInsets.only(
                          right: Dimensions.paddingHorizontalSize * .20),
                      text: balance,
                      fontSize: Dimensions.headingTextSize3 * 2,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}