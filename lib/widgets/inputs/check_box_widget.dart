import '../../controller/basic_settings/basic_settings_controller.dart';
import '../../utils/basic_widget_imports.dart';
import '../../views/web_view/web_view_screen.dart';

class CheckBoxWidget extends StatelessWidget {
  CheckBoxWidget({
    super.key,
    required this.isChecked,
    this.onChecked,
    this.fontSize,
  });

  final RxBool isChecked;
  final basicSettingsController = Get.put(BasicSettingsController());
  final void Function(bool)? onChecked;

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FittedBox(
        child: Padding(
          padding: EdgeInsets.only(right: Dimensions.paddingHorizontalSize * 1.5),
          child: FittedBox(
            child: Row(
              //mainAxisAlignment: mainCenter,
              children: [
                Transform.scale(
                  scale: .7,
                  child: SizedBox(
                    height: 12.0.h,
                    width: 12.0.w,
                    child: Checkbox(
                      value: isChecked.value,
                      onChanged: (value) {
                        isChecked.value = value!;
                      },
                      activeColor: Theme.of(context).primaryColor,
                      checkColor: isChecked.value
                          ? Theme.of(context).colorScheme.background
                          : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius * 0.25),

                      ),
                      side: BorderSide(
                        width: Dimensions.widthSize*.15,
                        color: Get.isDarkMode
                            ? CustomColor.primaryDarkTextColor.withOpacity(0.50)
                            : CustomColor.primaryLightTextColor.withOpacity(0.50),
                      ),
                    ),
                  ),
                ),
                horizontalSpace(Dimensions.paddingHorizontalSize * 0.3),
                InkWell(
                  onTap: () {
                    if (isChecked.value) {
                      isChecked.value = false;
                    } else {
                      isChecked.value = true;
                    }
                  },
                  child: CustomTitleHeadingWidget(
                    text: Strings.iHaveAgreedWith,
                    style: CustomStyle.lightHeading5TextStyle.copyWith(
                        fontSize: fontSize ?? Dimensions.headingTextSize5,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.primaryLightTextColor.withOpacity(.4),
                        letterSpacing: .01,
                        wordSpacing: .01),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(
                      () => WebViewScreen(
                        title: Strings.privacyPolicy.tr,
                        url: basicSettingsController
                            .appSettingsModel.data.webLinks.privacyPolicy,
                      ),
                    );
                  },
                  child: CustomTitleHeadingWidget(
                    text: Strings.termsOfUse,
                    style: CustomStyle.lightHeading5TextStyle.copyWith(
                        fontSize: fontSize ?? Dimensions.headingTextSize5,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.primaryLightColor,
                        letterSpacing: .01,
                        wordSpacing: .01),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}