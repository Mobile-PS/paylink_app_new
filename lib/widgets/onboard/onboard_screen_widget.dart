import 'package:paylink/backend/local_storage/local_storage.dart';

import '../../controller/onboard_controller/onboard_screen_controller.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';

class OnboardScreenWidget extends StatelessWidget {
  OnboardScreenWidget({
    super.key,
  });

  final buttonBackGroundColor = Get.isDarkMode
      ? Colors.transparent
      : CustomColor.primaryLightColor.withOpacity(0.05);
  final OnboardScreenController controller = Get.put(OnboardScreenController());

  @override
  Widget build(BuildContext context) {
    return _bodyWidget(context);
  }

  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.paddingHorizontalSize,
        right: Dimensions.paddingHorizontalSize,
      ),
      child: Column(
        mainAxisAlignment: mainCenter,
        children: [
          verticalSpace(Dimensions.heightSize * 3.33),
          _signInButtonWidget(context),
          verticalSpace(Dimensions.paddingHorizontalSize * 0.5),
          _signUpButtonWidget(context),
        ],
      ),
    );
  }

  _signInButtonWidget(BuildContext context) {
    return PrimaryButton(
      title: Strings.logIn.tr,
      fontWeight: FontWeight.w600,
      fontSize: Dimensions.headingTextSize2 * 0.9,
      onPressed: () {
        LocalStorage.saveOnboardDoneOrNot(isOnBoardDone: true);
        Get.offNamed(Routes.signInScreen);
      },
      borderColor: CustomColor.primaryLightColor,
      buttonColor: CustomColor.primaryLightColor,
      buttonTextColor: CustomColor.whiteColor,
    );
  }

  _signUpButtonWidget(BuildContext context) {
    return PrimaryButton(
      title: Strings.registration.tr,
      fontWeight: FontWeight.w600,
      fontSize: Dimensions.headingTextSize2 * 0.9,
      onPressed: () {
        LocalStorage.saveOnboardDoneOrNot(isOnBoardDone: true);
        Get.offNamed(Routes.signUpScreen);
      },
      borderWidth: Dimensions.heightSize * .1,
      borderColor: CustomColor.primaryLightColor,
      buttonColor: CustomColor.primaryLightScaffoldBackgroundColor,
      buttonTextColor: CustomColor.primaryLightColor,
    );
  }
}