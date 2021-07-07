import 'package:baedalgeek/models/notice.dart';
import 'package:baedalgeek/models/user.dart';
import 'package:flutter/material.dart';

/// 하단 네비게이션 메뉴를 정의하는 클래스
///
mixin BasePageGenerator {
  /// 아이콘 이미지
  Icon get icon;

  /// 메뉴가 활성화되었을 경우의 아이콘 이미지.
  /// 기본값으로 [icon]을 사용합니다.
  Icon get activeIcon => icon;

  /// 메뉴명
  String get label;

  Widget createWidget({
    required UserMe me,
    required NoticeList notices,
  });

  BottomNavigationBarItem bottomNavigationBarItem() {
    return BottomNavigationBarItem(
      icon: icon,
      activeIcon: activeIcon,
      label: label,
    );
  }
}
