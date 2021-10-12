import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/entity/homeAdvInfo.dart';
import 'package:homary/pages/home/components/homeItem/components/AdCard.dart';

class RoomAd extends StatefulWidget {
  final AdvDatum data;
  RoomAd({Key key, @required this.data}) : super(key: key);

  @override
  _RoomAdState createState() => _RoomAdState();
}

class _RoomAdState extends State<RoomAd> {
  final ScrollController _scrollController = ScrollController();
  double width = 330.w;
  int scrollIndex = 1;

  _handleScroll() {
    int currentIndex = (_scrollController.offset / width).ceil();
    if (currentIndex == scrollIndex) {
      return;
    }
    setState(() {
      scrollIndex = currentIndex == 0 ? 1 : currentIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_handleScroll);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: widget.data != null &&
                widget.data.moduleData != null &&
                widget.data.moduleData.length > 0
            ? Padding(
                padding: EdgeInsets.fromLTRB(12.w, 28.w, 12.w, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: 0.76.sw,
                            child: Text(widget.data.title ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.primaryText)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            sendGTMData({
                              "event": 'custom_click_ads',
                              "ecommerce": {
                                "event_label":
                                    widget.data.positionJumpUrlEventLabel ?? ''
                              }
                            });
                            handleSchema(context, widget.data.positionJumpUrl);
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 12.w,
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: '$scrollIndex',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.primaryText)),
                                TextSpan(
                                    text: '/${widget.data.moduleData.length}',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColor.primaryText))
                              ])),
                              SizedBox(
                                width: 12.w,
                              ),
                              Offstage(
                                offstage: widget.data.positionJumpUrl == null ||
                                    widget.data.positionJumpUrl == '',
                                child: Row(
                                  children: [
                                    Text(
                                      S.of(context).more,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: AppColor.primaryText),
                                    ),
                                    Icon(
                                      Iconfont.ArrowRight,
                                      size: 12.w,
                                      color: AppColor.primaryText,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 216.w,
                      margin: EdgeInsets.fromLTRB(0, 16.w, 0, 0),
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (BuildContext ctx, int index) {
                          return AdCard(
                            width: 330.w,
                            imageHeight: 180.w,
                            textHeight: 36.w,
                            adImageUrl: widget.data.moduleData[index].imgUrl,
                            adText: widget.data.moduleData[index].title,
                            jumpUrl: widget.data.moduleData[index].jumpUrl,
                            eventLabel:
                                widget.data.moduleData[index].eventLabel,
                            isLastCard:
                                index == widget.data.moduleData.length - 1,
                          );
                        },
                        itemCount: widget.data.moduleData.length,
                      ),
                    ),
                  ],
                ))
            : Container());
  }
}
