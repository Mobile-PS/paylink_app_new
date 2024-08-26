// ignore_for_file: must_be_immutable
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../backend/utils/custom_loading_api.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';

class FlutterWebScreen extends StatelessWidget {
  FlutterWebScreen({super.key,});
  Map<String, dynamic> arguments  = Get.arguments;




  late InAppWebViewController webViewController;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {


    String title = arguments['title'];
    return PopScope(
      onPopInvoked: (value) async {
        Get.offAllNamed(Routes.dashboardScreen);

      },
      child: Scaffold(
        appBar:  PrimaryAppBar(title),
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {

    String url = arguments['url'];
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(url)),
          onWebViewCreated: (controller) {
            webViewController = controller;
            controller.addJavaScriptHandler(
              handlerName: 'jsHandler',
              callback: (args) {
                // Handle JavaScript messages from WebView
              },
            );
          },
          onLoadStart: (controller, url) {
            isLoading.value = true;
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: isLoading,
          builder: (context, isLoading, _) {
            return isLoading
                ? const Center(child: CustomLoadingAPI())
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}