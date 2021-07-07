import 'package:baedalgeek/models/base.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

/// 상단 배너 모델
///
class BannerInfo extends BaseModel {
  /// 이미지
  final List<String> imageUrls;

  const BannerInfo({required this.imageUrls});

  /// 썸네일
  String get thumbnailUrl => imageUrls.first;

  /// 모든 이미지 보기
  void showDetail(BuildContext context) {
    if (imageUrls.length <= 1) {
      return;
    }

    // TODO: to be implemented
    throw new UnimplementedError();
  }
}

class BannerList extends BaseModel {
  final List<BannerInfo> inner;

  const BannerList({
    required this.inner,
  });

  Widget toWidget({
    required BuildContext context,
  }) {
    return CarouselSlider(
      items: inner
          .map(
            (e) => InkWell(
              onTap: () => e.showDetail(context),
              child: SizedBox.expand(
                child: Image.network(
                  e.thumbnailUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        height: 160,
        autoPlay: true,
        viewportFraction: 1.0,
      ),
    );
  }
}
