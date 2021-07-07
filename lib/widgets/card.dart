import 'package:flutter/material.dart';

/// 터치할 수 있는 Card 버튼 위젯.
/// 수평 방향으로 아이콘과 레이블을 정렬합니다.
Widget toCardButton({
  required IconData icon,
  double iconSize = 22,
  required Widget title,
  required Color backgroundColor,
  required Color foregroundColor,
  double radius = 10.0,
  EdgeInsets? margin,
  EdgeInsets? padding,
  VoidCallback? onPressed,
}) {
  return InkWell(
    onTap: onPressed,
    child: Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      margin: margin ??
          EdgeInsets.only(
            top: 12,
            bottom: 12,
            left: 4,
            right: 4,
          ),
      child: Padding(
        padding: padding ?? EdgeInsets.fromLTRB(24, 4, 24, 4),
        child: Row(
          children: [
            Icon(
              icon,
              color: foregroundColor,
              size: iconSize,
            ),
            Padding(
              padding: EdgeInsets.only(left: 4),
              child: title,
            ),
          ],
        ),
      ),
    ),
  );
}

/// 터치할 수 있는 Card 버튼 위젯.
/// 수직 방향으로 아이콘과 레이블을 정렬합니다.
Widget toCardButtonVertical({
  required IconData icon,
  double iconSize = 22,
  required Widget title,
  required Color backgroundColor,
  required Color foregroundColor,
  double radius = 10.0,
  EdgeInsets? margin,
  EdgeInsets? padding,
  VoidCallback? onPressed,
}) {
  return InkWell(
    onTap: onPressed,
    child: Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      margin: margin ??
          EdgeInsets.only(
            left: 16,
          ),
      child: Padding(
        padding: padding ?? EdgeInsets.fromLTRB(6, 4, 6, 4),
        child: Column(
          children: [
            Icon(
              icon,
              color: foregroundColor,
              size: iconSize,
            ),
            title,
          ],
        ),
      ),
    ),
  );
}
