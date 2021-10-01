import 'package:flutter/material.dart';
import 'package:prototype2021/data/place_data_props.dart';
import 'package:prototype2021/model/plan/plan_make_calendar_model.dart';
import 'package:prototype2021/theme/calendar/plan_list_item/helper.dart';
import 'package:prototype2021/theme/tb_distance_icon.dart';
import 'package:prototype2021/ui/plan_make_home_view.dart';
import 'package:prototype2021/theme/calendar/plan_make_home/constants.dart';
import 'package:provider/provider.dart';

class PlanListMiddleDivider extends StatelessWidget with PlanListItemHelper {
  final num? distance;
  final Key? key;
  final int index;
  final int dateIndex;

  PlanListMiddleDivider(
      {required this.distance,
      required this.index,
      required this.dateIndex,
      this.key});

  @override
  Widget build(BuildContext context) {
    PlanMakeHomeViewState? grandParent =
        context.findAncestorStateOfType<PlanMakeHomeViewState>();
    PlanMakeMode mode = grandParent?.mode ?? PlanMakeMode.add;
    switch (mode) {
      case PlanMakeMode.add:
        return distance is num ? buildDistanceIcon() : buildPlaceholder();
      case PlanMakeMode.edit:
        return buildPasteIcon(context);
      default:
        return buildPlaceholder();
    }
  }

  SizedBox buildPlaceholder() {
    return SizedBox(
      key: key,
      height: 27,
    );
  }

  SizedBox buildPasteIcon(BuildContext context) {
    PlanMakeHomeViewState? grandParent =
        context.findAncestorStateOfType<PlanMakeHomeViewState>();
    bool onDrag = grandParent?.onDrag ?? false;
    PlanMakeCalendarModel? calendarHandler;
    try {
      calendarHandler = Provider.of<PlanMakeCalendarModel>(context);
    } catch (e) {
      calendarHandler = null;
    }
    void pasteData() {
      PlaceDataProps? data = grandParent?.copiedData;
      if (data != null && calendarHandler != null) {
        int indexToInsert = (index + 1) ~/ 2;
        grandParent?.insertCopiedData(
            calendarHandler, dateIndex, data, indexToInsert);
        grandParent?.setCopiedData(null, null);
      }
    }

    return SizedBox(
      key: key,
      height: 27,
      child: Center(
        child: TextButton(
          onPressed: onDrag ? null : pasteData,
          child: Text(onDrag ? "" : "붙여넣기",
              style: const TextStyle(
                  color: const Color(0xff707070),
                  fontWeight: FontWeight.w700,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontSize: 9.0),
              textAlign: TextAlign.center),
        ),
      ),
    );
  }

  Widget buildDistanceIcon() {
    return TBDistanceIcon(distance: distance as num);
  }
}
