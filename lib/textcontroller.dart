import 'package:flutter/material.dart';

class MyTextController extends TextEditingController {
  @override
  TextSpan buildTextSpan(
      {BuildContext context, TextStyle style, bool withComposing}) {
    List<InlineSpan> children = [];
    if (text.contains('@')) {
      children.add(TextSpan(
          style: TextStyle(color: Colors.blue),
          text: text.substring(0, text.indexOf('@'))));
      children.add(TextSpan(text: text.substring(text.indexOf('@'))));
    } else {
      children.add(TextSpan(style: TextStyle(color: Colors.blue), text: text));
    }
    return TextSpan(style: style, children: children);
  }
}
