import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({super.key});

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(
        Uri.parse('https://www.srilankancargo.com/help-support/conditions'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Webview Container"),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}








/*import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyWebsite extends StatefulWidget {
  const MyWebsite({Key? key}) : super(key: key);

  @override
  State<MyWebsite> createState() => _MyWebsiteState();
}

class _MyWebsiteState extends State<MyWebsite> {
  double _progress = 0;
  late InAppWebViewController _inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _inAppWebViewController.canGoBack()) {
          _inAppWebViewController.goBack();
          return false; // Prevents the default back action
        }
        return true; // Allows the default back action if no more history
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Terms & Conditions'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _inAppWebViewController.reload();
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(
                    "https://www.srilankancargo.com/help-support/conditions"),
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                _inAppWebViewController = controller;
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  _progress = progress / 100;
                });
              },
              onLoadError: (InAppWebViewController controller, Uri? url,
                  int code, String message) {
                // Handle load error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error loading page: $message')),
                );
              },
              onLoadHttpError: (InAppWebViewController controller, Uri? url,
                  int statusCode, String description) {
                // Handle HTTP error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('HTTP error: $statusCode $description')),
                );
              },
            ),
            _progress < 1.0
                ? Center(
                    child: LinearProgressIndicator(value: _progress),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
*/
