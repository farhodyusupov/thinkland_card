import 'package:flutter/material.dart';

double customWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double customHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

List<String> defaultImages = [
  "assets/card_2.png",
  "assets/card_3.png",
  "assets/card_4.png",
];
