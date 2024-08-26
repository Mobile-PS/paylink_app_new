import 'package:country_code_picker/country_code_picker.dart';

import '../../../utils/basic_screen_imports.dart';

class CountryCodePickerWidget extends StatelessWidget {
  const CountryCodePickerWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.onChanged, required this.getController,
  });

  final String hintText;
  final TextEditingController controller;
  final dynamic getController;
  final TextInputType? keyboardType;
  final ValueChanged? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.country,
          style: CustomStyle.darkHeading4TextStyle.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.headingTextSize3,
            color: CustomColor.primaryLightTextColor,
          ),
        ),
        verticalSpace(Dimensions.marginBetweenInputTitleAndBox),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
            color: CustomColor.whiteColor,
          ),
          width: double.infinity,
          child: CountryCodePicker(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingHorizontalSize * 0.1,
                vertical: Dimensions.paddingVerticalSize * 0.1),
            textStyle: Get.isDarkMode
                ? CustomStyle.darkHeading3TextStyle
                : CustomStyle.lightHeading3TextStyle.copyWith(
                    color: CustomColor.primaryLightTextColor.withOpacity(0.2),
                    fontWeight: FontWeight.w600,
                  ),
            onChanged: (value) {
              controller.text = value.name!;
              getController.selectCountryCode.value =
                  value.dialCode.toString();
              getController.selectCountry.value =
                  value.name.toString();
            },
            showOnlyCountryWhenClosed: true,
            showDropDownButton: true,
            initialSelection:
                controller.text.isNotEmpty ? controller.text : "United States",
            backgroundColor: Colors.transparent,
            showCountryOnly: true,
            alignLeft: true,
            showFlag: false,
            searchStyle: Get.isDarkMode
                ? CustomStyle.darkHeading4TextStyle
                : CustomStyle.lightHeading4TextStyle,
            dialogTextStyle: Get.isDarkMode
                ? CustomStyle.darkHeading4TextStyle
                : CustomStyle.lightHeading4TextStyle,
            onInit: (code) => {
              getController.countryController.text =
                  code!.name.toString(),
              getController.selectCountryCode.value =
                  code.dialCode.toString(),
            },
          ),
        ),
      ],
    );
  }
}