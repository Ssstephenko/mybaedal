import 'package:baedalgeek/models/base.dart';
import 'package:baedalgeek/models/food.dart';
import 'package:baedalgeek/models/rating.dart';
import 'package:baedalgeek/models/user.dart';

/// 리뷰 모델
///
class Review extends BaseModel {
  /// 유저
  final User user;

  /// 주문한 음식
  final FoodList foods;

  /// 맛 점수
  final double scoreTaste;

  /// 양 점수
  final double scoreQuantity;

  /// 상태 점수
  final double scoreCondition;

  /// 내용
  final String desc;

  /// 사장님 답변
  final String? response;

  /// 작성 일자
  final DateTime dateCreated;

  /// 좋아요 횟수
  final double numLikes;

  /// 좋아요 여부
  final bool userLike;

  const Review({
    required this.user,
    required this.foods,
    required this.scoreTaste,
    required this.scoreQuantity,
    required this.scoreCondition,
    required this.desc,
    required this.response,
    required this.dateCreated,
    required this.numLikes,
    required this.userLike,
  });

  /// 평균 점수
  double get scoreAverage => (scoreTaste + scoreQuantity + scoreCondition) / 3;
}

class ReviewList extends BaseModel {
  final List<Review> inner;

  const ReviewList({
    required this.inner,
  });

  /// 평점
  Rating get rating {
    if (inner.isEmpty) return Rating.empty();
    return Rating(
      score: inner
              .map((e) => e.scoreAverage)
              .reduce((value, element) => value + element) /
          inner.length,
      count: inner.length,
    );
  }
}
