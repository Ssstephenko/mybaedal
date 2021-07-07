import 'package:intl/intl.dart';

/// 비용을 문자열로 변환합니다.
String costToString(int cost) {
  final formatWon = new NumberFormat("#,###", "ko_KR");
  return formatWon.format(cost);
}
