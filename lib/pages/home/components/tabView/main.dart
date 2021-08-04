/*
 * @Author       : JHao
 * @Date         : 2021-07-09 19:31:26
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-03 13:44:03
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/topChannelCategory.dart';
import 'package:homary/pages/home/components/CategoryItem/main.dart';
import 'package:homary/pages/home/components/homeItem/main.dart';

class TabViewBox extends StatelessWidget {
  final TabController _tabController;
  final List<TopChannelDatum> _tabWebview;
  const TabViewBox(this._tabController, this._tabWebview, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBarView(
        controller: _tabController,
        children: [
          HomeItem(),
          ...this._tabWebview.asMap().entries.map((entry) {
            int idx = entry.key;
            TopChannelDatum val = entry.value;
            return CategoryItem(
                key: ValueKey(val.categoryId),
                link: val.jumpUrl,
                idx: idx,
                tabController: _tabController);
          }).toList()
        ],
      ),
    );
  }
}
