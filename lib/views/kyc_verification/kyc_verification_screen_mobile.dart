import '../../backend/utils/custom_loading_api.dart';
import '../../controller/kyc_verification_controller/kyc_verification_controller.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/common/kyc_status_widget.dart';

class KycVerificationScreenMobile extends StatelessWidget {
  KycVerificationScreenMobile({super.key});

  final controller = Get.put(KycVerificationController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return  PopScope(
      onPopInvoked: (value) async {
        Get.offAllNamed(Routes.dashboardScreen);

      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PrimaryAppBar(
          Strings.kycVerification.tr,
          onTap: () {
            Get.offAllNamed(Routes.dashboardScreen);
          },
          appbarSize: isTablet()
              ? Dimensions.heightSize * 1.8
              : Dimensions.heightSize * 2.5,
        ),
        body: Obx(
          () => controller.isLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    var data = controller.kycInfoModel.data.kycStatus;
    return data == 2
        ? const StatusDataWidget(
            text: Strings.pending,
            icon: Icons.hourglass_empty,
          )
        : data == 1
            ? const StatusDataWidget(
                text: Strings.verified,
                icon: Icons.check_circle_outline,
              )
            : Container(
                margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingHorizontalSize * 0.8,
                  vertical: Dimensions.paddingVerticalSize * 0.6,
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    verticalSpace(
                      Dimensions.heightSize * 0.5,
                    ),
                    Obx(() {
                      return Form(
                        key: formKey,
                        child: Column(
                          children: [
                            ...controller.inputFields.map((element) {
                              return element;
                            })

                          ],
                        ),
                      );
                    }),
                    verticalSpace(
                      Dimensions.heightSize * 2,
                    ),
                    Visibility(
                      visible: controller.inputFileFields.isNotEmpty,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.21,
                        child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  2, // Number of columns in the grid
                              crossAxisSpacing: 10.0, // Spacing between columns
                              mainAxisSpacing: 10.0, // Spacing between rows
                            ),
                            itemCount: controller.inputFileFields.length,
                            // Number of items in the grid
                            itemBuilder: (BuildContext context, int index) {
                              return controller.inputFileFields[index];
                            }),
                      ),
                    ),

                    _buttonWidget(context),
                  ],
                ),
              );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.marginSizeVertical * 2,
      ),
      child: Obx(
        () => controller.isSubmitLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.submit,
                onPressed: (() {
                  if (formKey.currentState!.validate()) {
                    controller.kycSubmitApiProcess();
                  }
                }),
              ),
      ),
    );
  }
}