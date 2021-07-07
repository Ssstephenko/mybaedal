import 'package:baedalgeek/models/base.dart';

/// 사용자 쿠폰 모델
///
class Coupon extends BaseModel {}

class CouponList extends BaseModel {
  final List<Coupon> inner;

  const CouponList({
    required this.inner,
  });
}
