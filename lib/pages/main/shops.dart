import 'package:baedalgeek/models/notice.dart';
import 'package:baedalgeek/models/shop.dart';
import 'package:baedalgeek/models/user.dart';
import 'package:baedalgeek/pages/base.dart';
import 'package:baedalgeek/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 전체상점 화면
///
class ShopsPageGenerator with BasePageGenerator {
  const ShopsPageGenerator();

  @override
  Icon get icon => Icon(Icons.search);

  @override
  String get label => '전체상점';

  @override
  Widget createWidget({
    required UserMe me,
    required NoticeList notices,
  }) {
    return ShopsPage(me);
  }
}

class ShopsPage extends StatefulWidget {
  final UserMe me;

  ShopsPage(this.me);

  @override
  State createState() => _State(me);
}

class _State extends State {
  final UserMe me;
  final List<ShopOrder> orders = ShopOrderExtension.all();

  int _currentIndex = 0;

  _State(this.me);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('상점'),
      ),
      body: ListView(
        children: [
          // 음식주문/도착 시간표
          Padding(
            padding: EdgeInsets.only(
              top: 24,
              left: 8,
              right: 8,
            ),
            child: me.location.orderTimes.generateDateTime().toWidget(
                  context: context,
                  isCategory: false,
                  onPressed: (e) => print(e),
                ),
          ),
          // 정렬 기준
          Padding(
            padding: EdgeInsets.only(top: 24),
            child: textListButtonGroup(
              currentIndex: _currentIndex,
              children: orders.map((e) => TextListButton(e.toLabel())).toList(),
              onChanged: (e) => setState(() => _currentIndex = e),
            ),
          ),
          // 식당 목록
          me.location.shops.ordered(orders[_currentIndex]).toWidgetGrid(
                context: context,
                order: orders[_currentIndex],
              ),
        ],
      ),
    );
  }
}
