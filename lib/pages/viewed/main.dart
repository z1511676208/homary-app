/*
 * @Author       : JHao
 * @Date         : 2021-09-06 14:23:41
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-15 17:14:50
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/dialog.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/components/GoodsCard/goods_cart_grid.dart';
import 'package:homary/components/goBackAppBar/main.dart';
import 'package:homary/components/pullToRefresh/pull_to_refresh.dart';
import 'package:homary/generated/l10n.dart';
import 'package:homary/pages/user/controller.dart';
import 'package:homary/router/routes.dart';
import 'package:provider/provider.dart';

class UserViewed extends StatefulWidget {
  UserViewed({Key key}) : super(key: key);

  @override
  _UserViewedState createState() => _UserViewedState();
}

class _UserViewedState extends State<UserViewed> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Toast.loading();
      await Provider.of<UserCtrl>(context, listen: false).getRecentlyBrowsed();
      // bool result = await AppDialog.showMessage(
      //     context: context,
      //     message: S.of(context).user_viewed_del_tips,
      //     noStr: S.of(context).cancelButtonText,
      //     yesStr: S.of(context).deleteButtonText);
      Toast.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserCtrl>(
      builder: (context, UserCtrl data, child) {
        return Scaffold(
            appBar: GoBackAppBar(
                title: S.of(context).user_viewed,
                handleGoBackFn: () {
                  Routes.pop();
                }),
            body: data.recentlyList.length > 0
                ? PullToRefresh(
                    controller: data.refreshController,
                    enablePullUp: data.recentlyList.length > 0,
                    onLoading: () async {
                      await data.handleGetMoreProduct();
                    },
                    onRefresh: () async {
                      await data.getRecentlyBrowsed();
                      data.refreshController.refreshCompleted();
                    },
                    child: CustomScrollView(
                      slivers: [
                        GoodsCartSliverGrid(
                          showDelete: true,
                          productList: data.recentlyList,
                          onDelete: (id) async {
                            bool res = await AppDialog.showMessage(
                                context: context,
                                message: S.of(context).user_viewed_del_tips);
                            if (res ?? false) {
                              data.handleDelFootPrint(params: {"sku_id": id});
                            }
                          },
                        ),
                      ],
                    ))
                : Container(
                    width: 1.sw,
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/user/no_viewed.png',
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
                  ));
      },
    );
  }
}

class ViewedPage extends StatelessWidget {
  const ViewedPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserCtrl>(
          create: (context) => UserCtrl(),
        )
      ],
      child: UserViewed(),
    );
  }
}
