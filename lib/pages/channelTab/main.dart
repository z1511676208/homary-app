import 'dart:async';

import 'package:exposure/exposure.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/GoodsCard/main.dart';
import 'package:homary/components/appBar/search/main.dart';
import 'package:homary/components/goBackAppBar/main.dart';
import 'package:homary/components/goTopMenu/main.dart';
import 'package:homary/pages/categoryTab/components/view_more_button.dart';
import 'package:homary/pages/channelTab/components/channel_list_empty.dart';
import 'package:homary/pages/channelTab/components/channel_list_widget.dart';
import 'package:homary/pages/channelTab/controller.dart';
import 'package:homary/widget/networkImg.dart';
import 'package:tuple/tuple.dart';

class ChannelTab extends StatefulWidget {
  const ChannelTab({
    Key key,
    this.channelId,
    this.isPage = false,
    this.appBarTitle,
    this.type,
    this.activityId,
  }) : super(key: key);

  final String channelId;
  final bool isPage;
  final String appBarTitle;

  /// 1=new；2=sale
  final String type;
  final String activityId;

  @override
  _ChannelTabState createState() => _ChannelTabState();
}

class _ChannelTabState extends State<ChannelTab> {
  final ScrollController _scrollController = ScrollController();

  bool showBackTopButton = false;

  int config;

  void _handleScroll() {
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

  bool _debounce = false;
  Timer _timer;
  List<Map> pointList = [];

  _sendPointList() {
    if (_timer != null && _debounce == true) {
      _debounce = false;
      if (_timer.isActive) {
        _timer.cancel();
      }
    }
    if (_debounce == false) {
      _debounce = true;
      _timer = Timer(Duration(seconds: 1), () {
        sendProductItemGTM(
          data: pointList,
          itemListName:
              widget.activityId != null ? 'Market Activity' : 'Activity',
          eventName: 'view_item_list',
        );
        pointList = [];
        _debounce = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    if (_timer != null) {
      // 页面销毁时触发定时器销毁
      if (_timer.isActive) {
        // 判断定时器是否是激活状态
        _timer.cancel();
      }
    }
    super.dispose();
    _scrollController.removeListener(_handleScroll);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<GlobalConfig, ChannelTabCtrl>(
      create: (context) => ChannelTabCtrl(widget.channelId,
          type: widget.type, activityId: widget.activityId),
      update: (context, config, ctrl) {
        if (this.config != config.currentConfig.hashCode) {
          this.config = config.currentConfig.hashCode;
          config.getServiceTime();
          ctrl.onRefresh(isOnRefresh: false);
        }
        return ctrl;
      },
      child: Scaffold(
        appBar: widget.isPage ? buildAppBar() : null,
        body: Selector<ChannelTabCtrl, bool>(
          selector: (context, ctrl) => ctrl.isShowEmpty,
          builder: (context, value, _) {
            return LayoutBuilder(
              builder: (_, constraints) {
                return RefreshIndicator(
                  onRefresh: context.read<ChannelTabCtrl>().onRefresh,
                  child: value
                      ? SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Container(
                            height: constraints.maxHeight,
                            child: ChannelListEmpty(),
                          ),
                        )
                      : Stack(
                          children: [
                            CustomScrollView(
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              slivers: [
                                buildBanner(),
                                ChannelListWidget(),
                                buildGridView(),
                                buildViewMore(),
                              ],
                            ),
                            buildGoTop(),
                          ],
                        ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  PreferredSize buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(96.w),
      child: Column(
        children: [
          GoBackAppBar(
            showBorder: true,
            showCart: true,
            showMore: false,
            showCollet: true,
            title: widget.appBarTitle,
          ),
          AppbarSearch(),
        ],
      ),
    );
  }

  Widget buildGoTop() {
    if (!showBackTopButton) {
      return Container();
    }
    return Positioned(
      bottom: 100.w,
      right: 20.w,
      child: GoTopMenu(
        scrollController: _scrollController,
      ),
    );
  }

  Widget buildBanner() {
    return Selector<ChannelTabCtrl, String>(
      selector: (_, ctrl) {
        return ctrl.bannerImgUrl;
      },
      builder: (context, value, __) {
        return SliverPadding(
          padding: EdgeInsets.all(12.w),
          sliver: SliverToBoxAdapter(
            child: Visibility(
              visible: value != null && value.isNotEmpty,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.w),
                child: CustomNetworkImage(
                  value ?? '',
                  width: 351.w,
                  height: 119.w,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildGridView() {
    return Consumer<ChannelTabCtrl>(
      builder: (_, ctrl, __) {
        return SliverPadding(
          padding: EdgeInsets.fromLTRB(12.w, 12.w, 12.w, 0),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //Grid按两列显示
              mainAxisSpacing: 8.w,
              crossAxisSpacing: 8.w,
              childAspectRatio: ((1.sw - 24.w) / 2) / 354.w,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ExposureDetector(
                  key: Key('Channel_$index'),
                  child: GoodsCard(
                    key: UniqueKey(),
                    width: (1.sw - 24.w) / 2,
                    data: ctrl.productList[index],
                    showCorner: false,
                    showSkuList: true,
                    showFreeShipping: true,
                    showRating: true,
                  ),
                  onExposure: (visibilityInfo) {
                    Map<String, dynamic> item =
                        ctrl.productList[index].toJson();
                    pointList.add(item);
                    _sendPointList();
                  },
                );
              },
              childCount: ctrl.productList.length,
            ),
          ),
        );
      },
    );
  }

  Widget buildViewMore() {
    return Selector<ChannelTabCtrl, Tuple2<int, bool>>(
      selector: (_, ctrl) {
        return Tuple2(ctrl.hasMorePage, ctrl.isLoading);
      },
      builder: (context, value, __) {
        if (value.item1 == 0) {
          return SliverToBoxAdapter();
        }
        return SliverToBoxAdapter(
          child: Center(
            child: ViewMoreButton(
              isLoading: value.item2,
              onLoadMore: () {
                context.read<ChannelTabCtrl>().getTopicFlow();
              },
            ),
          ),
        );
      },
    );
  }
}
