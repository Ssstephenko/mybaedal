import 'package:baedalgeek/models/base.dart';
import 'package:baedalgeek/models/rating.dart';
import 'package:baedalgeek/models/shop.dart';
import 'package:baedalgeek/utils/cost.dart';
import 'package:baedalgeek/widgets/category.dart';
import 'package:baedalgeek/widgets/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 음식 옵션 모델
///
class FoodOption extends BaseModel {
  /// 이름
  final String name;

  /// 비용
  final int cost;

  /// 선택 여부
  bool isSelected;

  FoodOption({
    required this.name,
    required this.cost,
    required this.isSelected,
  });

  @override
  String toString() {
    return name;
  }
}

class FoodOptionList extends BaseModel {
  /// 옵션명
  final String label;

  /// 선택지
  final List<FoodOption> options;

  /// 필수선택
  final bool isRequired;

  const FoodOptionList({
    required this.label,
    required this.options,
    required this.isRequired,
  });

  /// 총액
  int get costTotal {
    if (options.isEmpty) return 0;
    return options
        .where((e) => e.isSelected)
        .map((e) => e.cost)
        .reduce((value, element) => value += element);
  }

  @override
  String toString() {
    return '$label[${options.where((e) => e.isSelected).map((e) => e.toString()).join('+')}]';
  }
}

class FoodOptionMap extends BaseModel {
  final List<FoodOptionList> inner;

  const FoodOptionMap({
    required this.inner,
  });

  /// 총액
  int get costTotal {
    if (inner.isEmpty) return 0;
    return inner
        .map((e) => e.costTotal)
        .reduce((value, element) => value += element);
  }

  @override
  String toString() {
    if (inner.isEmpty) return '';
    return '옵션 - ' + inner.map((e) => e.toString()).join('+');
  }
}

/// 음식 모델
///
class Food extends BaseModel {
  /// 품명
  final String name;

  /// 상점
  final String shopName;

  /// 설명
  final String desc;

  /// 썸네일 이미지 경로
  final String imageUrl;

  /// 비용
  final int cost;

  /// 배달비용
  final int deliveryCost;

  /// 평점
  final Rating rating;

  /// 옵션
  final FoodOptionMap options;

  /// 상점 재주문율 - 6개월 이내 2회 이상 구매 비율
  final double reorderRate;

  /// 지난 주 소비량
  final int numLastWeek;

  /// 주문 누적수
  final int numUser;

  /// 최근 소비 일자
  final DateTime? lastDate;

  /// 선택 수량
  int amount = 1;

  Food({
    required this.name,
    required this.shopName,
    required this.desc,
    required this.imageUrl,
    required this.cost,
    required this.deliveryCost,
    required this.rating,
    required this.options,
    required this.reorderRate,
    required this.numLastWeek,
    required this.numUser,
    required this.lastDate,
    amount,
  });

  /// 총액
  int get costTotal => cost + options.costTotal;

  /// 원 단위 표시
  String get costText => costToString(cost);

  /// 총액의 원 단위 표시
  String get costTotalText => costToString(costTotal);

  /// 최근 소비 일수
  int? get lastDays {
    return lastDate != null ? DateTime.now().day - lastDate!.day : null;
  }
}

class FoodList {
  final List<Food> inner;

  const FoodList({
    required this.inner,
  });

  FoodShopPairList pairs(Shop shop) {
    return FoodShopPairList(
      inner: inner
          .map((food) => FoodShopPair(
                food: food,
                shop: shop,
              ))
          .toList(),
    );
  }

  /// 총액
  int get costTotal {
    if (inner.isEmpty) return 0;
    return inner
        .map((e) => e.costTotal)
        .reduce((value, element) => value += element);
  }
}

class FoodShopPair {
  final Food food;
  final Shop shop;

  const FoodShopPair({
    required this.food,
    required this.shop,
  });

  Widget toWidgetTile({
    required BuildContext context,
    required FoodOrder order,
  }) {
    Widget orderDesc = SizedBox.shrink();
    switch (order) {
      case FoodOrder.LastWeekRate:
        orderDesc = Padding(
          padding: EdgeInsets.all(6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '냠냠한분',
                style: TextStyle(
                  fontSize: 7,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${food.numLastWeek}명',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
        break;
      case FoodOrder.LastDate:
        orderDesc = Padding(
          padding: EdgeInsets.fromLTRB(6, 16, 6, 6),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: Text(
                  '${food.lastDays}일전',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.food_bank,
                size: 12,
              ),
            ],
          ),
        );
        break;
    }

    return cardItem(
      width: 160,
      imageHeight: 100,
      imageUrl: food.imageUrl,
      onPressed: () => showDetail(context),
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 8,
            left: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    food.name,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${food.costText}원',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: orderDesc,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 식당 화면으로 이동
  void showDetail(BuildContext context) {}
}

class FoodShopPairList extends BaseModel {
  final List<FoodShopPair> inner;

  const FoodShopPairList({
    required this.inner,
  });

  FoodShopPairList ordered(FoodOrder order) {
    final inner = List<FoodShopPair>.from(this.inner);
    switch (order) {
      case FoodOrder.LastWeekRate:
        inner..sort((a, b) => b.food.numLastWeek.compareTo(a.food.numLastWeek));
        break;
      case FoodOrder.LastDate:
        inner
          ..removeWhere((e) => e.food.lastDate == null)
          ..sort((a, b) => b.food.lastDate!.compareTo(a.food.lastDate!));
    }
    return FoodShopPairList(
      inner: inner,
    );
  }

  Widget toWidgetHorizontal({
    required BuildContext context,
    required FoodOrder order,
    required VoidCallback onTitlePressed,
  }) {
    final ordered = this.ordered(order);

    return categorize(
      context: context,
      title: order.title(),
      onTitlePressed: onTitlePressed,
      child: SizedBox(
        height: 155,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: ordered.inner
              .map((e) => e.toWidgetTile(
                    context: context,
                    order: order,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

/// 음식 정렬 순서
enum FoodOrder {
  /// 지난 주 인기메뉴
  LastWeekRate,

  /// 추천메뉴
  LastDate,
}

extension FoodOrderExtension on FoodOrder {
  String title() {
    switch (this) {
      case FoodOrder.LastWeekRate:
        return '지난 주 인기메뉴';
      case FoodOrder.LastDate:
        return '추천메뉴';
    }
  }
}
