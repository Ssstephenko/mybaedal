import 'package:baedalgeek/models/base.dart';
import 'package:baedalgeek/widgets/card.dart';
import 'package:flutter/material.dart';

/// 회사 정보 모델
///
class CompanyInfo extends BaseModel {
  /// 사명
  final String name = '(주)클라우드스톤';

  /// 법적 고지
  final String legalNotice = '클라우드스톤은 통신...\n클라우드스톤은 상품...';

  const CompanyInfo();

  Widget toWidget({
    required BuildContext context,
  }) {
    final toCardButtonText = (String text) {
      return Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),
      );
    };

    final textButtonStyle = TextStyle(
      color: Colors.grey,
      fontSize: 11,
    );
    final textBar = Text(
      '|',
      style: textButtonStyle,
    );
    final toTextButton = ({
      required String text,
      required VoidCallback onPressed,
    }) {
      return InkWell(
        onTap: onPressed,
        child: Text(
          text,
          style: textButtonStyle,
        ),
      );
    };

    return Container(
      height: 170,
      color: Colors.grey[350],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              toCardButton(
                icon: Icons.call,
                title: toCardButtonText('고객센터 전화하기'),
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                onPressed: () => call(),
              ),
              toCardButton(
                icon: Icons.call,
                title: toCardButtonText('카카오톡 문의하기'),
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                onPressed: () => call(),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            padding: EdgeInsets.only(
              top: 8,
              bottom: 8,
              left: 12,
              right: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                toTextButton(
                  text: '사업자번호확인',
                  onPressed: () => showDetail(context),
                ),
                textBar,
                toTextButton(
                  text: '이용약관',
                  onPressed: () => showTermsService(context),
                ),
                textBar,
                toTextButton(
                  text: '전자금융거래 이용약관',
                  onPressed: () => showTermsTransaction(context),
                ),
                textBar,
                toTextButton(
                  text: '개인정보 처리방침',
                  onPressed: () => showPrivacyPolicy(context),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      legalNotice,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 사업자번호확인
  void showDetail(BuildContext context) {}

  // 이용약관
  void showTermsService(BuildContext context) {}

  // 전자금융거래 이용약관
  void showTermsTransaction(BuildContext context) {}

  // 개인정보 처리방침
  void showPrivacyPolicy(BuildContext context) {}

  // 고객센터 전화하기
  void call() {}

  // 카카오톡 문의하기
  void kakao() {}
}
