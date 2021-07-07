import 'package:flutter/material.dart';

/// Card 위젯 템플릿.
Widget cardItem({
  required double width,
  required double? imageHeight,
  required String imageUrl,
  required VoidCallback onPressed,
  required List<Widget> children,
}) {
  final radius = Radius.circular(16.0);

  return InkWell(
    onTap: onPressed,
    child: SizedBox(
      width: width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(radius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: radius,
                    topRight: radius,
                  ),
                  child: Image.network(
                    imageUrl,
                    width: width,
                    height: imageHeight,
                    fit: BoxFit.fill,
                  ),
                ),
              ] +
              children,
        ),
      ),
    ),
  );
}
