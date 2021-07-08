import 'package:baedalgeek/models/notice.dart';
import 'package:baedalgeek/models/shop.dart';
import 'package:baedalgeek/models/user.dart';
import 'package:baedalgeek/pages/base.dart';
import 'package:baedalgeek/models/company.dart';
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
        actions: [
          IconButton(
            icon: Icon(Icons.chevron_left),
            color: Colors.pink[100],
            onPressed: () {},
          ),
        ],
        centerTitle: true,
        title: Text('마이배달긱'),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Image.asset(
                      "assets/drawable/sun.png",
                      height: 45,
                      width: 45,
                    ),
                    flex: 1,
                  ),
                  Container(
                    height: 100.0,
                    child: Column(
                      children: [
                        Text(
                          "UserName ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text("보유 긱머니 : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            )),
                        Text("보유 포인트 : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.chevron_right),
                      color: Colors.pink[100],
                      onPressed: () {},
                    ),
                    flex: 1,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black38,
                    width: 0.3,
                  ),
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: [
                    _gridTile(Icons.ac_unit_outlined, "포인트"),
                    _gridTile(Icons.ac_unit, "긱머니"),
                    _gridTile(Icons.ac_unit, "장바구니"),
                    _gridTile(Icons.ac_unit, "수령장소"),
                    _gridTile(Icons.ac_unit, "주문내역"),
                    _gridTile(Icons.ac_unit, "쿠폰함"),
                    _gridTile(Icons.ac_unit, "초보자 가이드"),
                    _gridTile(Icons.ac_unit, "아낀 배달비 조회"),
                    _gridTile(Icons.ac_unit, "친구추천 이벤트"),
                  ],
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Text("공지사항&이벤트",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                    IconButton(
                      icon: Icon(Icons.chevron_right),
                      color: Colors.pink[100],
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Text("현재버전 2.3.5",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                  ],
                ),
              ),
              Container(
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    // 회사 정보
                    CompanyInfo().toWidget(
                      context: context,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _gridTile(IconData icon, String name) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.black38,
        width: 0.5,
      ),
    ),
    padding: EdgeInsets.all(5),
    child: TextButton(
      onPressed: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 40),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
