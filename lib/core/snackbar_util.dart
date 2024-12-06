import 'package:flutter/material.dart';

class SnackbarUtil {
  static showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
        action: SnackBarAction(
          label: '닫기',
          onPressed: () {},
        ),
      ),
    );
  }
}
