import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  String url;
  WebViewScreen({super.key, required this.url});
  @override
  Widget build(BuildContext context) {
    final WebViewController webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: WebViewWidget(
        controller: webViewController
          ..loadRequest(
            Uri.parse(url),
          ),
      ),
    );
  }
}
