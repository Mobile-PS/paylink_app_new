import 'dart:ui';

import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../../controller/dashboard/update_profile_controller/update_profile_controller.dart';
import '../../backend/utils/custom_loading_api.dart';
import '../../controller/basic_settings/basic_settings_controller.dart';
import '../../controller/drawer/log_out_controller/log_out_controller.dart';
import '../../routes/routes.dart';
import '../../utils/basic_widget_imports.dart';
import '../common/custom_container.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  final logOutController = Get.put(LogOutController());
  final profileController = Get.put(UpdateProfileController());
  final basicSettingsController = Get.put(BasicSettingsController());

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Drawer(
      elevation: 3,
      width: isTablet()
          ? MediaQuery.of(context).size.width * .6
          : MediaQuery.of(context).size.width * .7,
      child: Container(
        decoration: BoxDecoration(
          color: Get.isDarkMode
              ? CustomColor.blackColor
              : CustomColor.primaryLightColor,
        ),
        child: ListView(
          children: [
            verticalSpace(Dimensions.heightSize * 3),
            _userInfoWidget(context),
            _drawerItems(context),
          ],
        ),
      ),
    );
  }

  _userInfoWidget(BuildContext context) {
    return Column(
      children: [
        Animate(
          effects: const [
            FadeEffect(),
            ScaleEffect(),
          ],
          child: Container(
            width: MediaQuery.of(context).size.width * 0.40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: CustomColor.whiteColor.withOpacity(0.05), width: 7),
            ),
            child: Center(
              child: CircleAvatar(
                radius: Dimensions.radius * 7,
                backgroundColor: CustomColor.whiteColor.withOpacity(0.30),
                child: CircleAvatar(
                  backgroundColor: CustomColor.transparentColor,
                  radius: Dimensions.radius * 6,
                  child: CircleAvatar(
                    radius: Dimensions.radius * 5.8,
                    backgroundColor: CustomColor.transparentColor,
                    backgroundImage: NetworkImage(
                      profileController.userImage.value,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ).paddingOnly(
          bottom: Dimensions.paddingVerticalSize * .4,
        ),
        TitleHeading1Widget(
          text: profileController.userFullName.value,
          color: CustomColor.whiteColor,
          textAlign: TextAlign.center,
        )
            .paddingOnly(
              bottom: Dimensions.paddingVerticalSize * .1,
            )
            .animate()
            .fadeIn(duration: 900.ms, delay: 300.ms)
            .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad),
        TitleHeading4Widget(
          text: profileController.userEmailAddress.value,
          color: CustomColor.whiteColor,
          opacity: 0.5,
        )
            .paddingOnly(
              bottom: Dimensions.paddingVerticalSize,
            )
            .animate()
            .fadeIn(duration: 900.ms, delay: 300.ms)
            .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad),
      ],
    ).paddingSymmetric(horizontal: Dimensions.paddingHorizontalSize * .5);
  }

  buildMenuItem(
    BuildContext context, {
    required String title,
    required IconData iconPath,
    required VoidCallback onTap,
    double scaleImage = 1,
  }) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingHorizontalSize * .25,
            vertical: Dimensions.paddingHorizontalSize * .1,
          ),
          child: ListTile(
            dense: true,
            leading: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet()
                      ? Dimensions.paddingHorizontalSize * .25
                      : Dimensions.paddingHorizontalSize * .25,
                  vertical: isTablet()
                      ? Dimensions.paddingVerticalSize * .3
                      : Dimensions.paddingVerticalSize * .2,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Dimensions.radius * .75,
                  ),
                  color: CustomColor.whiteColor.withOpacity(.15),
                ),
                child: Icon(
                  iconPath,
                  color: CustomColor.whiteColor,
                )),
            title: TitleHeading4Widget(
              padding: EdgeInsets.zero,
              text: title,
              color: CustomColor.whiteColor,
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.headingTextSize3,
            ),
            onTap: onTap,
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 900.ms, delay: 300.ms)
        .shimmer(blendMode: BlendMode.srcOver, color: Colors.white12)
        .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad);
  }

  _drawerItems(BuildContext context) {
    return Column(
      children: AnimateList(
        children: [
          buildMenuItem(
            context,
            iconPath: Icons.notifications_active_outlined,
            title: Strings.notifications.tr,
            onTap: () {
              Get.toNamed(Routes.notificationsScreen);
            },
          ),
          buildMenuItem(
            context,
            iconPath: Icons.shopping_cart,
            title: Strings.products.tr,
            onTap: () {
              Get.toNamed(Routes.productListScreen);
            },
          ),
          buildMenuItem(
            context,
            iconPath: Icons.wallet,
            title: Strings.moneyOut.tr,
            onTap: () {
              Get.toNamed(Routes.moneyOutScreen);
            },
          ),
          buildMenuItem(
            context,
            iconPath: Icons.security_outlined,
            title: Strings.twoFASecurity.tr,
            onTap: () {
              Get.toNamed(Routes.twoFaSecurityScreen);
            },
          ),
          buildMenuItem(
            context,
            iconPath: Icons.co_present_outlined,
            title: Strings.kycVerification.tr,
            onTap: () {
              Get.toNamed(Routes.kycVerificationScreen);
            },
          ),
          buildMenuItem(
            context,
            iconPath: Icons.key_rounded,
            title: Strings.changePassword.tr,
            onTap: () {
              Get.toNamed(Routes.changePasswordScreen);
            },
          ),
          buildMenuItem(
            context,
            iconPath: Icons.question_mark_rounded,
            title: Strings.helpCenter.tr,
            onTap: () {
              Get.toNamed(Routes.flutterWebScreen, arguments: {
                'url': basicSettingsController
                    .appSettingsModel.data.webLinks.contactUs,
                'title': Strings.helpCenter
              });
            },
          ),
          /*buildMenuItem(
            context,
            iconPath: Icons.info_outline_rounded,
            title: Strings.aboutUs.tr,
            onTap: () {
              Get.toNamed(Routes.flutterWebScreen, arguments: {
                'url': basicSettingsController
                    .appSettingsModel.data.webLinks.aboutUs,
                'title': Strings.aboutUs
              });
            },
          ),*/
          buildMenuItem(
            context,
            iconPath: Icons.privacy_tip_outlined,
            title: Strings.privacyAndPolicy.tr,
            onTap: () {
              Get.toNamed(Routes.flutterWebScreen, arguments: {
                'url': basicSettingsController
                    .appSettingsModel.data.webLinks.privacyPolicy,
                'title': Strings.privacyAndPolicy
              });
            },
          ),
          buildMenuItem(
            context,
            iconPath: Icons.power_settings_new_outlined,
            title: Strings.logOut.tr,
            onTap: () {
              _showSignOutDialog(context);
            },
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: Dimensions.paddingHorizontalSize * .5);
  }

  _showSignOutDialog(BuildContext context) {
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
            backgroundColor: Get.isDarkMode
                ? CustomColor.primaryDarkScaffoldBackgroundColor
                : CustomColor.primaryLightScaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingHorizontalSize,
                  vertical: Dimensions.paddingVerticalSize),
              child: Column(
                crossAxisAlignment: crossStart,
                mainAxisSize: mainMin,
                children: [
                  const TitleHeading1Widget(
                    text: Strings.areYouSure,
                    textAlign: TextAlign.start,
                  ),
                  verticalSpace(Dimensions.heightSize),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: CustomContainer(
                            height: Dimensions.buttonHeight * 0.7,
                            borderRadius: Dimensions.radius * 0.8,
                            color: Get.isDarkMode
                                ? CustomColor.primaryBGLightColor
                                    .withOpacity(0.15)
                                : CustomColor.primaryBGDarkColor
                                    .withOpacity(0.15),
                            child: const TitleHeading4Widget(
                              text: Strings.cancel,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      horizontalSpace(Dimensions.widthSize),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            logOutController.signOutProcess();
                          },
                          child: Obx(
                            () => logOutController.isLoading
                                ? const CustomLoadingAPI()
                                : CustomContainer(
                                    height: Dimensions.buttonHeight * 0.7,
                                    borderRadius: Dimensions.radius * 0.8,
                                    color: Theme.of(context).primaryColor,
                                    child: const TitleHeading4Widget(
                                      text: Strings.logOut,
                                      color: CustomColor.whiteColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ).paddingSymmetric(
                      horizontal: Dimensions.paddingHorizontalSize * 0.5,
                      vertical: Dimensions.paddingVerticalSize * 0.5),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}