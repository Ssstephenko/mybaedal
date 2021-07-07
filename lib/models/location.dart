import 'package:baedalgeek/models/banner.dart';
import 'package:baedalgeek/models/date.dart';
import 'package:baedalgeek/models/food.dart';
import 'package:baedalgeek/models/membership_shop.dart';
import 'package:baedalgeek/models/shop.dart';

/// 배달 주소지 모델
class DeliveryLocation {
  /// 소재지
  final String name;

  /// 주소지
  final String address;

  /// 수령 장소
  final List<String> spots;

  /// 시간대
  final OrderTimeList orderTimes;

  /// 상점 목록
  final ShopList shops;

  /// 멤버쉽
  final MembershipLocation membership;

  /// 배너
  final BannerList banners;

  const DeliveryLocation({
    required this.name,
    required this.address,
    required this.spots,
    required this.orderTimes,
    required this.shops,
    required this.membership,
    required this.banners,
  });

  /// 전체메뉴
  FoodShopPairList foodsAll() {
    if (shops.inner.isEmpty) return FoodShopPairList(inner: []);
    return shops.inner
        .map((shop) => shop.foods.pairs(shop))
        .reduce((value, element) => value..inner.addAll(element.inner));
  }
}
