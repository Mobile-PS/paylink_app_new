import '../../utils/basic_screen_imports.dart';

class NotificationsWidget extends StatelessWidget {
  const NotificationsWidget(
      {super.key,
      required this.monthText,
      required this.dateText,
      required this.title,
      required this.message});

  final String monthText, dateText, title, message;

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.paddingVerticalSize * 0.08),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
          color: CustomColor.whiteColor,
        ),
        padding: EdgeInsets.only(right: Dimensions.paddingHorizontalSize * 0.2),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.only(
                  left: Dimensions.marginSizeHorizontal * 0.4,
                  top: Dimensions.marginSizeVertical * 0.4,
                  bottom: Dimensions.marginSizeVertical * 0.4,
                  right: Dimensions.marginSizeHorizontal * 0.2,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: isTablet()
                      ? Dimensions.paddingVerticalSize * 0.5
                      : Dimensions.paddingVerticalSize * 0.2,
                  horizontal: Dimensions.paddingHorizontalSize * 0.2,
                ),
                decoration: BoxDecoration(
                    color: CustomColor.primaryLightScaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius)),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: mainCenter,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: crossCenter,
                  children: [
                    TitleHeading1Widget(
                      text: dateText,
                      fontSize: isTablet()
                          ? Dimensions.headingTextSize1 * 1.7
                          : Dimensions.headingTextSize1 * 1.5,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.primaryLightColor,
                    ),
                    TitleHeading5Widget(
                      text: monthText,
                      fontWeight: FontWeight.w600,
                      fontSize: isTablet()
                          ? Dimensions.headingTextSize5
                          : Dimensions.headingTextSize6,
                      color: CustomColor.primaryLightColor,
                    ),
                  ],
                ),
              ),
            ),
            horizontalSpace(Dimensions.widthSize),
            Expanded(
              flex: 13,
              child: Column(
                crossAxisAlignment: crossStart,
                mainAxisAlignment: mainCenter,
                children: [
                  TitleHeading5Widget(
                    text: title,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensions.headingTextSize3,
                    color: CustomColor.blackColor,
                  ),
                  verticalSpace(Dimensions.widthSize * 0.4),
                  TitleHeading5Widget(
                    padding: EdgeInsets.only(
                      right: Dimensions.paddingHorizontalSize * .05,
                    ),
                    maxLines: 3,
                    text: message,
                    fontSize: Dimensions.headingTextSize5,
                    fontWeight: FontWeight.w600,
                    color: CustomColor.primaryLightColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}