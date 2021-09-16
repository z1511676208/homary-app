import 'package:homary/common/utils/main.dart';
import 'package:homary/components/goTopMenu/main.dart';
import 'package:homary/components/pullToRefresh/pull_to_refresh.dart';
import 'package:homary/entity/coupon.dart';
import 'package:homary/pages/coupons/components/copons_emtpy.dart';
import 'package:homary/pages/coupons/components/coupons_item.dart';
import 'package:homary/pages/coupons/controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CouponsUnavailable extends StatefulWidget {
  const CouponsUnavailable({Key key}) : super(key: key);

  @override
  _CouponsUnavailableState createState() => _CouponsUnavailableState();
}

class _CouponsUnavailableState extends State<CouponsUnavailable>
    with AutomaticKeepAliveClientMixin {
  RefreshController controller = RefreshController();
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
          selector: (_, ctrl) => ctrl.unavailableList,
          builder: (_, list, __) {
            return PullToRefresh(
              controller: controller,
              enablePullUp: false,
              onRefresh: () async {
                await context
                    .read<CouponsPageCtrl>()
                    .getAvailableCoupons(false);
                controller.refreshCompleted();
              },
              child: list.length != 0
                  ? ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        top: 8.w,
                        bottom: MediaQuery.of(context).padding.bottom,
                      ),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return CouponsItem(
                          available: false,
                          coupon: list[index],
                        );
                      },
                    )
                  : CouponsEmpty(),
            );
          },
        ),
        buildGoTop(),
      ],
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
