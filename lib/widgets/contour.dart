import 'package:flutter/material.dart';

/// 구분선
Widget contour({
  required EdgeInsets margin,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(
          color: Colors.grey[300]!,
        ),
      ),
    ),
    margin: margin,
  );
}
