import 'package:baedalgeek/models/base.dart';
import 'package:baedalgeek/utils/callbacks.dart';
import 'package:baedalgeek/utils/date.dart';
import 'package:baedalgeek/widgets/card.dart';
import 'package:baedalgeek/widgets/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';

/// 일반 주문 시간대 모델
class OrderTime extends BaseModel {
  /// 시간대 이름
  final String timeLabel;

  /// 주문 마감 시간
  final TimeOfDay orderTime;

  /// 도착 예정 시간 - 시작
  final TimeOfDay deliveryTimeBegin;

  /// 도착 예정 시간 - 종료
  final TimeOfDay deliveryTimeEnd;

  const OrderTime({
    required this.timeLabel,
    required this.orderTime,
    required this.deliveryTimeBegin,
    required this.deliveryTimeEnd,
  });

  /// 현재를 기준으로 주문 시간대 생성
  List<OrderDateTime> generateDateTime() {
    final mapContent = (DateTime date, TimeOfDay time) {
      return DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    };

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final orderTimes = [
      mapContent(today, orderTime),
      mapContent(tomorrow, orderTime),
    ];
    final deliveryTimeBegins = [
      mapContent(today, deliveryTimeBegin),
      mapContent(tomorrow, deliveryTimeBegin),
    ];
    final deliveryTimeEnds = [
      mapContent(today, deliveryTimeEnd),
      mapContent(tomorrow, deliveryTimeEnd),
    ];
    return zip([
      orderTimes,
      deliveryTimeBegins,
      deliveryTimeEnds,
    ])
        .map((e) => OrderDateTime(
              timeLabel: timeLabel,
              orderTime: e[0],
              deliveryTimeBegin: e[1],
              deliveryTimeEnd: e[2],
            ))
        .toList();
  }
}

class OrderTimeList extends BaseModel {
  final List<OrderTime> inner;

  OrderTimeList({required this.inner});

  /// 현재를 기준으로 주문 시간대 생성
  OrderDateTimeList generateDateTime() {
    if (inner.isEmpty) return OrderDateTimeList(inner: []);
    return OrderDateTimeList(
      inner: inner
          .map((e) => e.generateDateTime())
          .reduce((value, element) => value..addAll(element))
            ..sort(),
    );
  }
}

/// 현재를 기준으로 한 주문 시간대 모델
///
class OrderDateTime extends BaseModel implements Comparable {
  /// 시간대 이름
  final String timeLabel;

  /// 주문 마감 시간
  final DateTime orderTime;

  /// 도착 예정 시간 - 시작
  final DateTime deliveryTimeBegin;

  /// 도착 예정 시간 - 종료
  final DateTime deliveryTimeEnd;

  const OrderDateTime({
    required this.timeLabel,
    required this.orderTime,
    required this.deliveryTimeBegin,
    required this.deliveryTimeEnd,
  });

  /// 일자
  String? dateLabel() {
    final date = dayToString(orderTime);
    if (date == null || date != dayToString(deliveryTimeBegin)) {
      return null;
    }
    return date;
  }

  /// 수령 시간 범위
  String deliveryTimeRange() {
    return dateRangeToString(deliveryTimeBegin, deliveryTimeEnd);
  }

  Widget? toWidget({
    required VoidKeyCallback<OrderDateTime> onPressed,
  }) {
    // 시간 확인
    final dateLabel = this.dateLabel();
    if (dateLabel == null) {
      return null;
    }

    final titleGenerator = () {
      return Align(
        alignment: Alignment.center,
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            children: [
              TextSpan(text: dateLabel),
              TextSpan(
                text: ' $timeLabel',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    };

    final dateGenerator = ({
      required String label,
      required DateTime date,
      bool isDeadline = false,
    }) {
      String dateText = timeToString(date);
      if (isDeadline) {
        dateText = '~' + dateText;
      }
      dateText = ' ' + dateText;

      return RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(text: dateText),
          ],
        ),
      );
    };

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: 8,
              ),
              child: titleGenerator(),
            ),
            dateGenerator(
              label: '주문',
              date: orderTime,
              isDeadline: true,
            ),
            dateGenerator(
              label: '도착',
              date: deliveryTimeBegin,
            ),
          ],
        ),
      ),
    );
  }

  @override
  int compareTo(other) => orderTime.compareTo(other.orderTime);
}

class OrderDateTimeList extends BaseModel {
  final List<OrderDateTime> inner;

  const OrderDateTimeList({required this.inner});

  /// 주문 가능한 가장 빠른 시간대를 탐색합니다.
  OrderDateTime nextDateTime() {
    final now = DateTime.now();
    return inner.where((e) => e.orderTime.isAfter(now)).first;
  }

  Widget toWidget({
    required BuildContext context,
    bool isCategory = true,
    required VoidKeyCallback<OrderDateTime> onPressed,
  }) {
    final nextDateTime = this.nextDateTime();

    final accentStyle = TextStyle(
      color: Colors.orange,
    );

    final dayOrderText = dayToString(nextDateTime.orderTime);
    final dayDeliveryToday = dateIsToday(nextDateTime.deliveryTimeBegin)
        ? ''
        : '${dayToString(nextDateTime.deliveryTimeBegin)} ';

    Widget widget = Column(
      children: [
        toCardButton(
          icon: Icons.delivery_dining,
          iconSize: 16,
          title: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
              ),
              children: [
                TextSpan(
                  text: '$dayOrderText ',
                ),
                TextSpan(
                  text: timeToString(nextDateTime.orderTime),
                  style: accentStyle,
                ),
                TextSpan(
                  text: '까지 주문하면 $dayDeliveryToday',
                ),
                TextSpan(
                  text: timeToString(nextDateTime.deliveryTimeBegin),
                  style: accentStyle,
                ),
                TextSpan(
                  text: ' 음식 수령가능!',
                ),
              ],
            ),
          ),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          radius: 16,
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.fromLTRB(6, 4, 4, 4),
        ),
        SizedBox(
          height: 110,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.from(
              inner
                  .map((e) => e.toWidget(
                        onPressed: onPressed,
                      ))
                  .where((e) => e != null),
            ),
          ),
        ),
      ],
    );

    if (isCategory) {
      widget = categorize(
        context: context,
        title: '음식주문/도착 시간표',
        child: widget,
      );
    }
    return widget;
  }
}
