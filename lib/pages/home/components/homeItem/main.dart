/*
 * @Author       : JHao
 * @Date         : 2021-07-19 16:50:47
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-06 15:00:23
 */
import 'package:exposure/exposure.dart';
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/generated/l10n.dart';
import 'package:homary/pages/home/components/homeItem/components/RecommendList.dart';
import 'package:homary/pages/home/components/homeItem/components/ad.dart';
import 'package:homary/pages/home/components/homeItem/components/kingkong.dart';
import 'package:homary/pages/home/components/homeItem/components/title.dart';
import 'components/RecommendViewMoreButton.dart';
import 'components/ReviewsList.dart';
import 'components/serviveItems.dart';
import 'components/swiper.dart';
import 'components/GoodsList.dart';

class HomeItem extends StatefulWidget {
  HomeItem({Key key}) : super(key: key);

  @override
  _HomeItemState createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  bool showBackTopButton = false;

  _handleScroll() {
    if (_scrollController.offset >= 250 && showBackTopButton == false) {
      setState(() {
        showBackTopButton = true;
      });
    } else if (_scrollController.offset < 250 && showBackTopButton == true) {
      setState(() {
        showBackTopButton = false;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_handleScroll);
  }

  @override
  Widget build(BuildContext context) {
    ExposureDetectorController.instance.exposureTime = 100; //设置曝光时长 (ms)
    ExposureDetectorController.instance.exposureFraction = 0.5; // 设置曝光比例
    ExposureDetectorController.instance.updateInterval =
        Duration(milliseconds: 200); // 设置延时检测时间
    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            Expanded(
                child: CustomScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              slivers: [
                SliverPadding(
                    padding: EdgeInsets.fromLTRB(12.w, 10.w, 12.w, 0),
                    sliver: BannerList()),
                SliverPadding(
                    padding: EdgeInsets.fromLTRB(12.w, 8.w, 12.w, 0),
                    sliver: ServiceItems()),
                KingKong(),
                AD(),
                GoodsList(
                  moduleName: 'favoredList',
                  showCorner: true,
                ),
                GoodsList(
                  moduleName: 'deaksList',
                  showCorner: false,
                ),
                ReviewsList(),
                SliverPadding(
                    padding: EdgeInsets.fromLTRB(12.w, 20.w, 12.w, 0),
                    sliver: SliverToBoxAdapter(
                        child: ContentTitle(
                      title: S.of(context).HomePage_recommendTitle,
                      showViewAll: false,
                    ))),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(12.w, 12.w, 12.w, 0),
                  sliver: RecommendList(),
                ),
                RecommendViewMoreButton(),
              ],
            ))
          ],
        ),
        showBackTopButton
            ? Positioned(
                bottom: 100.w,
                right: 20.w,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Routes.push(context, '/webview', params: {
                          "needLogin": '0',
                          "source": "",
                          "content":
                              '{"url":"https://m.homary.com/AppCustomerService"}'
                        });
                      },
                      child: Container(
                        width: 42.w,
                        height: 42.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.primaryBorderShadow,
                              blurRadius: 5.w,
                              spreadRadius: 1.w,
                              offset: Offset(0.w, 2.w),
                            )
                          ],
                        ),
                        child: Icon(
                          Iconfont.Customer,
                          color: AppColor.primaryText,
                          size: 26.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        _scrollController.animateTo(0,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn);
                      },
                      child: Container(
                        width: 42.w,
                        height: 42.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.primaryBorderShadow,
                              blurRadius: 5.w,
                              spreadRadius: 1.w,
                              offset: Offset(0.w, 2.w),
                            )
                          ],
                        ),
                        child: Icon(
                          Iconfont.ArrowUp,
                          color: AppColor.primaryText,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ))
            : Container()
      ],
    ));
  }
}
