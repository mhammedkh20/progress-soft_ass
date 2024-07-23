import 'package:flutter/material.dart';

class PageWidget {
  final String title;
  final Widget widget;
  final IconData icon;
  const PageWidget(
      {required this.title, required this.widget, required this.icon});
}
