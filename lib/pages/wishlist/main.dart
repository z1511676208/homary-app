/*
 * @Author       : zhhjie
 * @Date         : 2021-09-06 14:10:56
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-06 19:28:57
 */
import 'dart:async';

import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/dialog.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/GoodsCard/goods_cart_grid.dart';
import 'package:homary/components/dropMenu/drop_menu.dart';
import 'package:homary/components/goBackAppBar/main.dart';
import 'package:homary/components/pullToRefresh/pull_to_refresh.dart';

import 'components/drop_menu_sort.dart';
import 'controller.dart';

class WishlistView extends StatefulWidget {
  WishlistView({Key key}) : super(key: key);

  @override
  _WishlistViewState createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  GlobalKey _key = GlobalKey();
  Timer _timer;
  bool _debounce = false;
  void deleteItem(WishlistCtrl controller, id) async {
    await controller.wishCancel({"sku_id": id});
    await controller.getList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<WishlistCtrl>(context, listen: false).initOrderByList();
      await Provider.of<WishlistCtrl>(context, listen: false).getList();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    DropMenuManager.instance.hide();
  }

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
          itemListName: 'Wishlist',
          eventName: 'view_item_list',
        );
        pointList = [];
        _debounce = false;
      });
    }
  }

  void controlMenu() {
    WishlistCtrl ctrl = context.read<WishlistCtrl>();
    DropMenuManager.instance.showDropDownMenu(
      context,
      marginTop:
          DropMenuManager.instance.getWeightMarginTop(_key.currentContext),
      menuBarHeight: 46.5.w,
      menuHeight: 180.w,
      menu: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.w)),
          ),
          child: WishDropMenuSort(
            orderByList: ctrl.orderByList,
            onSelect: () {
              ctrl.changeSortBy();
            },
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: GoBackAppBar(
              title: S.of(context).usercenter_wishlist_title,
              rightWidget: Container(
                child: IconButton(
                  onPressed: () {
                    this.controlMenu();
                  },
                  icon: Icon(Iconfont.Wish_filter,
                      color: Provider.of<WishlistCtrl>(context).sort == ''
                          ? AppColor.primaryText
                          : AppColor.primaryColor),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(44.h)),
        body: Consumer<WishlistCtrl>(
          key: _key,
          builder: (context, WishlistCtrl controller, child) => PullToRefresh(
            controller: controller.refreshController,
            onLoading: () async {
              controller.handleGetMoreWish();
            },
            onRefresh: () async {
              controller.reset();
              controller.getList();
              controller.refreshController.refreshCompleted();
            },
            child: controller.list.isNotEmpty
                ? CustomScrollView(
                    slivers: <Widget>[
                      GoodsCartSliverGrid(
                        showDelete: true,
                        productList: controller.list,
                        onDelete: (id) async {
                          bool res = await AppDialog.showMessage(
                              context: context,
                              message: S.of(context).user_viewed_del_tips);
                          if (res ?? false) {
                            deleteItem(controller, id);
                          }
                        },
                        onExposure: (list) {
                          pointList.addAll(list);
                          _sendPointList();
                        },
                      ),
                    ],
                  )
                : Container(
                    width: 1.sw,
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/user/no_favorites.png',
                          width: 100.w,
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                        Text(S.of(context).user_viewed_nodata,
                            style: TextStyle(
                                color: AppColor.primaryText, fontSize: 14.sp)),
                        SizedBox(
                          height: 10.w,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Routes.goHome();
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.fromLTRB(30.w, 12.w, 30.w, 12.w)),
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(
                                  AppColor.primaryColor),
                              overlayColor: MaterialStateProperty.all(
                                  AppColor.primaryPressed),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36.0.w),
                              ))),
                          child: Text(
                            S.of(context).user_viewed_explore_btn,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        ));
  }
}

class Wishlist extends StatelessWidget {
  const Wishlist({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WishlistCtrl>(
          create: (context) => WishlistCtrl(),
        )
      ],
      child: WishlistView(),
    );
  }
}
