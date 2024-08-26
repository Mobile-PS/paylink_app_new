import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_color.dart';
import 'dimensions.dart';

class CustomStyle {
//------------------------dark--------------------------------
  static var darkHeading1TextStyle = GoogleFonts.inter (
    color: CustomColor.primaryDarkTextColor,
    fontSize: Dimensions.headingTextSize1,
    fontWeight: FontWeight.w700,
  );
  static var darkHeading2TextStyle = GoogleFonts.inter(
    color: CustomColor.primaryDarkTextColor,
    fontSize: Dimensions.headingTextSize2,
    fontWeight: FontWeight.w700,
  );
  static var darkHeading3TextStyle = GoogleFonts.inter(
    color: CustomColor.primaryDarkTextColor,
    fontSize: Dimensions.headingTextSize3,
    fontWeight: FontWeight.w700,
  );
  static var darkHeading4TextStyle = GoogleFonts.inter(
    color: CustomColor.primaryDarkTextColor,
    fontSize: Dimensions.headingTextSize4,
    fontWeight: FontWeight.w400,
  );
  static var darkHeading5TextStyle = GoogleFonts.inter(
    color: CustomColor.primaryDarkTextColor,
    fontSize: Dimensions.headingTextSize5,
    fontWeight: FontWeight.w400,
  );

//------------------------light--------------------------------
  static var lightHeading1TextStyle = GoogleFonts.inter(
    color: CustomColor.primaryLightTextColor,
    fontSize: Dimensions.headingTextSize1,
    fontWeight: FontWeight.w700,
  );
  static var lightHeading2TextStyle = GoogleFonts.inter(
    color: CustomColor.primaryLightTextColor,
    fontSize: Dimensions.headingTextSize2,
    fontWeight: FontWeight.w700,
  );
  static var lightHeading3TextStyle = GoogleFonts.inter(
    color: CustomColor.primaryLightTextColor,
    fontSize: Dimensions.headingTextSize3,
    fontWeight: FontWeight.normal,
  );
  static var lightHeading4TextStyle = GoogleFonts.inter(
    color: CustomColor.primaryLightTextColor,
    fontSize: Dimensions.headingTextSize4,
    fontWeight: FontWeight.w400,
  );
  static var lightHeading5TextStyle = GoogleFonts.inter(
    color: CustomColor.primaryLightTextColor,
    fontSize: Dimensions.headingTextSize5,
    fontWeight: FontWeight.w400,
  );

  static var screenGradientBG2 = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
        CustomColor.primaryDarkColor,
        CustomColor.primaryBGDarkColor,
      ]));

// Button
//
//   static var secondaryButtonStyle = ElevatedButton.styleFrom(
//     elevation: 0,
//     backgroundColor: Colors.white,
//     shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(5))),
//   );
//   // Category
//   static var categoryButtonStyle = ElevatedButton.styleFrom(
//     elevation: 0,
//     backgroundColor: Colors.white,
//     shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(5))),
//   );
}