import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Politikalar extends StatefulWidget {
  final String url;

  const Politikalar({Key key, this.url}) : super(key: key);

  @override
  _PolitikalarState createState() => _PolitikalarState();
}

class _PolitikalarState extends State<Politikalar> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Politikalar'),
      ),
      body: WebView(
        initialUrl: "https://bizimkapici.com/${widget.url}.html",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
