import 'package:flutter/material.dart';
import 'package:prototype2021/settings/constants.dart';
import 'package:prototype2021/theme/heart_button.dart';

class CardBaseProps {
  final String preview;
  final String title;
  final String place;
  final List<String> tags;

  CardBaseProps({
    required this.preview,
    required this.title,
    required this.place,
    required this.tags,
  });
}

class CardBase {
  Container buildCard({
    required Widget itemInfo,
    required Color backgroundColor,
    required String preview,
    required int dataId,
    required int userId,
    bool isHeartSelected = false,
    required HeartFor heartFor,
  }) {
    return Container(
        padding: EdgeInsets.all(10 * pt),
        height: 160 * pt,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: Color(0xffe8e8e8),
            width: 0.5,
          ),
        ),
        child: Row(children: <Widget>[
          SizedBox(width: 15),
          itemInfo,
          buildW(15 * pt),
          buildPreview(
            preview,
            isHeartSelected: isHeartSelected,
            dataId: dataId,
            userId: userId,
            heartFor: heartFor,
          )
        ]));
  }

  /* 
   * Build horizontal spacing with SizedBox
  */
  SizedBox buildW(double gap) {
    return SizedBox(
      width: gap,
    );
  }

  /* 
   * Build vertical spacing with SizedBox
  */
  SizedBox buildH(double gap) {
    return SizedBox(
      height: gap,
    );
  }

  Text buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15 * pt,
        color: Color(0xff444444),
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
      ),
      textWidthBasis: TextWidthBasis.parent,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  Text buildPlace(String place) {
    return Text(
      place,
      style: TextStyle(
        color: Color(0xff555555),
        fontSize: 10 * pt,
        fontFamily: 'Roboto',
      ),
    );
  }

  Widget buildTags(List<String> tags) {
    return Wrap(
      children: _generateTags(tags),
      direction: Axis.horizontal,
    );
  }

  List<Container> _generateTags(List<String> tags) {
    // 태그 박스 구현 코드
    return List<Container>.generate(
      tags.length,
      (index) => Container(
        padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black.withOpacity(0.1), width: 1)),
        child: Text(
          tags[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: const Color(0xff707070),
          ),
        ),
      ),
    );
  }

  ClipRRect buildPreview(
    String preview, {
    required HeartFor heartFor,
    bool isHeartSelected = false,
    required int dataId,
    required int userId,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(9.0)),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            width: 100 * pt,
            height: 120 * pt,
            color: Colors.black,
            child: Image.network(
              preview,
              fit: BoxFit.cover,
            ),
          ),
          HeartButton(
              isHeartSelected: isHeartSelected,
              heartFor: heartFor,
              dataId: dataId,
              userId: userId),
        ],
      ),
    );
  }
}
