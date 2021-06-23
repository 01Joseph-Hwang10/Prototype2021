import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prototype2021/settings/constants.dart';

const COMPANION = false;
const EVENT = true;

class EditorModel with ChangeNotifier {
  String title = "";
  String content = "";
  bool hasAge = false;
  bool hasGender = false;
  bool articleType = EVENT;
  String recruitNumber = '0';
  String maleRecruitNumber = '0';
  String femaleRecruitNumber = '0';
  String startAge = '0';
  String endAge = '0';
  int? pid;
  int? cid;
  int uid = 0;
  LatLng coord = LatLng(0, 0);

  EditorModel();

  void printChanged() {}

  Future<bool> writeArticle() async {
    Map<String, dynamic> originData = {
      "uid": 1,
      "title": this.title,
      "body": this.content,
      "recruits": {
        "no": this.recruitNumber,
        "male": this.maleRecruitNumber,
        "female": this.femaleRecruitNumber
      },
      "ages": {"min": this.startAge, "max": this.endAge},
      "period": {
        "start": "2021-05-23T09:22:23.150Z",
        "end": "2021-05-23T09:22:23.150Z"
      },
      "pid": null
    };
    var url;
    if (this.articleType == COMPANION) {
      originData["pid"] = this.pid;
      url = Uri.parse(ENROL_RECRUITMENTS_COMPANION_API);
    } else if (this.articleType == EVENT) {
      originData["coord"] = {
        "lat": this.coord.latitude.toString(),
        "long": this.coord.longitude.toString()
      };
      originData["cid"] = this.cid;
      url = Uri.parse(ENROL_RECRUITMENTS_EVENT_API);
    }
    try {
      var response = await http.post(url,
          headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
            "X-CSRFToken":
                "ZrWI7Mf1KMz2WYJjQqo3H30l25UdY4bPcP3RthSlRMoUj7hGxz5Vp6fBWKS0n235"
          },
          body: jsonEncode(originData));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201) return true;
    } catch (e) {
      print("Unexpected Error occurred");
    }
    return false;
  }
}
