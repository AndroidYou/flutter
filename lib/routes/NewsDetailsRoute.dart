import 'package:flutter/material.dart';
import 'package:flutter_github/states/profile_change_notifier.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';
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
 FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
 var lineProgress = 0.0;



  @override
  void initState() {
    flutterWebviewPlugin.onProgressChanged.listen((event) {
      setState(() {
        lineProgress = event;
      });
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var isCompleted = false;
    return WebviewScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        bottom: PreferredSize(
          child: _progressBar(lineProgress, context),
          preferredSize: Size.fromHeight(2),
        ),
        
      ),
      url:widget.url);



  }
  Widget _progressBar(double progress,BuildContext context){
    return LinearProgressIndicator(
      backgroundColor: Colors.white70.withOpacity(0),
      value: progress==1.0?0:progress,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
    );
  }
  @override
  void dispose() {
   flutterWebviewPlugin.dispose();
    super.dispose();
  }
}

