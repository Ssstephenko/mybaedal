import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 상대적인 일자 값을 문자열로 변환합니다.
///
/// 반환값
/// * "오늘", "내일" 등
String? dayToString(DateTime dateTime) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final tomorrow = DateTime(now.year, now.month, now.day + 1);

  final target = DateTime(dateTime.year, dateTime.month, dateTime.day);
  if (target == today) {
    return '오늘';
  }
  if (target == tomorrow) {
    return '내일';
  }
  return null;
}

/// 시간 값을 월/일, 요일을 포함하여 문자열로 변환합니다.
///
/// 반환값
/// * M월 DD일(E) kk:mm:ss
String dateTimeToString(DateTime dateTime) {
  return DateFormat('M월 dd일(E) kk:mm:ss', 'ko-KR').format(dateTime);
}

/// 시간 범위 값을 월/일, 요일을 포함하여 문자열로 변환합니다.
/// 일자는 동일하다고 가정합니다.
///
/// 반환값
/// * M월 DD일(E) kk:mm ~ kk:mm
String dateRangeToString(DateTime dateBegin, DateTime dateEnd) {
  return DateFormat('M월 dd일(E) kk:mm', 'ko-KR').format(dateBegin) +
      DateFormat(' ~ kk:mm', 'ko-KR').format(dateEnd);
}

/// 시간 값을 월/일을 제외하여 문자열로 변환합니다.
///
/// 반환값
/// * kk시
/// * kk시 mm분
String timeToString(DateTime dateTime) {
  if (dateTime.minute == 0) {
    return DateFormat('kk시').format(dateTime);
  } else {
    return DateFormat('kk시 mm분').format(dateTime);
  }
}

/// 주어진 시간이 오늘인지 판단합니다.
///
/// 반환값
/// * [true]: 오늘
bool dateIsToday(DateTime dateTime) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final target = DateTime(dateTime.year, dateTime.month, dateTime.day);
  return today == target;
}

/// 사용 가능한 시간대인지 확인합니다.
///
/// 반환값
/// * [true]: 사용 가능
bool dateIsAvailable(DateTime dateTime) {
  return DateTime.now().isAfter(dateTime);
}

/// 사용 가능한 시간대인지 확인합니다.
///
/// 반환값
/// * [true]: 사용 가능
bool timeIsAvailable(TimeOfDay time) {
  final now = DateTime.now();
  final dateTime = DateTime(
    now.year,
    now.month,
    now.day,
    time.hour,
    time.minute,
  );
  return now.isAfter(dateTime);
}
