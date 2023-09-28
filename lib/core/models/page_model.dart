import 'package:booking/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class PageModel {
  final String name;
  final IconData icon;
  final Widget mainWidget;
  final Widget? shimmerWidget;
  PageModel({
    required this.icon,
    required this.name,
    required this.mainWidget,
    this.shimmerWidget = const LoadingIndicator(),
  });
}
