import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  String link;
  DetailPage(this.link);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('DetailPage'),
    );
  }
}
