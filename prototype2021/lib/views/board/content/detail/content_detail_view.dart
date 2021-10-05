import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prototype2021/handler/board/plan/plan_make_calendar_handler.dart';
import 'package:prototype2021/model/board/contents/content_detail.dart';
import 'package:prototype2021/loader/board/contents_loader.dart';
import 'package:prototype2021/handler/event/event_article_handler.dart';
import 'package:prototype2021/handler/user/user_info_handler.dart';
import 'package:prototype2021/model/board/place_data_props.dart';
import 'package:prototype2021/views/board/base/board.dart';
import 'package:prototype2021/views/board/content/detail/mixin/body.dart';
import 'package:prototype2021/views/board/content/detail/mixin/body_event.dart';
import 'package:prototype2021/views/board/content/detail/mixin/header.dart';
import 'package:prototype2021/views/board/content/detail/mixin/helpers.dart';
import 'package:prototype2021/views/board/plan/make/plan_make_view.dart';
import 'package:prototype2021/views/board/plan/make/select/plan_make_select_view.dart';
import 'package:prototype2021/widgets/buttons/heart_button.dart';
import 'package:prototype2021/widgets/buttons/tb_rounded_text_button.dart';
import 'package:prototype2021/widgets/notices/center_notice.dart';
import 'package:prototype2021/widgets/notices/loading.dart';
import 'package:prototype2021/views/event/main/event_main_view.dart';
import 'package:provider/provider.dart';

int _testCid = 128022;

enum ContentsDetailMode {
  /// 디폴트 [ContentsDetail] 모드입니다
  board,

  /// [PlanMakeView] 에 쓰이는 모드입니다
  planMake
}

class ContentDetailView extends StatefulWidget {
  final int id;
  final ContentsDetailMode mode;
  ContentDetailView({required this.id, this.mode = ContentsDetailMode.board});

  @override
  ContentDetailViewState createState() => ContentDetailViewState();
}

class ContentDetailViewState extends State<ContentDetailView>
    with
        ContentsLoader,
        ContentDetailViewHeaderMixin,
        ContentsDetailViewBodyMixin,
        ContentDetailViewEventMixin,
        ContentDetailViewHelpers {
  double imageIndex = 0;
  bool isAllList = false;
  bool onError = false;

  ContentsDetail? props;
  void setProps(ContentsDetail _props) => setState(() {
        props = _props;
      });
  void setOnError(bool _onError) => setState(() {
        onError = _onError;
      });

  Future<void> fetchDetail() async {
    try {
      UserInfoHandler model =
          Provider.of<UserInfoHandler>(context, listen: false);
      setProps(await getContentDetail(widget.id, model.token!));
      setOnError(false);
    } catch (error) {
      print(error);
      setOnError(true);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDetail();
  }

  @override
  Widget build(BuildContext context) {
    if (onError) {
      return buildError();
    }
    if (props == null) {
      return Container(
        child: LoadingIndicator(),
        decoration: new BoxDecoration(color: Colors.white),
      );
    }
    return buildPage();
  }

  Container buildError() {
    return Container(
      child: CenterNotice(
        text: "컨텐츠를 불러오는 중 오류가 발생했습니다. 다시 시도해주세요",
        actionText: "다시 시도",
        onActionPressed: fetchDetail,
      ),
      decoration: const BoxDecoration(color: Colors.white),
    );
  }

  Container? buildBottomNavigationBar() {
    if (widget.mode == ContentsDetailMode.planMake) {
      if (props == null) {
        return Container(
          height: 60,
          child: CenterNotice(text: '로딩중...'),
        );
      }
      UserInfoHandler userInfoHandler =
          Provider.of<UserInfoHandler>(context, listen: false);
      PlanMakeCalendarHandler calendarHandler =
          Provider.of<PlanMakeCalendarHandler>(context);
      PlanMakeSelectView? parent =
          context.findAncestorWidgetOfExactType<PlanMakeSelectView>();
      void onAddToPlanPressed() {
        if (props != null) {
          calendarHandler.addPlaceData(
            calendarHandler.currentIndex,
            PlaceDataProps.fromContentsDetail(source: props!),
          );
        }
        if (parent != null) {
          parent.navigator(Navigate.backward);
        }
      }

      return Container(
        height: 60,
        alignment: Alignment.center,
        child: Row(children: [
          Flexible(
            child: HeartButton(
              isHeartSelected: props!.hearted,
              heartFor: HeartFor.contentCard,
              dataId: props!.id,
              token: userInfoHandler.token ?? "",
              userId: userInfoHandler.userId ?? -1,
            ),
            flex: 1,
          ),
          Flexible(
              child: Container(
            child: TBRoundedTextButton(
                text: "내 일정에 담기", onPressed: onAddToPlanPressed),
            padding: const EdgeInsets.symmetric(horizontal: 10),
          )),
        ]),
      );
    }
    return null;
  }

  Scaffold buildPage() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
            child: ChangeNotifierProvider(
          create: (context) => EventArticleHandler.main(),
          child: Consumer(
              builder: (context, EventArticleHandler eventArticleModel, child) {
            void onImageChanged(int i, CarouselPageChangedReason reason) {
              setState(() {
                imageIndex = i.toDouble();
              });
            }

            void onEventNavButtonPressed() {
              if (!isAllList) {
                setState(() {
                  isAllList = true;
                });
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventMainView()),
                );
                // TODO: next page
              }
            }

            if (props == null) {
              return SizedBox();
            }

            return Column(
              children: [
                buildHeadSection(
                  context,
                  onPageChanged: onImageChanged,
                  imageIndex: imageIndex,
                  props: props!,
                ),
                buildLineArea(),
                buildTextArea(props!),
                buildLineArea(),
                buildPriceArea(props!),
                buildLineArea(),
                buildTimeArea(props!),
                buildLineArea(),
                buildLocationArea(props!),
                buildLineArea(),
                // 이벤트와 관련한 위젯을 theme/board/contents_detail/body_event.dart에 옮겨두었습니다
                buildEventArea(
                  context,
                  eventArticleModel,
                ),
                buildEventArticles(
                  context,
                  eventArticleModel,
                ),
                buildEventNavigatorButton(
                  context,
                  onPressed: onEventNavButtonPressed,
                ),
              ],
            );
          }),
        )),
      ),
    );
  }
}
