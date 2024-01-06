import 'package:flutter/material.dart';
import 'package:pt_platform/data/core/utils/api_routes/api_routes.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse("${AppUrls.domain}app/terms-concdditions"),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text('Flutter WebView'),
          ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
