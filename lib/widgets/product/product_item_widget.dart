import 'package:iconsax/iconsax.dart';

import '../../../../../widgets/inputs/custom_divider.dart';
import '../../utils/basic_screen_imports.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.status,
    required this.title,
    required this.amount,
    required this.onEditInvoice,
    required this.onDeleteInvoice,
    required this.image,
    required this.desc,
    this.onStatusUpdate,
    this.onLinkList,
  });

  final String status, title, amount, image, desc;

  final VoidCallback? onEditInvoice;
  final VoidCallback? onDeleteInvoice;

  final VoidCallback? onStatusUpdate;
  final VoidCallback? onLinkList;

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Padding(
      padding: EdgeInsets.only(
          bottom: Dimensions.paddingVerticalSize * 0.08,
          left: Dimensions.paddingHorizontalSize * 0.5,
          right: Dimensions.paddingHorizontalSize * 0.5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
          color: CustomColor.whiteColor,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.075,
                margin: EdgeInsets.only(
                  left: Dimensions.marginSizeHorizontal * 0.4,
                  top: Dimensions.marginSizeVertical * 0.4,
                  bottom: Dimensions.marginSizeVertical * 0.4,
                  right: Dimensions.marginSizeHorizontal * 0.2,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: isTablet()
                      ? Dimensions.paddingVerticalSize * 0.5
                      : Dimensions.paddingVerticalSize * 0.2,
                  horizontal: Dimensions.paddingHorizontalSize * 0.2,
                ),
                decoration: BoxDecoration(
                    color: CustomColor.primaryLightScaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius),
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.cover)),
                alignment: Alignment.center,
              ),
            ),
            horizontalSpace(Dimensions.widthSize),
            Expanded(
              flex: 13,
              child: Column(
                crossAxisAlignment: crossStart,
                mainAxisAlignment: mainCenter,
                children: [
                  Column(
                    crossAxisAlignment: crossStart,
                    children: [
                      TitleHeading5Widget(
                        text: title,
                        fontWeight: FontWeight.w600,
                        fontSize: Dimensions.headingTextSize4,
                        color: CustomColor.blackColor,
                        maxLines: 3,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                      Visibility(
                        visible: desc.isEmpty ? false : true,
                        child: Column(
                          children: [
                            verticalSpace(Dimensions.heightSize * 0.25),
                            TitleHeading5Widget(
                              text: desc,
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w400,
                              fontSize: Dimensions.headingTextSize4,
                              color: CustomColor.blackColor,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  verticalSpace(Dimensions.widthSize * 0.4),
                  Row(
                    children: [
                      TitleHeading5Widget(
                        padding: EdgeInsets.only(
                          right: Dimensions.paddingHorizontalSize * .05,
                        ),
                        maxLines: 1,
                        text: amount,
                        fontSize: Dimensions.headingTextSize6,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.primaryLightColor,
                      ),
                      // statusInfo(),
                      horizontalSpace(Dimensions.widthSize * 0.5),
                      _statusWidget(context),
                      horizontalSpace(Dimensions.widthSize * 0.5),
                      GestureDetector(
                        onTap: onLinkList,
                        child: Icon(
                          Icons.insert_link_rounded,
                          size: isTablet()
                              ? Dimensions.heightSize * 2.5
                              : Dimensions.heightSize * 1.5,
                          color: CustomColor.primaryLightTextColor
                              .withOpacity(.20),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: PopupMenuButton(
                elevation: Dimensions.widthSize * 2,
                color: CustomColor.whiteColor,
                surfaceTintColor: CustomColor.whiteColor,
                icon: Icon(
                  Icons.more_vert_outlined,
                  size: isTablet()
                      ? Dimensions.heightSize * 2.5
                      : Dimensions.heightSize * 1.5,
                  color: CustomColor.primaryLightTextColor.withOpacity(.20),
                ),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    padding: EdgeInsets.only(
                        right: Dimensions.paddingHorizontalSize * .20),
                    child: Column(
                      mainAxisAlignment: mainCenter,
                      children: [
                        Visibility(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: onEditInvoice,
                                child: Row(
                                  mainAxisAlignment: mainCenter,
                                  children: [
                                    Icon(
                                      Iconsax.edit_2,
                                      color: CustomColor.primaryLightTextColor
                                          .withOpacity(.5),
                                    ),
                                    horizontalSpace(Dimensions.widthSize * .5),
                                    TitleHeading5Widget(
                                      text: Strings.edit.tr,
                                      fontWeight: FontWeight.w500,
                                      color: CustomColor.primaryLightTextColor,
                                      opacity: .5,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          child: Column(
                            children: [
                              const CustomDivider(),
                              InkWell(
                                onTap: onDeleteInvoice,
                                child: Row(
                                  mainAxisAlignment: mainCenter,
                                  children: [
                                    Icon(
                                      Icons.delete_outline_outlined,
                                      color: CustomColor.primaryLightTextColor
                                          .withOpacity(.5),
                                    ),
                                    horizontalSpace(Dimensions.widthSize * .5),
                                    TitleHeading5Widget(
                                      text: Strings.delete.tr,
                                      fontWeight: FontWeight.w500,
                                      color: CustomColor.primaryLightTextColor,
                                      opacity: .5,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _statusWidget(BuildContext context) {
    return Card(
      elevation: 2,
      child: GestureDetector(
        onTap: onStatusUpdate,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.widthSize,
                vertical: Dimensions.heightSize * 0.25,
              ),
              decoration: BoxDecoration(
                color: status == "Active"
                    ? CustomColor.primaryLightColor
                    : CustomColor.whiteColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.radius * 0.5),
                  topLeft: Radius.circular(Dimensions.radius * 0.5),
                ),
              ),
              child: TitleHeading5Widget(
                text: "Active",
                color: status == "Active"
                    ? CustomColor.whiteColor
                    : CustomColor.blackColor,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.widthSize,
                vertical: Dimensions.heightSize * 0.25,
              ),
              decoration: BoxDecoration(
                color: status == "Inactive"
                    ? CustomColor.primaryLightColor
                    : CustomColor.whiteColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(Dimensions.radius * 0.5),
                  topRight: Radius.circular(Dimensions.radius * 0.5),
                ),
              ),
              child: TitleHeading5Widget(
                text: "Inactive",
                color: status == "Inactive"
                    ? CustomColor.whiteColor
                    : CustomColor.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
