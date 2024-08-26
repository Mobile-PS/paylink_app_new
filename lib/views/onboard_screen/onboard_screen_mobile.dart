import 'package:paylink/backend/utils/custom_loading_api.dart';

import '../../backend/services/api_endpoint.dart';
import '../../controller/basic_settings/basic_settings_controller.dart';
import '../../controller/onboard_controller/onboard_screen_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/onboard/onboard_screen_widget.dart';

class OnboardScreenMobile extends StatelessWidget {
  OnboardScreenMobile({super.key});

  final controller = Get.put(OnboardScreenController());
  final basicSettingsController = Get.put(BasicSettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => basicSettingsController.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

  // image change, animated container, onboard widget(text, three buttons, sign up)
  _bodyWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _imageWidget(context),
          Column(
            children: [
              _animatedDotWidget(context),
              OnboardScreenWidget(),
            ],
          )
        ],
      ),
    );
  }

//onboard image
  _imageWidget(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .90,
      child: PageView.builder(
        controller: controller.pageController,
        onPageChanged: controller.selectedPageIndex.call,
        itemCount:
            basicSettingsController.appSettingsModel.data.onboardScreen.length,
        itemBuilder: (context, index) {
          var data = basicSettingsController
              .appSettingsModel.data.onboardScreen[index];
          return Image.network(
            "${ApiEndpoint.mainDomain}/${basicSettingsController.appSettingsModel.data.imagePath}/${data.image}",
            width: MediaQuery.of(context).size.width * 0.62,
            height: MediaQuery.of(context).size.height * 0.27,
          );
        },
      ),
    );
  }

//changing dot
  _animatedDotWidget(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              basicSettingsController
                  .appSettingsModel.data.onboardScreen.length,
              (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(right: Dimensions.widthSize),
                  height: Dimensions.heightSize * 0.4,
                  width: index == controller.selectedPageIndex.value
                      ? Dimensions.widthSize * 3
                      : Dimensions.widthSize * 2,
                  decoration: BoxDecoration(
                    color: index == controller.selectedPageIndex.value
                        ? CustomColor.primaryLightColor
                        : CustomColor.primaryLightColor.withOpacity(0.20),
                    border: Border.all(
                      width: 2,
                      color: index == controller.selectedPageIndex.value
                          ? CustomColor.primaryLightColor
                          : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.radius * 5),
                    ),
                  ),
                );
              },
            ),
          ),
          verticalSpace(Dimensions.heightSize * 2),
          TitleHeading2Widget(
            text: basicSettingsController.appSettingsModel.data
                .onboardScreen[controller.selectedPageIndex.value].title,
            color: CustomColor.primaryLightTextColor,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Dimensions.paddingHorizontalSize,
              right: Dimensions.paddingHorizontalSize,
            ),
            child: TitleHeading4Widget(
              text: basicSettingsController.appSettingsModel.data
                  .onboardScreen[controller.selectedPageIndex.value].subTitle,
              textAlign: TextAlign.center,
              fontSize: Dimensions.headingTextSize3,
              color: CustomColor.primaryLightTextColor.withOpacity(.60),
            ),
          ),
        ],
      ),
    );
  }
}
