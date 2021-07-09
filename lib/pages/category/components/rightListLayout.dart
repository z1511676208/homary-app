import 'package:homary/common/utils/main.dart';
import 'productList.dart';
import 'tapNav.dart';

class RightListLayout extends StatelessWidget {
  const RightListLayout({Key key}) : super(key: key);

  Widget _banner() {
    return SliverToBoxAdapter(
      child: Container(
        width: 246.5.w,
        height: 100.h,
        margin: EdgeInsets.only(right: 15.w, bottom: 15.h, top: 15.h),
        decoration: BoxDecoration(borderRadius: AppStyle.primaryBorderRaduis),
        child: Placeholder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 254.5.w,
      child: CustomScrollView(
        slivers: [_banner(), TopNav(), ProductList()],
      ),
    );
  }
}
