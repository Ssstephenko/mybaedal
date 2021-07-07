import 'package:baedalgeek/models/base.dart';
import 'package:baedalgeek/models/date.dart';
import 'package:baedalgeek/models/food.dart';
import 'package:baedalgeek/models/review.dart';
import 'package:baedalgeek/utils/cost.dart';
import 'package:baedalgeek/utils/date.dart';
import 'package:baedalgeek/widgets/card.dart';
import 'package:baedalgeek/widgets/contour.dart';
import 'package:flutter/material.dart';

/// 음식 주문 정보 모델
///
class OrderFood extends BaseModel {
  /// 음식 정보
  final Food food;

  /// 주문 시간대
  final OrderDateTime dateTime;

  /// 수령 장소
  final String spot;

  /// 수령 번호
  final String? deliveryId;

  /// 리뷰
  final Review? review;

  const OrderFood({
    required this.food,
    required this.dateTime,
    required this.spot,
    required this.deliveryId,
    required this.review,
  });

  Widget toWidget({
    required BuildContext context,
  }) {
    final toKeyValueText = ({
      EdgeInsets? padding,
      required String key,
      required String value,
    }) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: padding,
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
            children: [
              TextSpan(
                text: key,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: value,
              ),
            ],
          ),
        ),
      );
    };

    // 리뷰버튼
    Widget reviewWidget;
    reviewWidget = toCardButtonVertical(
      icon: Icons.search,
      title: Text(
        '리뷰보기',
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
        ),
      ),
      backgroundColor: Colors.orange[200]!,
      foregroundColor: Colors.white,
    );

    final foodOptions = food.options.toString();

    return Column(
      children: [
        toKeyValueText(
          padding: EdgeInsets.only(
            top: 24,
            left: 30,
          ),
          key: '결제금액 : ',
          value: '${food.costTotalText}원',
        ),
        toKeyValueText(
          padding: EdgeInsets.only(
            top: 4,
            left: 30,
          ),
          key: '수령시간 : ',
          value: dateTime.deliveryTimeRange(),
        ),
        // 배송정보
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          margin: EdgeInsets.only(
            top: 24,
            bottom: 24,
            left: 12,
            right: 12,
          ),
          padding: EdgeInsets.fromLTRB(12, 16, 12, 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 메뉴명
                    Text(
                      food.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // 옵션
                    foodOptions.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Text(
                              foodOptions,
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          )
                        : SizedBox(),
                    // 결제금액
                    toKeyValueText(
                      padding: EdgeInsets.only(top: 4),
                      key: '결제금액 : ',
                      value: '${food.costTotalText}원',
                    ),
                  ],
                ),
              ),
              // 리뷰버튼
              reviewWidget,
            ],
          ),
        ),
        // 배송번호
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: spot,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              TextSpan(
                text: ' $deliveryId',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OrderFoodList extends BaseModel {
  final List<OrderFood> inner;

  const OrderFoodList({
    required this.inner,
  });

  /// 총액
  int get costTotal {
    if (inner.isEmpty) return 0;
    return inner
        .map((e) => e.food.costTotal)
        .reduce((value, element) => value += element);
  }

  /// 배달비용 총액
  /// * 같은 상점의 여러 배송건의 배달비용은 결합합니다.
  int get deliveryCostTotal {
    if (inner.isEmpty) return 0;
    return Map<String, int>.fromIterable(
      inner,
      key: (e) => e.food.shopName,
      value: (e) => e.food.deliveryCost,
    ).entries.map((e) => e.value).reduce((value, element) => value += element);
  }

  /// 총액의 원 단위 표시
  String get costTotalText => costToString(costTotal);

  /// 배달비용 총액의 원 단위 표시
  String get deliveryCostTotalText => costToString(deliveryCostTotal);

  Widget toWidget({
    required BuildContext context,
  }) {
    Widget toKeyValueWidget({
      Color? color,
      double fontSize = 16,
      required String key,
      required String value,
    }) {
      final textStyle = TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      );

      return Padding(
        padding: EdgeInsets.fromLTRB(24, 0, 24, 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Text(
                key,
                style: textStyle,
              ),
            ),
            Text(
              value,
              style: textStyle,
            ),
          ],
        ),
      );
    }

    final foodWidgets = inner
        .map((e) => e.toWidget(
              context: context,
            ))
        .fold<List<Widget>>([], (previousValue, element) {
      if (previousValue.isNotEmpty) {
        previousValue.add(contour(
          margin: EdgeInsets.only(
            top: 24,
            left: 30,
            right: 30,
          ),
        ));
      }
      previousValue.add(Padding(
        padding: EdgeInsets.only(top: 12),
        child: element,
      ));
      return previousValue;
    });

    final costFoods = inner
        .map((e) => toKeyValueWidget(
              key: e.food.name,
              value: e.food.costTotalText,
            ))
        .toList();

    final costDiscount = [
      toKeyValueWidget(
        key: '배달비',
        value: '$deliveryCostTotalText',
      ),
      toKeyValueWidget(
        color: Colors.red,
        key: '총 할인금액',
        value: '- $deliveryCostTotalText',
      ),
      toKeyValueWidget(
        color: Colors.red,
        fontSize: 13,
        key: 'ㄴ 배달비 할인',
        value: '- $deliveryCostTotalText',
      ),
    ];

    final costTotal = [
      contour(
        margin: EdgeInsets.fromLTRB(16, 12, 16, 4),
      ),
      Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(
          top: 12,
          right: 16,
          bottom: 12,
        ),
        child: Text(
          '합계 $costTotalText원',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
    ];

    final costWidget = [
      Padding(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 12),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            title: Text(
              '총 결제금액 : $costTotalText원',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: costFoods + costDiscount + costTotal,
          ),
        ),
      ),
    ];

    return Column(
      children: foodWidgets + costWidget,
    );
  }
}

/// 주문 정보 모델
///
class Order extends BaseModel {
  /// 음식 목록
  final OrderFoodList foods;

  /// 주문시간
  final DateTime orderDate;

  const Order({
    required this.foods,
    required this.orderDate,
  });

  Widget toWidget({
    required BuildContext context,
  }) {
    return Card(
      margin: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 24,
              bottom: 4,
            ),
            child: Text(
              '주문시간: ${dateTimeToString(orderDate)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            color: Colors.orange[100],
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
              bottom: 4,
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
                children: [
                  TextSpan(
                    text: '음식의 신선도와 다음 배달 수령자를 위해 수령시간\n',
                  ),
                  TextSpan(
                    text: '30분 이내 음식',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  TextSpan(
                    text: '을 꼭 ',
                  ),
                  TextSpan(
                    text: '수령',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  TextSpan(
                    text: '해주세요!\n',
                  ),
                  TextSpan(
                    style: TextStyle(
                      fontSize: 10,
                    ),
                    text: '(시간 경과 시, 위생 및 안전을 위해 음식은 폐기처리됨)',
                  ),
                ],
              ),
            ),
          ),
          foods.toWidget(
            context: context,
          ),
        ],
      ),
    );
  }
}

class OrderList extends BaseModel {
  final List<Order> inner;

  const OrderList({
    required this.inner,
  });

  Widget toWidget({
    required BuildContext context,
  }) {
    return ListView(
      padding: EdgeInsets.only(bottom: 16),
      children: inner
          .map((e) => e.toWidget(
                context: context,
              ))
          .toList(),
    );
  }
}
