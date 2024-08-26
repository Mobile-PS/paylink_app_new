import '../../utils/basic_widget_imports.dart';

class PhoneNumberWithCountryCodeInput extends StatelessWidget {
  const PhoneNumberWithCountryCodeInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.readOnly = false,
    this.focusedBorderWidth = 2,
    this.enabledBorderWidth = 1.5,
    this.color = Colors.white,
    required this.borderColor,
  });
  final TextEditingController controller;
  final String hintText;
  final bool? readOnly;
  final Color? color;
  final double focusedBorderWidth;
  final double enabledBorderWidth;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    // final authController = Get.put(SignUpController());
    return SizedBox(
      height: Dimensions.inputBoxHeight,
      width: double.infinity,
      child: TextFormField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.left,
        controller: controller,
        validator: (String? value) {
          if (value!.isEmpty) {
            return Strings.pleaseFillOutTheField;
          } else {
            return null;
          }
        },
        style: Get.isDarkMode
            ? CustomStyle.darkHeading4TextStyle
            : CustomStyle.lightHeading4TextStyle,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: BorderSide(
                  color: borderColor.withOpacity(0.4),
                  width: enabledBorderWidth),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: borderColor, width: focusedBorderWidth),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            hintText: hintText,
            hintStyle: Get.isDarkMode
                ? CustomStyle.darkHeading3TextStyle.copyWith(
                    color: CustomColor.primaryDarkTextColor.withOpacity(0.3),
                    fontWeight: FontWeight.normal,
                    fontSize: Dimensions.headingTextSize5,
                  )
                : CustomStyle.lightHeading3TextStyle.copyWith(
                    color: CustomColor.primaryLightTextColor.withOpacity(0.3),
                    fontWeight: FontWeight.normal,
                    fontSize: Dimensions.headingTextSize5,
                  ),
            alignLabelWithHint: true,
            contentPadding: const EdgeInsets.only(left: 5, top: 0),
            prefixIcon: Obx(() {
              return const SizedBox(
                width: 39,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // TitleHeading4Widget(text: ' ${authController.countryCode.value}', padding: EdgeInsets.only(bottom: Dimensions.heightSize * 0.1),)
                  ],
                ),
              );
            })),
      ),
    );
  }
}