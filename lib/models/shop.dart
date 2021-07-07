import 'package:baedalgeek/models/base.dart';
import 'package:baedalgeek/models/food.dart';
import 'package:baedalgeek/models/rating.dart';
import 'package:baedalgeek/models/review.dart';
import 'package:baedalgeek/utils/date.dart';
import 'package:baedalgeek/widgets/category.dart';
import 'package:baedalgeek/widgets/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 상점 모델
///
class Shop extends BaseModel {
  static final double width = 100;
  static final double height = 150;

  /// 상호명
  final String name;

  /// 썸네일 이미지 경로
  final String imageUrl;

  /// 배달비용
  final int deliveryCost;

  /// 신규 입점 업체
  final bool isNew;

  /// 할인율
  final double discountRate;

  /// 주문 마감 시간
  final TimeOfDay orderTime;

  /// 품목
  final FoodList foods;

  /// 리뷰 목록
  final ReviewList reviews;

  /// 주문 누적수
  final int numUser;

  const Shop({
    required this.name,
    required this.imageUrl,
    required this.deliveryCost,
    required this.isNew,
    required this.discountRate,
    required this.orderTime,
    required this.foods,
    required this.reviews,
    required this.numUser,
  });

  /// 평점
  Rating get rating => reviews.rating;

  /// 주문 마감
  bool isOver() => timeIsAvailable(orderTime);

  Widget toWidget({
    required BuildContext context,
  }) {
    return cardItem(
      width: width,
      imageHeight: width,
      imageUrl: imageUrl,
      onPressed: () => showDetail(context),
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              rating.toWidget(),
            ],
          ),
        ),
      ],
    );
  }

  /// 식당 화면으로 이동
  void showDetail(BuildContext context) {}
}

class ShopList extends BaseModel {
  final List<Shop> inner;

  ShopList({required this.inner});

  ShopList ordered(ShopOrder order) {
    // 배달긱 추천순으로 사전 정렬한다.
    final inner = List<Shop>.from(this.inner);

    switch (order) {
      case ShopOrder.Recommended:
        break;
      case ShopOrder.UserOrderCount:
        inner..sort((a, b) => b.numUser.compareTo(a.numUser));
        break;
      case ShopOrder.DiscountRate:
        inner..sort((a, b) => b.discountRate.compareTo(a.discountRate));
        break;
      case ShopOrder.NumReview:
        inner..sort((a, b) => b.rating.count.compareTo(a.rating.count));
        break;
      case ShopOrder.Rating:
        inner..sort((a, b) => b.rating.score.compareTo(a.rating.score));
        break;
    }
    return ShopList(
      inner: inner,
    );
  }

  Widget toWidgetHorizontal({
    required BuildContext context,
    required VoidCallback onTitlePressed,
  }) {
    return categorize(
      context: context,
      title: '상점',
      onTitlePressed: onTitlePressed,
      child: SizedBox(
        height: 150,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: inner
              .map((e) => e.toWidget(
                    context: context,
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget toWidgetGrid({
    required BuildContext context,
    required ShopOrder order,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = 3;
    final crossAxisSpacing = 16.0;
    final mainAxisSpacing = 24.0;
    final width = (screenWidth -
            Shop.width * crossAxisCount -
            crossAxisSpacing * (crossAxisCount - 1)) /
        2;

    return GridView.count(
      childAspectRatio: Shop.width / Shop.height,
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing,
      padding: EdgeInsets.fromLTRB(width, 16, width, 24),
      primary: false,
      shrinkWrap: true,
      children: ordered(order)
          .inner
          .map((e) => e.toWidget(
                context: context,
              ))
          .toList(),
    );
  }
}

enum ShopOrder {
  Recommended,
  UserOrderCount,
  DiscountRate,
  NumReview,
  Rating,
}

extension ShopOrderExtension on ShopOrder {
  static List<ShopOrder> all() {
    return [
      ShopOrder.Recommended,
      ShopOrder.UserOrderCount,
      ShopOrder.DiscountRate,
      ShopOrder.NumReview,
      ShopOrder.Rating,
    ];
  }

  String toLabel() {
    switch (this) {
      case ShopOrder.Recommended:
        return '배달긱 추천순';
      case ShopOrder.UserOrderCount:
        return '내 주문누적수';
      case ShopOrder.DiscountRate:
        return '할인율 높은순';
      case ShopOrder.NumReview:
        return '리뷰 많은순';
      case ShopOrder.Rating:
        return '별점 높은순';
    }
  }
}
