import 'package:baedalgeek/models/base.dart';
import 'package:flutter/material.dart';

/// 평점 모델
///
class Rating extends BaseModel {
  /// 평균 평점. 0 <= x <= 5
  final double score;

  /// 참여자 수
  final int count;

  const Rating({
    required this.score,
    required this.count,
  });

  const Rating.empty()
      : this.score = 0,
        this.count = 0;

  String get countText => count < 1000 ? count.toString() : '999+';

  Widget toWidget() {
    return IntrinsicWidth(
      child: Container(
        padding: EdgeInsets.only(top: 3),
        child: Row(
          children: [
            Icon(
              Icons.star,
              color: Colors.pink,
              size: 15,
            ),
            Text(
              score.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' ($countText)',
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
