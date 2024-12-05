import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DetailPage extends StatelessWidget {
  String link;
  DetailPage(this.link);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(link),
        ),
      ),
    );
  }
}
