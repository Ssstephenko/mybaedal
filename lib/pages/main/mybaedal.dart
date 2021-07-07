import 'package:baedalgeek/models/notice.dart';
import 'package:baedalgeek/models/shop.dart';
import 'package:baedalgeek/models/user.dart';
import 'package:baedalgeek/pages/base.dart';
import 'package:baedalgeek/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyBaedalPageGenerator with BasePageGenerator {
  const MyBaedalPageGenerator();

  @override
  Icon get icon => Icon(Icons.card_membership);

  @override
  String get label => '마이배달긱';

  @override
  Widget createWidget({
    required UserMe me,
    required NoticeList notices,
  }) {
    return MyBaedalPage(me);
  }
}

class MyBaedalPage extends StatefulWidget {
  final UserMe me;

  MyBaedalPage(this.me);

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
        title: Text('마이배달긱'),
      ),
      body: ListView(
        children: [
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
          Padding(
            padding: EdgeInsets.only(top: 24),
            child: textListButtonGroup(
              currentIndex: _currentIndex,
              children: orders.map((e) => TextListButton(e.toLabel())).toList(),
              onChanged: (e) => setState(() => _currentIndex = e),
            ),
          ),
          me.location.shops.ordered(orders[_currentIndex]).toWidgetGrid(
                context: context,
                order: orders[_currentIndex],
              ),
        ],
      ),
    );
  }
}
