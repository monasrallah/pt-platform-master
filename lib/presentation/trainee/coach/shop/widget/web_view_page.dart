import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../app/app_controller.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key, required this.url});

  final String url;

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print("ghina0");
          },
          onPageStarted: (String url) {
            print("ghina1");
          },
          onPageFinished: (String url) {
            print("ghina2");
          },
          onWebResourceError: (WebResourceError error) {
            print("ghina3");
          },
          onUrlChange: (UrlChange url) {
            print("ghina4");
            if (url.url!.contains('success')) {
              Get.find<AppController>().onItemTapped(1);
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            print("ghina5");
            if (request.url.startsWith('')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.url),
      );
  }

  @override
  Widget build(BuildContext context) {
    print("test url ${widget.url}");
    getUrl();
    return Scaffold(
      appBar: AppBar(
          // title: Text(),
          ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }

  getUrl() async {
    // RxString ghina = "".obs;
    // ghina.value = await controller.currentUrl() ?? "";
    // print("ghina $ghina");

    controller.addJavaScriptChannel("name", onMessageReceived: (message) {
      print("ghina");
      print(message);
    });
  }
}
