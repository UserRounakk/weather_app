import 'package:flutter/material.dart';

class Dimensions {
  static height(BuildContext context) => MediaQuery.of(context).size.height;
  static width(BuildContext context) => MediaQuery.of(context).size.width;
  static safearea(BuildContext context) => MediaQuery.of(context).padding.top;
}
