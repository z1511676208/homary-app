/*
 * @Author       : zhhjie
 * @Date         : 2021-09-06 14:10:56
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-09-08 15:40:47
 */

import 'package:homary/common/utils/analytics_util.dart';
import 'package:homary/common/utils/dialog.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
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

  void deleteItem(WishlistCtrl controller, id) async {
    Toast.loading();
    await controller.wishCancel({"sku_id": id});
    await controller.getList();
    Toast.clear();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<WishlistCtrl>(context, listen: false).initOrderByList();
      Toast.loading();
      await Provider.of<WishlistCtrl>(context, listen: false).getList();
      Toast.clear();
    });
  }

  @override
  void dispose() {
    super.dispose();
    DropMenuManager.instance.hide();
  }

  void controlMenu() {
    WishlistCtrl ctrl = context.read<WishlistCtrl>();
    DropMenuManager.instance.showDropDownMenu(
      context,
      marginTop:
          DropMenuManager.instance.getWeightMarginTop(_key.currentContext),
      menuBarHeight: 46.5.w,
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
                      size: 20.sp,
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
                        itemListName: 'Wishlist',
                        onDelete: (id) async {
                          bool res = await AppDialog.showMessage(
                              context: context,
                              message: S.of(context).user_viewed_del_tips);
                          if (res ?? false) {
                            deleteItem(controller, id);
                          }
                        },
                        onExposure: (list) {
                          AnalyticsUtil.instance.sendProductItemGTM(
                            pointList: list,
                            itemListName: 'Wishlist',
                            eventName: 'view_item_list',
                          );
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
                        Text(S.of(context).usercenter_wishlist_empty_tip,
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
