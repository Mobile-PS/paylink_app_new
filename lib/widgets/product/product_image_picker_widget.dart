import 'dart:io';

import 'package:flutter_svg/svg.dart';

import '../../custom_assets/assets.gen.dart';
import '/controller/product/product_controller.dart';

import '../../utils/basic_screen_imports.dart';

class ProductImagePicker extends StatelessWidget {
  final controller = Get.put(ProductController());
  final VoidCallback? onImagePick;
  final bool isImagePathSet;
  final bool isPicker;
  final String? imagePath;

  ProductImagePicker({
    super.key,
    this.onImagePick,
    this.isImagePathSet = false,
    this.imagePath,
    this.isPicker = true,
  });

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.33,
      decoration: BoxDecoration(
        color: CustomColor.blackColor.withOpacity(0.1),
        borderRadius: BorderRadius.all(
          Radius.circular(Dimensions.radius),
        ),
      ),
      child: InkWell(
        onTap: onImagePick,
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: !isPicker
              ? EdgeInsets.only(
                  left: 110.w,
                  top: 70.h,
                  bottom: 10.h,
                )
              : EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.03),
            border: Border.all(width: 5, color: CustomColor.whiteColor),
            borderRadius: BorderRadius.all(
              Radius.circular(Dimensions.radius),
            ),
            // shape: BoxShape.rectangle,
            image: isImagePathSet
                ? DecorationImage(
                    image: FileImage(File(imagePath!)),
                    fit: BoxFit.cover,
                  )
                : DecorationImage(
                    image: NetworkImage(controller.userImage.value),
                    fit: BoxFit.cover,
                  ),
          ),
          child: Visibility(
            visible: isPicker,
            child: Padding(
              padding: EdgeInsets.only(
                left: isTablet()
                    ? MediaQuery.sizeOf(context).width * .23
                    : MediaQuery.sizeOf(context).width * .33,
                top: 70.h,
                bottom: 10.h,
              ),
              child: InkWell(
                onTap: onImagePick,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.03),
                    border: Border.all(
                      width: 4,
                      color: CustomColor.whiteColor,
                    ),
                  ),
                  child: CircleAvatar(
                    foregroundColor: Colors.transparent,
                    radius: Dimensions.radius * 1.3,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: SvgPicture.asset(
                      Assets.icon.cameraIcon,
                      height: Dimensions.iconSizeDefault,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
