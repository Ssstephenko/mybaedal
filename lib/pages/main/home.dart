import 'package:baedalgeek/models/company.dart';
import 'package:baedalgeek/models/food.dart';
import 'package:baedalgeek/models/notice.dart';
import 'package:baedalgeek/models/user.dart';
import 'package:baedalgeek/pages/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 앱의 대표 화면
///
class HomePageGenerator with BasePageGenerator {
  const HomePageGenerator();

  @override
  Icon get icon => Icon(Icons.home);

  @override
  String get label => 'Home';

  @override
  Widget createWidget({
    required UserMe me,
    required NoticeList notices,
  }) {
    return HomePage(me, notices);
  }
}

class HomePage extends StatefulWidget {
  final UserMe me;
  final NoticeList notices;

  HomePage(this.me, this.notices);

  @override
  State createState() => _State(me, notices);
}

class _State extends State {
  final UserMe me;
  final NoticeList notices;

  _State(this.me, this.notices);

  @override
  Widget build(BuildContext context) {
    final foods = me.location.foodsAll();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.help,
            color: Colors.pink[100],
          ),
          onPressed: showHelp,
        ),
        title: Text('TODO'),
      ),
      body: ListView(
        children: [
          // 상단 배너
          me.location.banners.toWidget(
            context: context,
          ),
          // 음식주문/도착 시간표
          me.location.orderTimes.generateDateTime().toWidget(
                context: context,
                onPressed: (e) => print(e),
              ),
          // VVIP 멤버쉽
          me.location.membership.shops.toWidget(
            context: context,
            location: me.location.membership,
          ),
          // 상점 목록
          me.location.shops.toWidgetHorizontal(
            context: context,
            onTitlePressed: () => print('123'),
          ),
          // 지난 주 인기메뉴
          foods.toWidgetHorizontal(
            context: context,
            order: FoodOrder.LastWeekRate,
            onTitlePressed: () => print('123'),
          ),
          // 추천메뉴
          foods.toWidgetHorizontal(
            context: context,
            order: FoodOrder.LastDate,
            onTitlePressed: () => print('123'),
          ),
          // 공지사항
          Padding(
            padding: EdgeInsets.only(top: 24),
            child: notices.toWidget(
              context: context,
            ),
          ),
          // 회사 정보
          CompanyInfo().toWidget(
            context: context,
          ),
        ],
      ),
    );
  }

  /// 도움말을 보여줍니다.
  void showHelp() {
    print('도움말 보여주기');
  }
}
