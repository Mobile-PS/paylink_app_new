import '../../utils/basic_widget_imports.dart';

class PrimaryTextAreaInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Color? color;
  final double focusedBorderWidth;
  final double enabledBorderWidth;
  final double height;
  final Color borderColor;
  final IconData? suffixIcon;
  final VoidCallback? onTap;
  final int? maxLines;

  const PrimaryTextAreaInputWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.readOnly = false,
    this.focusedBorderWidth = 2,
    this.enabledBorderWidth = 1.5,
    this.color = Colors.white,
    required this.borderColor,
    this.suffixIcon,
    this.onTap,
    this.maxLines,
    this.height = 50.00,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height,
          width: double.infinity,
          child: TextFormField(
            style: Get.isDarkMode
                ? CustomStyle.darkHeading3TextStyle
                : CustomStyle.lightHeading3TextStyle,
            readOnly: readOnly!,
            // style: CustomStyle.textStyle,
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
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
              filled: true,
              fillColor: color,
              contentPadding: const EdgeInsets.only(
                  left: 10, right: 10, top: 20, bottom: 10),
              hintText: hintText,
              hintStyle: Get.isDarkMode
                  ? CustomStyle.darkHeading3TextStyle.copyWith(
                      color: CustomColor.primaryDarkTextColor.withOpacity(0.3),
                      fontWeight: FontWeight.normal,
                    )
                  : CustomStyle.lightHeading3TextStyle.copyWith(
                      color: CustomColor.primaryLightTextColor.withOpacity(0.3),
                      fontWeight: FontWeight.normal,
                    ),
              suffixIcon: suffixIcon == null
                  ? const SizedBox.shrink()
                  : GestureDetector(
                      onTap: onTap,
                      child: Icon(
                        suffixIcon,
                        color: Theme.of(context).primaryColor,
                        size: Dimensions.iconSizeDefault * 1.4,
                      ),
                    ),
            ),
          ),
        )
        // CustomSize.heightBetween()
      ],
    );
  }
}