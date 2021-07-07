import 'package:baedalgeek/models/notice.dart';
import 'package:baedalgeek/models/shop.dart';
import 'package:baedalgeek/models/user.dart';
import 'package:baedalgeek/pages/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 주문내역 화면
///
class OrdersPageGenerator with BasePageGenerator {
  const OrdersPageGenerator();

  @override
  Icon get icon => Icon(Icons.card_membership);

  @override
  String get label => '주문내역';

  @override
  Widget createWidget({
    required UserMe me,
    required NoticeList notices,
  }) {
    return OrdersPage(me);
  }
}

class OrdersPage extends StatefulWidget {
  final UserMe me;

  OrdersPage(this.me);

  @override
  State createState() => _State(me);
}

class _State extends State {
  final UserMe me;
  final List<ShopOrder> orders = ShopOrderExtension.all();

  _State(this.me);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.help,
              color: Colors.pink[100],
            ),
            onPressed: showHelp,
          ),
        ],
        title: Text('주문내역'),
      ),
      body: me.orders.toWidget(
        context: context,
      ),
    );
  }

  /// 도움말을 보여줍니다.
  void showHelp() {
    print('도움말 보여주기');
  }
}
