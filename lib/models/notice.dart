import 'package:baedalgeek/models/base.dart';
import 'package:flutter/material.dart';

/// 공지사항 모델
class Notice extends BaseModel {
  /// 제목
  final String title;

  /// 이미지
  final List<String> imageUrls;

  const Notice({
    required this.title,
    required this.imageUrls,
  });

  Widget toWidgetContent({
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () => showDetail(context),
      child: Container(
        height: 40,
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
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                '공지사항',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 14),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDetail(BuildContext context) {}
}

class NoticeList extends BaseModel {
  final List<Notice> inner;

  const NoticeList({
    required this.inner,
  });

  Widget toWidget({
    required BuildContext context,
  }) {
    return Column(
      children: inner
          .map((e) => e.toWidgetContent(
                context: context,
              ))
          .toList(),
    );
  }
}
