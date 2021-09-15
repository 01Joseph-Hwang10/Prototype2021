import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/cards/contents_card_base.dart';
import 'package:prototype2021/theme/cards/product_card_base.dart';

mixin BoardMainViewHelpers {
  /* 
   * These functions simulates the api call
  */
  Future<List<ProductCardBaseProps>> getPseudoPlanData(
      [void Function(bool)? setHeartSelected, bool? heartSelected]) async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(
        20,
        (index) => new ProductCardBaseProps(
              preview: placeHolder,
              title: "중국 도장깨기",
              place: '상하이(중국), 베이징(중국), 광저우(중국)',
              period: 3,
              costStart: 3,
              costEnd: 5,
              matchPercent: 34,
              tags: ["액티비티", "관광명소", "인생사진"],
              tendencies: [],
              /* 
              * This is temporary implementation. isHeartSelected state should be handled  
              * at the individual ProductCard or ContentsCard level, 
              * not at the root list level(BoardMainView)
              */
              onHeartPreessed: (bool isSelected) => setHeartSelected != null
                  ? setHeartSelected(isSelected)
                  : null,
              isHeartSelected: heartSelected ?? false,
              isGuide: index % 2 == 0,
            ));
  }

  Future<List<ContentsCardBaseProps>> getPseudoContentData(
      [void Function(bool)? setHeartSelected, bool? heartSelected]) async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(
        20,
        (index) => new ContentsCardBaseProps(
              backgroundColor: Colors.white,
              preview: placeHolder,
              title: "울산대공원",
              place: "대한민국, 울산",
              explanation: "다양한 놀이 기구와 운동 시설을 갖춘 도심 공원, 울산대공원'",
              rating: 5,
              ratingNumbers: 34,
              tags: ["액티비티", "관광명소", "인생사진"],
              isHeartSelected: heartSelected ?? false,
              onHeartPreessed: (bool isSelected) => setHeartSelected != null
                  ? setHeartSelected(isSelected)
                  : null,
            ));
  }
}
