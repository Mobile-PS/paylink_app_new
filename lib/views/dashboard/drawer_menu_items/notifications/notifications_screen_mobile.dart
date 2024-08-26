import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import '/controller/drawer/notifications/notifications_controller.dart';

import '../../../../backend/utils/custom_loading_api.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/animation/custom_listview_animation.dart';
import '../../../../widgets/common/no_data_widget.dart';
import '../../../../widgets/others/notifications_widget.dart';

class NotificationsScreenMobile extends StatelessWidget {
  NotificationsScreenMobile({super.key});

  final controller = Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) async {
        Get.offAllNamed(Routes.dashboardScreen);
      },
      child: Scaffold(
        appBar: PrimaryAppBar(
          Strings.notifications,
          onTap: () {
            Get.offAllNamed(Routes.dashboardScreen);
          },
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
    var data = controller.notificationsModel.data.notifications;
    return data.isNotEmpty
        ? RefreshIndicator(
            color: CustomColor.primaryLightColor,
            onRefresh: () async {
              await controller.getNotificationsProcess();
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
                      itemBuilder: (context, index) {
                        return CustomListViewAnimation(
                          index: index,
                          child: NotificationsWidget(
                            title: data[index].message.title,
                            dateText: data[index].createdAt.day.toString(),
                            monthText: DateFormat("MMMM")
                                .format(data[index].createdAt),
                            message: data[index].message.message,
                          ).paddingSymmetric(
                            horizontal: Dimensions.paddingHorizontalSize * .6,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        : NoDataWidget(
            text: Strings.noNotificationsYet.tr,
          );
  }
}
