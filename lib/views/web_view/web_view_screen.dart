// ignore_for_file: must_be_immutable
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../backend/utils/custom_loading_api.dart';
import '../../utils/basic_screen_imports.dart';

class WebViewScreen extends StatelessWidget {
  final String url, title;
  WebViewScreen({super.key, required this.url, required this.title});


  late InAppWebViewController webViewController;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title,
        backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
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
          onLoadStop: (controller, url) {
            isLoading.value = false;
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