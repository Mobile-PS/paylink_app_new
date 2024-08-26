import 'package:intl/intl.dart';

import '../../../../backend/utils/custom_loading_api.dart';
import '../../../../controller/dashboard/invoice/invoice_controller.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_widget_imports.dart';
import '../../../../widgets/appbar/primary_appbar.dart';
import '../../../../widgets/buttons/primary_button.dart';
import '../../../../widgets/inputs/custom_divider.dart';

class PreviewScreenMobile extends StatelessWidget {
  PreviewScreenMobile({super.key});

  final controller = Get.put(InvoiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        Strings.preview,
        appbarSize: Dimensions.heightSize * 3.5,
      ),
      body: Obx(() => controller.isInvoiceStoreLoading
          ? const CustomLoadingAPI()
          : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(right: Dimensions.paddingHorizontalSize),
      physics: const BouncingScrollPhysics(),
      children: [
        _previewWidget(context),
        _summaryWidget(context),
        _buttonWidget(context),
      ],
    );
  }

  _previewWidget(BuildContext context) {

    var data = controller.invoiceStoreModel.data;

    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.paddingHorizontalSize * .75),
                color: CustomColor.primaryLightColor.withOpacity(.1),
                child: Column(
                  mainAxisAlignment: mainStart,
                  crossAxisAlignment: crossStart,
                  children: [
                    SizedBox(
                      height: isTablet()
                          ? Dimensions.heightSize * 11.2
                          : Dimensions.heightSize * 09.5,
                    ),
                    TitleHeading4Widget(
                      text: data.invoice.title.toUpperCase(),
                      fontWeight: FontWeight.w600,
                      color: CustomColor.primaryLightTextColor.withOpacity(.6),
                      padding: EdgeInsets.only(
                        bottom: Dimensions.paddingVerticalSize * .25,
                      ),
                    ),
                    TitleHeading4Widget(
                      text: data.invoice.phone,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.left,
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.paddingVerticalSize * .25),
                    ),
                    verticalSpace(MediaQuery.sizeOf(context).height * .35),
                    TitleHeading5Widget(
                      text: Strings.quantity,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.left,
                      opacity: .6,
                      padding: EdgeInsets.only(
                          top: Dimensions.paddingVerticalSize * .5),
                    ),
                    TitleHeading5Widget(
                      text: Strings.total,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.left,
                      opacity: .6,
                      padding: EdgeInsets.only(
                          top: Dimensions.paddingVerticalSize * .5),
                    ),
                    TitleHeading4Widget(
                      text: Strings.dueAmountText,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.left,
                      opacity: .6,
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.paddingVerticalSize * .75),
                    ),
                    verticalSpace(MediaQuery.sizeOf(context).height * .03),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: CustomColor.transparentColor,
                child: Column(
                  mainAxisAlignment: mainEnd,
                  crossAxisAlignment: crossEnd,
                  children: [
                    TitleHeading4Widget(
                      text: data.invoice.title.toUpperCase(),
                      fontWeight: FontWeight.w600,
                      padding: EdgeInsets.only(
                        bottom: isTablet()
                            ? Dimensions.paddingVerticalSize * 4.5
                            : Dimensions.paddingVerticalSize * 4,
                        top: Dimensions.paddingVerticalSize * .25,
                        left: Dimensions.paddingHorizontalSize * .2,
                      ),
                    ),
                    TitleHeading4Widget(
                      text: Strings.billToText,
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingHorizontalSize * .75),
                      color: CustomColor.primaryLightTextColor.withOpacity(.6),
                    ),
                    TitleHeading4Widget(
                      text: data.invoice.name,
                      fontWeight: FontWeight.w600,
                      padding: EdgeInsets.only(
                        top: Dimensions.paddingVerticalSize * .5,
                        right: Dimensions.paddingHorizontalSize * .75,
                        left: Dimensions.paddingHorizontalSize * .75,
                      ),
                    ),
                    TitleHeading4Widget(
                      text: data.invoice.email,
                      fontWeight: FontWeight.w600,
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingHorizontalSize * .75),
                    ),
                    verticalSpace(MediaQuery.sizeOf(context).height * .35),
                    TitleHeading5Widget(
                      text: data.invoice.qty.toString(),
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.left,
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.paddingVerticalSize * .25,
                          horizontal: Dimensions.paddingHorizontalSize * .75),
                    ),
                    TitleHeading5Widget(
                      text:
                          '${double.parse(data.invoice.amount).toStringAsFixed(4).toString()} ${data.invoice.currency}',
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.left,
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.paddingVerticalSize * .25,
                          horizontal: Dimensions.paddingHorizontalSize * .75),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingHorizontalSize * .5),
                      child: const CustomDivider(),
                    ),
                    TitleHeading4Widget(
                      text:
                          '${double.parse(data.invoice.amount).toStringAsFixed(4).toString()} ${data.invoice.currency}',
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.left,
                      padding: EdgeInsets.only(
                        // top: Dimensions.paddingVerticalSize * .25,
                        bottom: Dimensions.paddingVerticalSize * .25,
                        right: Dimensions.paddingHorizontalSize * .75,
                        left: Dimensions.paddingHorizontalSize * .75,
                      ),
                    ),
                    verticalSpace(MediaQuery.sizeOf(context).height * .03),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: isTablet()? Dimensions.heightSize * 3.8: Dimensions.heightSize * 2.7,
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            margin: EdgeInsets.only(
                left: Dimensions.marginSizeHorizontal * .75,
                right: Dimensions.marginSizeHorizontal * .75),
            decoration: BoxDecoration(
              color: CustomColor.primaryLightColor.withOpacity(.1),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.paddingHorizontalSize * .75,
                    right: Dimensions.paddingHorizontalSize * 2.5,
                    top: Dimensions.paddingVerticalSize * .75,
                    bottom: Dimensions.paddingVerticalSize * .25,
                  ),
                  child: Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      const TitleHeading4Widget(
                        text: Strings.invoiceNumberText,
                        fontWeight: FontWeight.w600,
                        opacity: .6,
                      ),
                      TitleHeading4Widget(
                        text: data.invoice.invoiceNo,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.paddingHorizontalSize * .75,
                    right: Dimensions.paddingHorizontalSize * 2.5,
                    top: Dimensions.paddingVerticalSize * .25,
                    bottom: Dimensions.paddingVerticalSize * .75,
                  ),
                  child: Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      const TitleHeading4Widget(
                        text: Strings.dueDateText,
                        fontWeight: FontWeight.w600,
                        opacity: .6,
                      ),
                      TitleHeading4Widget(
                        text: DateFormat("MMMM dd, yyyy")
                            .format(data.invoice.createdAt),
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: isTablet()
              ? Dimensions.heightSize * 19
              : Dimensions.heightSize * 15,
          child: Column(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * .88,
                margin: EdgeInsets.only(
                  left: Dimensions.marginSizeHorizontal * .75,
                ),
                decoration: BoxDecoration(
                  color: CustomColor.primaryLightColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius),
                    topRight: Radius.circular(Dimensions.radius),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.paddingHorizontalSize * .5,
                    right: Dimensions.paddingHorizontalSize * .5,
                    top: Dimensions.paddingVerticalSize * .5,
                    bottom: Dimensions.paddingVerticalSize * .5,
                  ),
                  child: Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: const [
                      Expanded(
                        flex: 8,
                        child: TitleHeading4Widget(
                          text: Strings.descriptionText,
                          fontWeight: FontWeight.w600,
                          color: CustomColor.whiteColor,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TitleHeading4Widget(
                          text: Strings.qtyText,
                          fontWeight: FontWeight.w600,
                          color: CustomColor.whiteColor,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: TitleHeading4Widget(
                          text: Strings.unitPriceText,
                          fontWeight: FontWeight.w600,
                          color: CustomColor.whiteColor,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: TitleHeading4Widget(
                          text: Strings.amountText,
                          fontWeight: FontWeight.w600,
                          color: CustomColor.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * .88,
                margin: EdgeInsets.only(
                  left: Dimensions.marginSizeHorizontal * .75,
                ),
                decoration: BoxDecoration(
                  color: CustomColor.whiteColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimensions.radius),
                    bottomRight: Radius.circular(Dimensions.radius),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.paddingHorizontalSize * .5,
                    right: Dimensions.paddingHorizontalSize * .5,
                    top: Dimensions.paddingVerticalSize * .5,
                    bottom: Dimensions.paddingVerticalSize * .5,
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.invoice.invoiceItems.length,
                      itemBuilder: (context, index) {
                        bool isLastItem =
                            index == data.invoice.invoiceItems.length - 1;
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: mainSpaceBet,
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: TitleHeading5Widget(
                                    text:
                                        data.invoice.invoiceItems[index].title,
                                    fontWeight: FontWeight.w600,
                                    fontSize: Dimensions.headingTextSize6,
                                    opacity: .6,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TitleHeading5Widget(
                                    text: data.invoice.invoiceItems[index].qty
                                        .toString(),
                                    fontWeight: FontWeight.w600,
                                    textAlign: TextAlign.center,
                                    fontSize: Dimensions.headingTextSize6,
                                    opacity: .6,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: TitleHeading5Widget(
                                    text:
                                        '${double.parse(data.invoice.invoiceItems[index].price).toStringAsFixed(4)} ${data.invoice.currency} ',
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w600,
                                    fontSize: Dimensions.headingTextSize6,
                                    opacity: .6,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: TitleHeading5Widget(
                                    text:
                                        '${double.parse(data.invoice.invoiceItems[index].price).toInt() * data.invoice.invoiceItems[index].qty} ${data.invoice.currency} ',
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w600,
                                    fontSize: Dimensions.headingTextSize6,
                                    opacity: .6,
                                  ),
                                ),
                              ],
                            ),
                            if (!isLastItem) const CustomDivider()
                          ],
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _summaryWidget(BuildContext context) {
    var data = controller.invoiceStoreModel.data;

    return Padding(
        padding: EdgeInsets.only(
          top: Dimensions.paddingVerticalSize * .5,
          bottom: Dimensions.paddingVerticalSize * .5,
          left: Dimensions.paddingHorizontalSize * .75,
          right: Dimensions.paddingHorizontalSize * .75,
        ),
        child: TitleHeading5Widget(
          text:
              '${data.invoice.invoiceNo}  ${double.parse(data.invoice.amount).toStringAsFixed(2).toString()}${data.invoice.currency}, ${Strings.due} ${DateFormat("MMMM dd, yyyy").format(data.invoice.createdAt)}',
          fontSize: Dimensions.headingTextSize6,
          fontWeight: FontWeight.w600,
          opacity: .65,
          padding: EdgeInsets.only(
            left: Dimensions.paddingVerticalSize * .75,
          ),
        ));
  }

  _buttonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingHorizontalSize * .6,
          vertical: Dimensions.paddingVerticalSize * .5),
      child: Row(
        children: [
          Expanded(
            child: PrimaryButton(
                buttonColor: CustomColor.primaryLightScaffoldBackgroundColor,
                borderWidth: Dimensions.widthSize * .2,
                buttonTextColor: CustomColor.primaryLightColor,
                title: Strings.saveAsDraft,
                onPressed: () {
                  controller.getInvoiceProcess();
                  Get.offNamed(Routes.invoiceLogScreen);
                }),
          ),
          horizontalSpace(Dimensions.widthSize),
          Expanded(
            child: PrimaryButton(
                title: Strings.publishInvoice,
                onPressed: () {
                  controller.onPublishInvoice;
                }),
          ),
        ],
      ),
    );
  }
}