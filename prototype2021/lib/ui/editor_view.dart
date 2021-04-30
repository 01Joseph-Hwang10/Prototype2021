import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype2021/theme/checkbox_row.dart';
import 'package:prototype2021/theme/datetimepicker_column.dart';
import 'package:prototype2021/theme/checkbox_widget.dart';
import 'package:prototype2021/settings/constants.dart';

class EditorView extends StatefulWidget {
  @override
  _EditorViewState createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  List<bool> isCheckedButton = [true, false]; //initialize state as 동행찾기
  DateTime? chosenDateTime1;
  DateTime? chosenDateTime2;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
            20.0 * pt, 30.0 * pt, 20.0 * pt, 20.0 * pt),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  CloseButton(
                    color: Colors.black,
                    onPressed: () {},
                  ),
                  Text(
                    '글 쓰기',
                    style: TextStyle(
                        fontSize: 14 * pt, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey, // background
                      onPrimary: Colors.black, // foreground
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Column(
                                children: [
                                  Text('임시저장'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: [
                                    Container(
                                      width: 291 * pt,
                                      height: 250 * pt,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("임시 저장하시겠습니까?",
                                              style:
                                                  TextStyle(fontSize: 17 * pt)),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text('임시 저장한 글은',
                                              style: TextStyle(
                                                fontSize: 14 * pt,
                                              )),
                                          Text('\'내 정보 > 임시 저장한 글\'',
                                              style: TextStyle(
                                                  fontSize: 14 * pt,
                                                  fontWeight: FontWeight.bold)),
                                          Text('에서 볼 수 있어요.',
                                              style:
                                                  TextStyle(fontSize: 14 * pt))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 45.5 * pt,
                                      width: 60 * pt,
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            '취소',
                                            style: TextStyle(fontSize: 13 * pt),
                                          )),
                                    ),
                                    Container(
                                      height: 45.5 * pt,
                                      width: 60 * pt,
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            '확인',
                                            style: TextStyle(fontSize: 13 * pt),
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            );
                          });
                    },
                    child: Text('임시저장',
                        style: TextStyle(
                            fontSize: 13 * pt, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: 10 * pt,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {},
                    child: Text('등록',
                        style: TextStyle(
                            fontSize: 13 * pt, fontWeight: FontWeight.bold)),
                  )
                ],
              )
            ]),
            SizedBox(
              height: 23 * pt,
            ),
            Row(
              children: [
                OutlinedButton(
                  style: ButtonStyle(side:
                      MaterialStateProperty.resolveWith<BorderSide>(
                          (Set<MaterialState> states) {
                    final Color color =
                        isCheckedButton[0] ? Colors.blue : Colors.grey;
                    return BorderSide(color: color, width: 2);
                  })),
                  onPressed: () {
                    setState(() {
                      isCheckedButton[1] = false;
                      isCheckedButton[0] = true;
                    });
                  },
                  child: Text(
                    "내 주변 이벤트",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12 * pt,
                      color:
                          isCheckedButton[0] ? Colors.blue[300] : Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12 * pt,
                ),
                OutlinedButton(
                  style: ButtonStyle(side:
                      MaterialStateProperty.resolveWith<BorderSide>(
                          (Set<MaterialState> states) {
                    final Color color =
                        isCheckedButton[1] ? Colors.blue : Colors.grey;
                    return BorderSide(color: color, width: 2);
                  })),
                  onPressed: () {
                    setState(() {
                      isCheckedButton[1] = true;
                      isCheckedButton[0] = false;
                    });
                  },
                  child: Text(
                    "동행 찾기",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12 * pt,
                      color:
                          isCheckedButton[1] ? Colors.blue[300] : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16 * pt,
            ),
            Container(height: 1, width: 500, color: Colors.grey),
            Container(
              height: 61 * pt,
              child: TextField(
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    hintText: '제목'),
              ),
            ),
            Container(height: 1, width: 500, color: Colors.grey),
            Container(
              alignment: FractionalOffset.topLeft,
              height: 200 * pt,
              width: 500,
              color: Colors.white,
              child: TextField(
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    hintText: '내용을 입력하세요.'),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ),
            Container(height: 1, width: 500, color: Colors.grey),
            Column(
              children: [
                CheckboxRow(
                    value1: _isChecked1,
                    onChanged1: (bool? value) {
                      setState(() {
                        _isChecked1 = value == null ? false : value;
                      });
                    },
                    value2: _isChecked2,
                    onChanged2: (bool? value) {
                      setState(() {
                        _isChecked2 = value == null ? false : value;
                      });
                    }),
                CheckBoxWidget(_isChecked1, _isChecked2),
                //   DateTimePickerCol(chosenDateTime1) TODO: implement DateTimePicker
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
