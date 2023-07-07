import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class WebViewApp extends StatefulWidget {
  final url;
  WebViewApp(this.url);

  @override
  State<WebViewApp> createState() => _WebViewAppState(this.url);
}

class _WebViewAppState extends State<WebViewApp> {
  final _url;

  _WebViewAppState(this._url);
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(_url),
      );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SafeArea(
        child: Scaffold(
          body: WebViewWidget(
            controller: controller,
          ),
        ),
      ),
    );
  }
}
