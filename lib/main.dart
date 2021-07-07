import 'package:baedalgeek/pages/main/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

/// 가장 먼저 시작되고, 가장 나중에 종료되는 main 함수.
/// main 함수의 수명은 앱의 수명과 동일합니다.
void main() {
  initializeDateFormatting('ko-KR');
  runApp(App());
}

/// 앱의 전체적인 테마 등을 정의하는 클래스.
///
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '배달긱',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MainPage(),
    );
  }
}
