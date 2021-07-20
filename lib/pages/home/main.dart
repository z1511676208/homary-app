/*
 * @Author       : JHao
 * @Date         : 2021-07-07 20:28:59
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-28 15:19:06
 */
import 'dart:convert';

import 'package:homary/common/utils/main.dart';
import 'package:homary/pages/home/components/tabBar/main.dart';
import 'package:homary/pages/home/components/tabView/main.dart';
import 'package:homary/pages/home/contorller.dart';

class HomePageView extends StatefulWidget {
  HomePageView({Key key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with SingleTickerProviderStateMixin {
  final List<String> _tabValues = [
    'Home',
  ];
  TabController _tabController;
  var currentConfig;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabValues.length);
  }

  @override
  void didChangeDependencies() async {
    var current =
        jsonEncode(Provider.of<GlobalConfig>(context).currentConfig?.toJson());
    if (this.currentConfig != current) {
      this.currentConfig = current;
      await Provider.of<GlobalConfig>(context, listen: false).getServiceTime();
      Provider.of<HomeCtrl>(context, listen: false).getIndexData();
      Provider.of<HomeCtrl>(context, listen: false).getRecommendList();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          TabBarWidget(_tabController, _tabValues),
          Flexible(
            flex: 1,
            child: Container(
              child: TabViewBox(_tabController, _tabValues, currentConfig),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePageView();
  }
}
