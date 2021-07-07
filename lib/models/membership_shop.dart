import 'package:baedalgeek/models/base.dart';
import 'package:baedalgeek/models/rating.dart';
import 'package:baedalgeek/utils/date.dart';
import 'package:baedalgeek/widgets/category.dart';
import 'package:baedalgeek/widgets/item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 멤버쉽 주소 모델
class MembershipLocation extends BaseModel {
  /// 소재지
  final String name;

  /// 설명
  final String desc;

  /// 상점 목록
  final MembershipShopList shops;

  const MembershipLocation({
    required this.name,
    required this.desc,
    required this.shops,
  });
}

/// 멤버쉽 상점 모델
///
class MembershipShop extends BaseModel {
  /// 상호명
  final String name;

  /// 설명
  final String desc;

  /// 썸네일 이미지 경로
  final String imageUrl;

  /// 평점
  final Rating rating;

  /// 주문 마감 시간
  final DateTime orderTime;

  const MembershipShop({
    required this.name,
    required this.desc,
    required this.imageUrl,
    required this.rating,
    required this.orderTime,
  });

  /// 주문 마감
  bool isOver() => dateIsAvailable(orderTime);

  Widget toWidget({
    required BuildContext context,
  }) {
    return cardItem(
      width: 360,
      imageHeight: 120,
      imageUrl: imageUrl,
      onPressed: () => showDetail(context),
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 8,
            left: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 12,
                ),
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

class MembershipShopList extends BaseModel {
  final List<MembershipShop> inner;

  MembershipShopList({required this.inner});

  Widget toWidget({
    required BuildContext context,
    required MembershipLocation location,
  }) {
    return categorize(
      context: context,
      title: '${location.name} VVIP 멤버쉽',
      desc: location.desc,
      child: CarouselSlider(
        items: inner
            .map((e) => e.toWidget(
                  context: context,
                ))
            .toList(),
        options: CarouselOptions(
          autoPlay: true,
          height: 200,
          viewportFraction: 0.9,
        ),
      ),
    );
  }
}
