import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 대표 화면의 카테고리 위젯.
Widget categorize({
  required BuildContext context,
  required String title,
  String? desc,
  required Widget child,
  VoidCallback? onTitlePressed,
}) {
  if (onTitlePressed != null) {
    title += ' >';
  }
  Widget titleText = Text(
    title,
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
  if (onTitlePressed != null) {
    titleText = InkWell(
      onTap: onTitlePressed,
      child: titleText,
    );
  }
  final titleContents = [
    titleText,
  ];
  if (desc != null) {
    titleContents.add(
      Text(desc),
    );
  }

  return Container(
    margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: titleContents,
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 8,
            bottom: 8,
          ),
          child: child,
        ),
      ],
    ),
  );
}
