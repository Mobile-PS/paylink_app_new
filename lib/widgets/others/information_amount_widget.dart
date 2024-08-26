
import 'package:flutter/material.dart';
import '../../../utils/custom_color.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/size.dart';
import '../text_labels/title_heading2_widget.dart';
import '../text_labels/title_heading3_widget.dart';
import '../text_labels/title_heading4_widget.dart';


extension AmountInformation on Widget {
  Widget amountInformationWidget({
    required information,
    required enterAmount,
    required enterAmountRow,
    required fee,
    required feeRow,
    received,
    receivedRow,
    total,
    totalRow,
  }) {
    return Container(

      margin: EdgeInsets.only(top: Dimensions.heightSize * 0.4,
      right: Dimensions.marginSizeHorizontal * 0.5,
      left: Dimensions.marginSizeHorizontal * 0.5,
      ),
      decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.5)),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: Dimensions.paddingVerticalSize * 0.7,
              bottom: Dimensions.paddingVerticalSize * 0.3,
              left: Dimensions.paddingHorizontalSize * 0.7,
              right: Dimensions.paddingHorizontalSize * 0.7,
            ),
            child: TitleHeading2Widget(
                text: information,
                textAlign: TextAlign.left,
              color: CustomColor.primaryLightTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Divider(
            thickness: 3,
            color: CustomColor.primaryLightScaffoldBackgroundColor,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: Dimensions.paddingVerticalSize * 0.3,
              bottom: Dimensions.paddingVerticalSize * 0.6,
              left: Dimensions.paddingHorizontalSize * 0.7,
              right: Dimensions.paddingHorizontalSize * 0.7,
            ),
            child: Column(
              mainAxisAlignment: mainSpaceBet,
              children: [
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    Expanded(
                      child: TitleHeading4Widget(
                        text: enterAmount,
                        color: CustomColor.primaryLightTextColor.withOpacity(
                          0.4,
                        ),
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TitleHeading3Widget(
                          text: enterAmountRow,
                          color: CustomColor.primaryLightColor,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(Dimensions.heightSize * 0.7),
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    Expanded(
                      child: TitleHeading4Widget(
                        text: fee,
                        color: CustomColor.primaryLightTextColor.withOpacity(
                          0.4,
                        ),
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TitleHeading3Widget(
                          text: feeRow,
                          color: CustomColor.primaryLightColor,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(Dimensions.heightSize * 0.7),
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    Expanded(
                      child: TitleHeading4Widget(
                        text: received,
                        color: CustomColor.primaryLightTextColor.withOpacity(
                          0.4,
                        ),
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TitleHeading3Widget(
                          text: receivedRow,
                          color: CustomColor.primaryLightColor,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(Dimensions.heightSize * 0.7),
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  children: [
                    Expanded(
                      child: TitleHeading4Widget(
                        text: total,
                        color: CustomColor.primaryLightTextColor.withOpacity(
                          0.4,
                        ),
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TitleHeading3Widget(
                          text: totalRow,
                          color: CustomColor.primaryLightColor,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}