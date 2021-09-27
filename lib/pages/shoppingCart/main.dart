/*
 * @Author       : JHao
 * @Date         : 2021-09-26 14:54:40
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-29 12:02:01
 */
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/goBackAppBar/main.dart';
import 'package:homary/components/goTopMenu/main.dart';
import 'package:homary/components/pullToRefresh/pull_to_refresh.dart';
import 'package:homary/pages/shoppingCart/components/shopping_cart_bottom.dart';
import 'package:homary/pages/shoppingCart/components/shopping_cart_empty.dart';
import 'package:homary/pages/shoppingCart/components/shopping_cart_for_you.dart';
import 'package:homary/pages/shoppingCart/components/shopping_cart_item.dart';
import 'package:homary/entity/shoppingCartData.dart' as Data;
import 'package:homary/pages/shoppingCart/components/shopping_cart_summary.dart';
import 'package:homary/pages/shoppingCart/controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tuple/tuple.dart';

class ShoppingCartView extends StatefulWidget {
  final String couponUserId;
  ShoppingCartView({Key key, this.couponUserId}) : super(key: key);

  @override
  _ShoppingCartViewState createState() => _ShoppingCartViewState();
}

class _ShoppingCartViewState extends State<ShoppingCartView> {
  ScrollController _scrollController = ScrollController();
  bool showBackTopButton = false;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<ShoppingCartCtrl>(context, listen: false)
          .getShoppingCartData(couponUserId: widget.couponUserId ?? '');
      Provider.of<ShoppingCartCtrl>(context, listen: false)
          .getPayMethodIconList();
    });
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_handleScroll);
  }

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

  @override
  Widget build(BuildContext context) {
    Tuple2<RefreshController, bool> tuple = context
        .select<ShoppingCartCtrl, Tuple2<RefreshController, bool>>((value) {
      return Tuple2<RefreshController, bool>(value.refreshController,
          value.shoppingCart == null || value.shoppingCart.isEmpty);
    });
    return Scaffold(
      appBar: PreferredSize(
        child: GoBackAppBar(
          showCollet: true,
        ),
        preferredSize: Size.fromHeight(44.h),
      ),
      bottomNavigationBar: ShoppingCartBottom(parentContext: context),
      body: Stack(
        children: [
          PullToRefresh(
            controller: tuple.item1,
            enablePullUp: tuple.item2,
            onRefresh: context.read<ShoppingCartCtrl>().onRefresh,
            onLoading: context.read<ShoppingCartCtrl>().getRecommendList,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                padding(buildShoppingCartTitle(context)),
                padding(buildShoppingCartList(context)),
                padding(ShoppingCartSummary()),
                padding(buildLaterList(context)),
                ShoppingCartJustForYouTitle(),
                ShoppingCartJustForYou(),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
                  ),
                ),
              ],
            ),
          ),
          buildGoTop(),
        ],
      ),
    );
  }

  Widget padding(Widget widget) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      sliver: widget,
    );
  }

  Widget buildShoppingCartTitle(BuildContext context) {
    return Consumer<ShoppingCartCtrl>(builder: (_, ctrl, __) {
      return SliverToBoxAdapter(
        child: Column(
          children: [
            SizedBox(height: 20.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).shopping_cart_shopping_cart_item(
                      ctrl.shoppingCart?.length ?? 0),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if ((ctrl.shoppingCart?.length ?? 0) != 0)
                  Expanded(
                    child: Text(
                      S.of(context).shopping_cart_subtotal,
                      maxLines: 2,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 2.w),
            if ((ctrl.shoppingCart?.length ?? 0) != 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).shopping_cart_order_ships_free,
                    style: TextStyle(
                      color: AppColor.cartHintColor,
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    ctrl.summary?.subtotal ?? '',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
    });
  }

  Widget buildShoppingCartList(BuildContext context) {
    return Selector<ShoppingCartCtrl, List<Data.ShoppingCart>>(
      selector: (_, ctrl) => ctrl.shoppingCart,
      builder: (_, value, __) {
        return value != null && value.length != 0
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ShoppingCartItem(
                      data: value[index],
                      isFromCart: true,
                    );
                  },
                  childCount: value?.length ?? 0,
                ),
              )
            : SliverToBoxAdapter(child: ShoppingCartEmpty());
      },
      shouldRebuild: (pre, next) {
        return pre != next;
      },
    );
  }

  Widget buildLaterList(BuildContext context) {
    return Selector<ShoppingCartCtrl, List<Data.ShoppingCart>>(
      selector: (_, ctrl) => ctrl.saveForLater,
      builder: (_, value, __) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index == 0) {
                // 标题
                return Container(
                  margin: EdgeInsets.only(top: 24.w),
                  child: Text(
                    S
                        .of(context)
                        .shopping_cart_save_for_later_item(value?.length ?? 0),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              return ShoppingCartItem(
                data: value[index - 1],
                isFromCart: false,
              );
            },
            childCount: (value?.length ?? 0) == 0 ? 0 : value.length + 1,
          ),
        );
      },
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
}

class ShoppingCart extends StatelessWidget {
  final String couponUserId;
  const ShoppingCart({Key key, this.couponUserId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShoppingCartView(
      couponUserId: this.couponUserId,
    );
  }
}
