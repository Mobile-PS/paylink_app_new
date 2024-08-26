import 'dart:ui';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

import 'package:paylink/widgets/animation/custom_listview_animation.dart';
import 'package:paylink/widgets/common/no_data_widget.dart';
import 'package:paylink/widgets/dashboard/invoice_log_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../backend/services/api_endpoint.dart';
import '../../../../backend/utils/custom_loading_api.dart';
import '../../../../controller/dashboard/invoice/invoice_controller.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';

class InvoiceLogScreenMobile extends StatelessWidget {
  InvoiceLogScreenMobile({super.key});

  final controller = Get.put(InvoiceController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) async {
        Get.offAllNamed(Routes.dashboardScreen);
      },
      child: Scaffold(
        appBar: PrimaryAppBar(
          Strings.invoiceLog,
          onTap: () {
            Get.offAllNamed(Routes.dashboardScreen);
          },
        ),
        floatingActionButton: Obx(() {
          return Visibility(
            visible: !controller.isLoading,
            child: FloatingActionButton(
              elevation: 3,
              backgroundColor: CustomColor.primaryLightColor,
              shape: const CircleBorder(),
              onPressed: () {
                controller.onCreateInvoice;
              },
              child: Icon(
                Icons.add,
                size: Dimensions.iconSizeLarge,
                color: Colors.white,
              ),
            ),
          );
        }),
        body: Obx(
          () => controller.isLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    var data = controller.invoiceModel.data.invoices;
    return data.isNotEmpty
        ? RefreshIndicator(
            color: CustomColor.primaryLightColor,
            onRefresh: () async {
              controller.getInvoiceProcess();
            },
            child: Column(
              children: [
                AnimationLimiter(
                  child: Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomListViewAnimation(
                          index: index,
                          child: InvoiceLogWidget(
                            dateText: data[index].createdAt.day.toString(),
                            status: data[index].status == 1
                                ? 'Paid'
                                : data[index].status == 2
                                    ? 'Unpaid'
                                    : "Draft",
                            monthText: DateFormat("MMMM")
                                .format(data[index].createdAt),
                            title: data[index].title,
                            amount: double.parse(data[index].amount)
                                .toStringAsFixed(2)
                                .toString(),
                            onCopyInvoice: () {
                              controller.copyInvoiceLinkController.text =
                                  "${ApiEndpoint.mainDomain}/invoice/share/${data[index].token}";
                              Get.close(1);
                              controller.onCopyInvoice;
                            },
                            onShowInvoice: () {
                              controller.selectedInvoiceLinkId.value =
                                  data[index].id;
                              controller.copyInvoiceLinkController.text =
                                  "${ApiEndpoint.mainDomain}/invoice/share/${data[index].token}";
                              controller.getInvoiceLinkEditProcess();
                              Get.close(1);
                              _showInvoiceDialog(context);
                            },
                            onDownload: () {
                              Get.close(1);
                              controller.selectedInvoiceLinkId.value =
                                  data[index].id;
                              controller.onDownloadInvoice();
                            },
                            onEditInvoice: () {
                              Get.close(1);
                              controller.selectedInvoiceLinkId.value =
                                  data[index].id;
                              controller.getInvoiceLinkEditProcess();
                              Get.toNamed(Routes.invoiceScreen);
                            },
                            onDeleteInvoice: () {
                              Get.close(1);
                              controller.deleteInvoiceProcess(
                                  id: data[index].id);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        : const NoDataWidget(
            text: Strings.noInvoiceCreatedYet,
          );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  _showInvoiceDialog(BuildContext context) {
    var data = controller.invoiceLinkEditModel.data.invoice;
    var subtotal = 0.0;

    for (int i = 0; i < data.invoiceItems.length; i++) {
      subtotal = subtotal + double.parse(data.invoiceItems[i].price);
    }
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Get.isDarkMode
                ? CustomColor.primaryDarkScaffoldBackgroundColor
                : CustomColor.primaryLightScaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingHorizontalSize,
                  vertical: Dimensions.paddingVerticalSize * 0.2),
              child: Column(
                crossAxisAlignment: crossStart,
                mainAxisSize: mainMin,
                children: [
                  Row(
                    mainAxisAlignment: mainEnd,
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.close(1);
                          },
                          icon: const Icon(Icons.close)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      const TitleHeading1Widget(text: Strings.invoice),
                      TitleHeading1Widget(
                        text: data.title,
                        fontWeight: FontWeight.w400,
                        color: CustomColor.blackColor.withOpacity(0.75),
                      ),
                    ],
                  ),
                  verticalSpace(Dimensions.heightSize),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: CustomColor.blackColor,
                      width: 0.5,
                    )),
                  ),
                  verticalSpace(Dimensions.heightSize),
                  Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      const TitleHeading3Widget(
                          text: "${Strings.invoiceNumberText}:"),
                      TitleHeading2Widget(text: data.invoiceNo),
                    ],
                  ),
                  verticalSpace(Dimensions.heightSize * 0.5),
                  const TitleHeading3Widget(text: Strings.dateDue),
                  verticalSpace(Dimensions.heightSize),
                  Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      Column(
                        crossAxisAlignment: crossStart,
                        children: [
                          TitleHeading3Widget(
                            text: data.title,
                            fontWeight: FontWeight.w700,
                          ),
                          verticalSpace(Dimensions.heightSize * 0.5),
                          TitleHeading3Widget(text: data.phone),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: crossStart,
                        children: [
                          const TitleHeading3Widget(
                            text: Strings.billToText,
                            fontWeight: FontWeight.w700,
                          ),
                          verticalSpace(Dimensions.heightSize * 0.5),
                          TitleHeading3Widget(text: data.name),
                          TitleHeading3Widget(text: data.email),
                        ],
                      ),
                    ],
                  ),
                  verticalSpace(Dimensions.heightSize),
                  TitleHeading2Widget(
                      text:
                          "${data.currencySymbol} ${double.parse(data.amount).toStringAsFixed(2)} due to ${DateFormat('d MMMM yyyy').format(DateTime.parse(data.createdAt.toString()))}"),
                  verticalSpace(Dimensions.heightSize),
                  verticalSpace(Dimensions.heightSize),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: CustomColor.blackColor, width: 0.5)),
                  ),
                  verticalSpace(Dimensions.heightSize),
                  _productItemList(context),
                  verticalSpace(Dimensions.heightSize * 2),
                  Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      const TitleHeading3Widget(text: Strings.quantity),
                      TitleHeading3Widget(text: data.qty.toString()),
                    ],
                  ),
                  verticalSpace(Dimensions.heightSize * 0.5),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: CustomColor.blackColor, width: 0.5)),
                  ),
                  verticalSpace(Dimensions.heightSize),
                  Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      const TitleHeading3Widget(text: Strings.subTotal),
                      TitleHeading3Widget(
                          text:
                              "${data.currencySymbol} ${subtotal.toStringAsFixed(2)}"),
                    ],
                  ),
                  verticalSpace(Dimensions.heightSize * 0.5),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: CustomColor.blackColor, width: 0.5)),
                  ),
                  verticalSpace(Dimensions.heightSize),
                  Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      const TitleHeading3Widget(
                        text: Strings.amountDue,
                        fontWeight: FontWeight.w700,
                      ),
                      TitleHeading3Widget(
                          text:
                              "${data.currencySymbol} ${double.parse(data.amount).toStringAsFixed(2)}"),
                    ],
                  ),
                  verticalSpace(Dimensions.heightSize * 0.5),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: CustomColor.blackColor, width: 0.5)),
                  ),
                  verticalSpace(Dimensions.heightSize),
                  Row(
                    mainAxisAlignment: mainEnd,
                    children: [
                      InkWell(
                        onTap: () {
                          if (data.status == 2) {
                            _launchUrl(
                                controller.copyInvoiceLinkController.text);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: CustomColor.primaryLightColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.radius * 0.5))),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.widthSize,
                            vertical: Dimensions.heightSize,
                          ),
                          child: TitleHeading3Widget(
                            text: data.status == 1
                                ? "Paid"
                                : data.status == 2
                                    ? "Payment Now"
                                    : "Draft",
                            color: CustomColor.whiteColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  verticalSpace(Dimensions.heightSize),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: CustomColor.blackColor.withOpacity(0.4),
                            width: 0.2)),
                  ),
                  verticalSpace(Dimensions.heightSize),
                  SizedBox(
                    child: Row(
                      children: [
                        TitleHeading4Widget(
                          text: "${data.invoiceNo} - ",
                          fontWeight: FontWeight.w700,
                        ),
                        TitleHeading4Widget(
                          text:
                              "${data.currencySymbol} ${double.parse(data.amount).toStringAsFixed(2)} ${DateFormat('d MMMM yyyy').format(DateTime.parse(data.createdAt.toString()))}",
                          fontWeight: FontWeight.w700,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _productItemList(BuildContext context) {
    var data = controller.invoiceLinkEditModel.data.invoice.invoiceItems;
    var currency = controller.invoiceLinkEditModel.data.invoice.currencySymbol;
    return ListView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: mainSpaceBet,
                children: [
                  const TitleHeading3Widget(
                    text: Strings.title,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    child: TitleHeading3Widget(
                      text: data[index].title,
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              verticalSpace(Dimensions.heightSize),
              Row(
                mainAxisAlignment: mainSpaceBet,
                children: [
                  const TitleHeading3Widget(
                      text: Strings.qty, fontWeight: FontWeight.w700),
                  TitleHeading3Widget(text: data[index].qty.toString()),
                ],
              ),
              verticalSpace(Dimensions.heightSize),
              Row(
                mainAxisAlignment: mainSpaceBet,
                children: [
                  const TitleHeading3Widget(
                      text: Strings.unitPriceText, fontWeight: FontWeight.w700),
                  TitleHeading3Widget(
                      text:
                          "$currency ${double.parse(data[index].price).toStringAsFixed(2)}"),
                ],
              ),
              verticalSpace(Dimensions.heightSize),
              Row(
                mainAxisAlignment: mainSpaceBet,
                children: [
                  const TitleHeading3Widget(
                      text: Strings.amountText, fontWeight: FontWeight.w700),
                  TitleHeading3Widget(
                      text:
                          "$currency ${double.parse(data[index].price).toStringAsFixed(2)}"),
                ],
              ),
            ],
          );
        });
  }
}
