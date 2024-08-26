// import '../../utils/basic_widget_imports.dart';
//
// class TitleSubTitleWidget extends StatelessWidget {
//   const TitleSubTitleWidget(
//       {Key? key, required this.title, required this.subTitle})
//       : super(key: key);
//   final String title;
//   final String subTitle;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TitleHeading1Widget(
//                 text: title,
//                 color: Get.isDarkMode
//                     ? CustomColor.primaryDarkTextColor
//                     : CustomColor.primaryLightTextColor,
//                 fontWeight: FontWeight.w700,
//               ),
//               verticalSpace(Dimensions.heightSize * .5),
//               TitleHeading4Widget(
//                 text: subTitle,
//                 color: Get.isDarkMode
//                     ? CustomColor.primaryDarkTextColor.withOpacity(.6)
//                     : CustomColor.primaryLightTextColor.withOpacity(.6),
//                 fontSize: Dimensions.headingTextSize4,
//                 fontWeight: FontWeight.w500,
//               ),
//               verticalSpace(Dimensions.heightSize * .5),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import '../../utils/basic_screen_imports.dart';

class TitleSubTitleWidget extends StatelessWidget {
  const TitleSubTitleWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.subTitleFontSize,
    this.titleColor,
    this.subTitleColor,
    this.isCenterText = false,
  });
  final String title, subTitle;
  final double? subTitleFontSize;
  final Color? titleColor, subTitleColor;
  final bool isCenterText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isCenterText ? crossCenter : crossStart,
      mainAxisAlignment: isCenterText ? mainCenter : mainCenter,
      children: [
        TitleHeading2Widget(
          text: title,
          color: titleColor ?? CustomColor.primaryLightTextColor,
          fontWeight: FontWeight.w600,
          textAlign: isCenterText ? TextAlign.center : TextAlign.start,
        ),
        verticalSpace(Dimensions.marginBetweenInputTitleAndBox),
        Visibility(
          visible: subTitle != '',
          child: TitleHeading4Widget(
            text: subTitle,
            color: subTitleColor ??
                CustomColor.primaryLightTextColor.withOpacity(.2),
            fontWeight: FontWeight.w600,
            fontSize: subTitleFontSize ?? Dimensions.headingTextSize4,
            textAlign: isCenterText ? TextAlign.center : TextAlign.start,
          ),
        ),
      ],
    );
  }
}