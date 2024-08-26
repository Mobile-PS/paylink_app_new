import 'package:iconsax/iconsax.dart';

import '../../utils/basic_widget_imports.dart';

class PasswordInputWidget extends StatefulWidget {
  const PasswordInputWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.readOnly = false,
    this.focusedBorderWidth = 2,
    this.enabledBorderWidth = 2.5,
    this.errorBorderWidth = 2,
    this.focusedErrorBorderWidth = 2,
    this.color = Colors.white,
    required this.borderColor,
    required this.labelText,
  });
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Color? color;
  final double focusedBorderWidth;
  final double enabledBorderWidth;
  final double errorBorderWidth;
  final double focusedErrorBorderWidth;
  final Color borderColor;

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  bool isVisibility = true;
  FocusNode? focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleHeading4Widget(
          text: widget.labelText,
          textAlign: TextAlign.left,
          fontSize: Dimensions.headingTextSize3,
          padding: EdgeInsets.only(bottom: Dimensions.paddingVerticalSize * .25),
        ),
        SizedBox(
          width: double.infinity,
          child: TextFormField(
            readOnly: false,
            style: Get.isDarkMode
                ? CustomStyle.darkHeading4TextStyle.copyWith(
                color: CustomColor.primaryDarkColor,
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.headingTextSize3)
                : CustomStyle.lightHeading4TextStyle.copyWith(
                color: CustomColor.primaryLightColor,
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.headingTextSize3),
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            validator: (String? value) {
              if (value!.isEmpty) {
                return Strings.pleaseFillOutTheField;
              } else {
                return null;
              }
            },
            onTap: () {
              setState(() {
                focusNode!.requestFocus();
              });
            },
            onFieldSubmitted: (value) {
              setState(() {
                focusNode!.unfocus();
              });
            },
            focusNode: focusNode,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius * 0.5),
                  topRight: Radius.circular(Dimensions.radius * 0.5),
                ),
                borderSide: BorderSide(
                  color: widget.borderColor.withOpacity(0.4),
                  width: widget.enabledBorderWidth,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius * 0.8),
                  topRight: Radius.circular(Dimensions.radius * 0.8),
                ),
                borderSide: BorderSide(
                  color: CustomColor.primaryLightColor,
                  width: widget.focusedBorderWidth,
                ),
              ),
              errorBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius * 0.8),
                  topRight: Radius.circular(Dimensions.radius * 0.8),
                ),
                borderSide: BorderSide(
                    color: Colors.red, width: widget.errorBorderWidth),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius * 0.8),
                  topRight: Radius.circular(Dimensions.radius * 0.8),
                ),
                borderSide: BorderSide(
                    color: Colors.red, width: widget.focusedErrorBorderWidth),
              ),
              filled: true,
              fillColor: focusNode!.hasFocus
                  ? CustomColor.primaryLightColor.withOpacity(.15)
                  : CustomColor.whiteColor.withOpacity(.06),
              contentPadding: EdgeInsets.only(
                  left: Dimensions.paddingHorizontalSize * .75,
                  right: Dimensions.paddingHorizontalSize * .5,
                  top: Dimensions.paddingVerticalSize * .5,
                  bottom: Dimensions.paddingVerticalSize * .5),
              hintText: widget.hintText,
              hintStyle: Get.isDarkMode
                  ? CustomStyle.darkHeading3TextStyle.copyWith(
                color: CustomColor.primaryDarkTextColor.withOpacity(0.15),
                fontWeight: FontWeight.w500,
                fontSize: Dimensions.headingTextSize3,
              )
                  : CustomStyle.lightHeading3TextStyle.copyWith(
                color:
                CustomColor.primaryLightTextColor.withOpacity(0.15),
                fontWeight: FontWeight.w500,
                fontSize: Dimensions.headingTextSize3,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isVisibility ? Iconsax.eye_slash : Iconsax.eye,
                  color: focusNode!.hasFocus
                      ? CustomColor.primaryLightColor
                      : CustomColor.whiteColor.withOpacity(.3),
                  size: Dimensions.iconSizeDefault,
                ),
                color: widget.color,
                onPressed: () {
                  setState(() {
                    isVisibility = !isVisibility;
                  });
                },
              ),
            ),
            obscureText: isVisibility,
          ),
        )
      ],
    );
  }
}