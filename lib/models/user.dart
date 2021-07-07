import 'package:baedalgeek/models/base.dart';
import 'package:baedalgeek/models/coupon.dart';
import 'package:baedalgeek/models/location.dart';
import 'package:baedalgeek/models/order.dart';

/// 일반 사용자 정보 모델
///
class User extends BaseModel {
  /// 닉네임
  final String nickname;

  const User({
    required this.nickname,
  });
}

/// 사용자 정보 모델
///
class UserMe extends BaseModel {
  /// 일반 사용자 정보
  final User inner;

  /// 아이디
  final String id;

  /// 타입
  final UserType type;

  /// 실명
  final String name;

  /// 서비스 장소
  final DeliveryLocation location;

  /// 주문 정보
  final OrderList orders;

  /// 보유 긱머니
  final int geekMoney;

  /// 보유 포인트
  final int geekPoints;

  /// 아낀 배달비
  final int savedDeliveryCost;

  /// 쿠폰 목록
  final CouponList coupons;

  /// 이벤트 참여 정보
  final UserEvent event;

  const UserMe({
    required this.inner,
    required this.id,
    required this.type,
    required this.name,
    required this.location,
    required this.orders,
    required this.geekMoney,
    required this.geekPoints,
    required this.savedDeliveryCost,
    required this.coupons,
    required this.event,
  });
}

/// 사용자 로그인 방식
enum UserType {
  /// 카카오톡 연동 로그인
  Kakao,
}

/// 이벤트 참여에 관련한 사용자 정보 모델
///
class UserEvent extends BaseModel {
  /// 친추수
  final int numFriends;

  const UserEvent({
    required this.numFriends,
  });
}
