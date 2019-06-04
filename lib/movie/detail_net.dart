import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class DetailFromNet extends StatefulWidget {
  final String url;
  final String title;

  DetailFromNet({Key key, this.url, this.title}) : super(key: key);

  @override
  _DetailFromNetState createState() => _DetailFromNetState();
}

class _DetailFromNetState extends State<DetailFromNet> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();
  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.launch(widget.url);
  }
  @override
  void dispose() {
    super.dispose();
    flutterWebviewPlugin.close();
  }
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      initialChild: Container(
        child: Center(
          child: Text('Waiting...',style: TextStyle(color: Colors.red),),
        ),
      ),
    );
  }
}
