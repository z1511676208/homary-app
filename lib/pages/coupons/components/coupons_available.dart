import 'package:homary/common/utils/main.dart';
import 'package:homary/components/goTopMenu/main.dart';
import 'package:homary/components/pullToRefresh/pull_to_refresh.dart';
import 'package:homary/entity/coupon.dart';
import 'package:homary/pages/coupons/components/copons_emtpy.dart';
import 'package:homary/pages/coupons/components/coupons_item.dart';
import 'package:homary/pages/coupons/controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CouponsAvailable extends StatefulWidget {
  const CouponsAvailable({Key key}) : super(key: key);

  @override
  _CouponsAvailableState createState() => _CouponsAvailableState();
}

class _CouponsAvailableState extends State<CouponsAvailable>
    with AutomaticKeepAliveClientMixin {
  RefreshController controller = RefreshController();
  String code = '';

  ScrollController _scrollController = ScrollController();
  bool showBackTopButton = false;

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
    super.build(context);
    return Stack(
      children: [
        Selector<CouponsPageCtrl, List<Coupon>>(
          selector: (_, ctrl) => ctrl.availableList,
          builder: (_, list, __) {
            return PullToRefresh(
              controller: controller,
              enablePullUp: false,
              onRefresh: () async {
                await context.read<CouponsPageCtrl>().getAvailableCoupons(true);
                controller.refreshCompleted();
              },
              child: list.length == 0
                  ? CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        buildApplyCoupon(context),
                        SliverPadding(
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                            top: 8.w,
                            bottom: MediaQuery.of(context).padding.bottom,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return CouponsItem(
                                  available: true,
                                  coupon: list[index],
                                );
                              },
                              childCount: list.length,
                            ),
                          ),
                        ),
                      ],
                    )
                  : CustomScrollView(
                      slivers: [
                        buildApplyCoupon(context),
                        SliverToBoxAdapter(
                          child: CouponsEmpty(),
                        ),
                      ],
                    ),
            );
          },
        ),
        buildGoTop(),
      ],
    );
  }

  Widget buildApplyCoupon(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 8.w,
          bottom: 8.w,
        ),
        height: 35.w,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (str) {
                  setState(() {
                    code = str;
                  });
                },
                style: TextStyle(
                  fontSize: 13.sp,
                ),
                decoration: InputDecoration(
                  hintText: S.of(context).coupons_code,
                  hintStyle: TextStyle(
                    color: AppColor.couponsHintColor,
                    fontSize: 13.sp,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3.w)),
                    borderSide: BorderSide(
                      color: AppColor.primaryBorderOutline,
                      width: 0.5.w,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            SizedBox(
              width: 72.w,
              height: 35.w,
              child: ElevatedButton(
                onPressed: code.isEmpty
                    ? null
                    : () {
                        context.read<CouponsPageCtrl>().applyCoupon(code);
                      },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 0)),
                child: Text(
                  S.of(context).coupons_apply,
                  style: TextStyle(
                    color: code.isEmpty ? AppColor.primaryText : Colors.white,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            )
          ],
        ),
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

  @override
  bool get wantKeepAlive => true;
}
