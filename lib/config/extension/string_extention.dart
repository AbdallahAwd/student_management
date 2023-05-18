import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension AssetPath on String {
  String get toPng => 'assets/img/$this.png';
  String get toSvg => 'assets/img/$this.svg';
  String get toGenWebp => 'assets/img/genImage/$this.webp';
  Text txt(
          {double fontSize = 14,
          Color? color = Colors.black,
          TextAlign? textAlign,
          String? fontFamily,
          FontWeight? fontWeight}) =>
      Text(
        this,
        textAlign: textAlign,
        style: TextStyle(
            fontSize: fontSize,
            fontFamily: fontFamily,
            color: color,
            fontWeight: fontWeight),
      );
  // String get formatDate =>
  // DateFormat("yyyy/MM/dd HH:mm").format(DateTime.now());

  String compareWords(String string2) {
    List<String> list1 = split(" ");
    List<String> list2 = string2.split(" ");
    Set<String> set1 = list1.toSet();
    Set<String> set2 = list2.toSet();
    Set<String> difference = set1.difference(set2);
    return difference.join(" ");
  }

  bool get isSvg {
    List<String> list = split(".");

    return list.last == 'svg';
  }

  bool get isHoodie => toLowerCase().contains('hoodie');
  bool get isTshirt => toLowerCase().contains('t-shirt');
  bool get isSleeveShirt => toLowerCase().contains('sleeve');
  bool get isSocks => toLowerCase().contains('socks');
  bool get isPillow => toLowerCase().contains('pillow');
  bool get isCanvas => toLowerCase().contains('canvas');

  String get detectType {
    if (isTshirt || isHoodie) return 'front';
    return 'default';
  }
}

extension Date on DateTime {
  String get formatDate => DateFormat("yyyy/MM/dd").format(this);
}
