import 'package:baedalgeek/models/banner.dart';
import 'package:baedalgeek/models/coupon.dart';
import 'package:baedalgeek/models/date.dart';
import 'package:baedalgeek/models/food.dart';
import 'package:baedalgeek/models/location.dart';
import 'package:baedalgeek/models/membership_shop.dart';
import 'package:baedalgeek/models/notice.dart';
import 'package:baedalgeek/models/order.dart';
import 'package:baedalgeek/models/rating.dart';
import 'package:baedalgeek/models/review.dart';
import 'package:baedalgeek/models/shop.dart';
import 'package:baedalgeek/models/user.dart';
import 'package:baedalgeek/pages/base.dart';
import 'package:baedalgeek/pages/main/home.dart';
import 'package:baedalgeek/pages/main/orders.dart';
import 'package:baedalgeek/pages/main/shops.dart';
import 'package:baedalgeek/pages/main/mybaedal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 앱의 메인 화면
///
class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State {
  final List<BasePageGenerator> _widgets = [
    HomePageGenerator(),
    ShopsPageGenerator(),
    OrdersPageGenerator(),
    MyBaedalPageGenerator(),

  ];

  UserMe me = UserMe(
    inner: User(
      nickname: '사용자',
    ),
    id: 'my-id@id.com',
    name: '홍길동',
    type: UserType.Kakao,
    location: DeliveryLocation(
      name: '광주과학기술원',
      address: '광주 북구 오룡동 1',
      spots: ['대학원기숙사(8동)'],
      orderTimes: OrderTimeList(
        inner: [
          OrderTime(
            timeLabel: '점심1',
            orderTime: TimeOfDay(hour: 11, minute: 0),
            deliveryTimeBegin: TimeOfDay(hour: 12, minute: 10),
            deliveryTimeEnd: TimeOfDay(hour: 12, minute: 40),
          ),
          OrderTime(
            timeLabel: '저녁1',
            orderTime: TimeOfDay(hour: 17, minute: 0),
            deliveryTimeBegin: TimeOfDay(hour: 18, minute: 10),
            deliveryTimeEnd: TimeOfDay(hour: 18, minute: 40),
          ),
        ],
      ),
      shops: ShopList(
        inner: [
          Shop(
            name: '마선생 마약국밥 광주첨단점',
            imageUrl:
                'http://travel.chosun.com/site/data/img_dir/2011/07/11/2011071101128_0.jpg',
            deliveryCost: 3000,
            isNew: true,
            reviews: ReviewList(
              inner: [
                Review(
                  user: User(
                    nickname: '감자리아',
                  ),
                  foods: FoodList(
                    inner: [],
                  ),
                  scoreTaste: 5.0,
                  scoreQuantity: 4.0,
                  scoreCondition: 4.0,
                  desc: '맛있습니다',
                  response: '감사합니다',
                  dateCreated: DateTime(2021, 5, 20),
                  numLikes: 5,
                  userLike: false,
                ),
              ],
            ),
            discountRate: 0.1,
            orderTime: TimeOfDay(hour: 10, minute: 40),
            foods: FoodList(
              inner: [
                Food(
                  name: '돼지찌개정식',
                  shopName: '마선생 마약국밥 광주첨단점',
                  desc: '공기밥 + 찌개(반찬 및 물.음료 미포함)',
                  imageUrl:
                      'https://recipe1.ezmember.co.kr/cache/recipe/2018/08/07/3bb8e32ea170ebf850a9bb31aa23e1121.jpg',
                  cost: 7000,
                  deliveryCost: 3000,
                  rating: Rating(
                    score: 5.8,
                    count: 265,
                  ),
                  options: FoodOptionMap(inner: []),
                  reorderRate: 0.66,
                  numLastWeek: 71,
                  numUser: 50,
                  lastDate: DateTime(2021, 5, 23, 19, 80),
                ),
              ],
            ),
            numUser: 50,
          ),
          Shop(
            name: '마선생 마약국밥 광주첨단점 2',
            imageUrl:
                'http://travel.chosun.com/site/data/img_dir/2011/07/11/2011071101128_0.jpg',
            deliveryCost: 4000,
            isNew: true,
            reviews: ReviewList(
              inner: [],
            ),
            discountRate: 0,
            orderTime: TimeOfDay(hour: 10, minute: 40),
            foods: FoodList(
              inner: [
                Food(
                  name: '돼지찌개정식 2',
                  shopName: '마선생 마약국밥 광주첨단점',
                  desc: '공기밥 + 찌개(반찬 및 물.음료 미포함)',
                  imageUrl:
                      'https://recipe1.ezmember.co.kr/cache/recipe/2018/08/07/3bb8e32ea170ebf850a9bb31aa23e1121.jpg',
                  cost: 7000,
                  deliveryCost: 4000,
                  rating: Rating(
                    score: 5.8,
                    count: 265,
                  ),
                  options: FoodOptionMap(inner: []),
                  reorderRate: 0.33,
                  numLastWeek: 50,
                  numUser: 3,
                  lastDate: DateTime(2021, 5, 20, 19, 80),
                )
              ],
            ),
            numUser: 500,
          ),
          Shop(
            name: '마선생 마약국밥 광주첨단점 3',
            imageUrl:
                'http://travel.chosun.com/site/data/img_dir/2011/07/11/2011071101128_0.jpg',
            deliveryCost: 5000,
            isNew: true,
            reviews: ReviewList(
              inner: [],
            ),
            discountRate: 0,
            orderTime: TimeOfDay(hour: 10, minute: 40),
            foods: FoodList(
              inner: [
                Food(
                  name: '돼지찌개정식 3',
                  shopName: '마선생 마약국밥 광주첨단점',
                  desc: '공기밥 + 찌개(반찬 및 물.음료 미포함)',
                  imageUrl:
                      'https://recipe1.ezmember.co.kr/cache/recipe/2018/08/07/3bb8e32ea170ebf850a9bb31aa23e1121.jpg',
                  cost: 7000,
                  deliveryCost: 5000,
                  rating: Rating(
                    score: 5.8,
                    count: 265,
                  ),
                  options: FoodOptionMap(inner: []),
                  reorderRate: 0,
                  numLastWeek: 0,
                  numUser: 0,
                  lastDate: null,
                )
              ],
            ),
            numUser: 5000,
          ),
        ],
      ),
      membership: MembershipLocation(
        name: 'GIST',
        desc: '지스트 회원 2786명이라면 누구나!',
        shops: MembershipShopList(
          inner: [
            MembershipShop(
              name: '달콤',
              desc: '전 메뉴 10% 할인(~12월 31일까지)',
              imageUrl:
                  'https://everipedia-storage.s3.amazonaws.com/ProfilePics/%EB%A7%88%EC%B9%B4%EB%A1%B1-macaron__50670.png',
              rating: Rating(
                score: 4.6,
                count: 67,
              ),
              orderTime: DateTime(
                2021,
                5,
                28,
                11,
                0,
              ),
            ),
            MembershipShop(
              name: '달콤',
              desc: '전 메뉴 10% 할인(~12월 31일까지)',
              imageUrl:
                  'https://everipedia-storage.s3.amazonaws.com/ProfilePics/%EB%A7%88%EC%B9%B4%EB%A1%B1-macaron__50670.png',
              rating: Rating(
                score: 4.6,
                count: 67,
              ),
              orderTime: DateTime(
                2021,
                5,
                28,
                11,
                0,
              ),
            ),
          ],
        ),
      ),
      banners: BannerList(
        inner: [
          BannerInfo(
            imageUrls: [
              'https://i1.wp.com/blog.jandi.com/ko/wp-content/uploads/sites/4/2018/09/180907_13.jpg?resize=750%2C426',
            ],
          ),
        ],
      ),
    ),
    orders: OrderList(
      inner: [
        Order(
          foods: OrderFoodList(
            inner: [
              OrderFood(
                food: Food(
                  name: '돼지찌개정식',
                  shopName: '마선생 마약국밥 광주첨단점',
                  desc: '공기밥 + 찌개(반찬 및 물.음료 미포함)',
                  imageUrl:
                      'https://recipe1.ezmember.co.kr/cache/recipe/2018/08/07/3bb8e32ea170ebf850a9bb31aa23e1121.jpg',
                  cost: 7000,
                  deliveryCost: 3000,
                  rating: Rating(
                    score: 5.8,
                    count: 265,
                  ),
                  options: FoodOptionMap(inner: [
                    FoodOptionList(
                      label: '숙주선택',
                      options: [
                        FoodOption(
                          name: '숙주 없이',
                          cost: 0,
                          isSelected: false,
                        ),
                        FoodOption(
                          name: '숙주 있기',
                          cost: 500,
                          isSelected: true,
                        ),
                      ],
                      isRequired: true,
                    ),
                    FoodOptionList(
                      label: '양파선택',
                      options: [
                        FoodOption(
                          name: '양파 없이',
                          cost: 0,
                          isSelected: false,
                        ),
                        FoodOption(
                          name: '양파 있기',
                          cost: 500,
                          isSelected: true,
                        ),
                      ],
                      isRequired: true,
                    ),
                    FoodOptionList(
                      label: '토핑 3가지 선택',
                      options: [
                        FoodOption(
                          name: '노른자',
                          cost: 0,
                          isSelected: true,
                        ),
                        FoodOption(
                          name: '생와사비',
                          cost: 0,
                          isSelected: true,
                        ),
                        FoodOption(
                          name: '마늘 후레이크',
                          cost: 0,
                          isSelected: true,
                        ),
                      ],
                      isRequired: false,
                    ),
                  ]),
                  reorderRate: 0.66,
                  numLastWeek: 71,
                  numUser: 50,
                  lastDate: DateTime(2021, 5, 23, 19, 80),
                ),
                dateTime: OrderDateTime(
                  timeLabel: '저녁1',
                  orderTime: DateTime(2021, 05, 28, 17, 0),
                  deliveryTimeBegin: DateTime(2021, 05, 28, 18, 10),
                  deliveryTimeEnd: DateTime(2021, 05, 28, 18, 40),
                ),
                spot: '대학원기숙사(8동)',
                deliveryId: '카A6',
                review: null,
              ),
              OrderFood(
                food: Food(
                  name: '돼지찌개정식',
                  shopName: '마선생 마약국밥 광주첨단점',
                  desc: '공기밥 + 찌개(반찬 및 물.음료 미포함)',
                  imageUrl:
                      'https://recipe1.ezmember.co.kr/cache/recipe/2018/08/07/3bb8e32ea170ebf850a9bb31aa23e1121.jpg',
                  cost: 7000,
                  deliveryCost: 3000,
                  rating: Rating(
                    score: 5.8,
                    count: 265,
                  ),
                  options: FoodOptionMap(inner: []),
                  reorderRate: 0.66,
                  numLastWeek: 71,
                  numUser: 50,
                  lastDate: DateTime(2021, 5, 23, 19, 80),
                ),
                dateTime: OrderDateTime(
                  timeLabel: '저녁1',
                  orderTime: DateTime(2021, 05, 28, 17, 0),
                  deliveryTimeBegin: DateTime(2021, 05, 28, 18, 10),
                  deliveryTimeEnd: DateTime(2021, 05, 28, 18, 40),
                ),
                spot: '대학원기숙사(8동)',
                deliveryId: '카A4',
                review: null,
              ),
            ],
          ),
          orderDate: DateTime(2021, 5, 28, 15, 28),
        ),
      ],
    ),
    geekMoney: 3000,
    geekPoints: 5000,
    savedDeliveryCost: 129000,
    coupons: CouponList(
      inner: [
        Coupon(),
      ],
    ),
    event: UserEvent(
      numFriends: 0,
    ),
  );

  NoticeList notices = NoticeList(
    inner: [
      Notice(
        title: '긱머니 충전서비스 안내',
        imageUrls: [
          'https://www.renthome.go.kr/resources/images/pop_0717s.jpg',
        ],
      ),
      Notice(
        title: '배달긱 서비스 안내',
        imageUrls: [
          'https://www.renthome.go.kr/resources/images/pop_0717s.jpg',
        ],
      ),
      Notice(
        title: '배달긱 회원가입 혜택 안내',
        imageUrls: [
          'https://www.renthome.go.kr/resources/images/pop_0717s.jpg',
        ],
      ),
    ],
  );

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgets[_currentIndex].createWidget(
        me: me,
        notices: notices,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _widgets.map((e) => e.bottomNavigationBarItem()).toList(),
        onTap: (e) => setState(() => _currentIndex = e),
      ),
    );
  }
}
