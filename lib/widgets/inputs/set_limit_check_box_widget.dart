import '../../utils/basic_widget_imports.dart';

class SetLimitCheckBoxWidget extends StatelessWidget {
  const SetLimitCheckBoxWidget({
    super.key,
    required this.isChecked,
    this.onChecked,
    this.fontSize ,
  });
  final RxBool isChecked;
  final void Function(bool)? onChecked;

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Padding(
        padding:  EdgeInsets.only(right: Dimensions.paddingHorizontalSize*1.5),
        child: Row(
          mainAxisAlignment: mainCenter,
          children: [
            GestureDetector(
              onTap: () {
                isChecked.value = !isChecked.value;
                onChecked!(isChecked.value);
              },
              child: Row(
                mainAxisAlignment: mainCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: CustomColor.transparentColor,
                      border: Border.all(
                        width: 1.5,
                        color: CustomColor.primaryLightTextColor.withOpacity(0.2),
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      size: Dimensions.heightSize*.70,
                      color: isChecked.value
                          ? CustomColor.primaryLightColor
                          : CustomColor.primaryLightScaffoldBackgroundColor,
                    ),
                  ),
                  horizontalSpace(Dimensions.widthSize * 0.5),
                  CustomTitleHeadingWidget(
                    text: Strings.setLimit,
                    style: CustomStyle.lightHeading5TextStyle.copyWith(
                        fontSize: fontSize?? Dimensions.headingTextSize6,
                        fontWeight: FontWeight.w500,
                        color: CustomColor.primaryLightTextColor.withOpacity(.6),
                        ),
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