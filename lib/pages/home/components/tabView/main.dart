/*
 * @Author       : JHao
 * @Date         : 2021-07-09 19:31:26
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-28 16:21:38
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/pages/home/components/homeItem/main.dart';

class TabViewBox extends StatelessWidget {
  final TabController _tabController;
  final List<String> _tabValues;
  final String currentConfig;
  const TabViewBox(this._tabController, this._tabValues, this.currentConfig,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBarView(
        controller: _tabController,
        children: [HomeItem()],
      ),
    );
  }
}
