import 'package:homary/common/utils/main.dart';

class TabViewBox extends StatelessWidget {
  final TabController _tabController;
  final List<String> _tabValues;

  const TabViewBox(this._tabController, this._tabValues, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBarView(
        controller: _tabController,
        children: _tabValues
            .map((e) => Center(
                  child: Text(e),
                ))
            .toList(),
      ),
    );
  }
}
