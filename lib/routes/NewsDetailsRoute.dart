import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsRoute extends StatefulWidget {
  WebViewController _controller;
  NewsDetailsRoute({
    @required this.url,
    @required this.title
  });
  final String url;
  final String title;
  @override
  _NewsDetailsRouteState createState() => _NewsDetailsRouteState();
}

class _NewsDetailsRouteState extends State<NewsDetailsRoute> {
  WebViewController _controller;



  @override
  void initState() {


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller){
          _controller = controller;
        },


      ),
    );
  }
}

