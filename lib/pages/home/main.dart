/*
 * @Author       : JHao
 * @Date         : 2021-07-07 20:28:59
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-19 13:44:10
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/pages/home/components/tabBar/main.dart';
import 'package:homary/pages/home/components/tabView/main.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<String> _tabValues = [
    'Home',
    'kitemut',
    'infodfefeetet',
    'pppdfe',
    'sfsff',
    'qweeqrp',
    'xcvxvdd',
    'infodfefeetet',
    'jhphhuu',
  ];

  TabController _tabController;

  var currentConfig;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabValues.length);
    // GlobalConfig().addListener(printLog);
  }

  @override
  void didChangeDependencies() {
    var current = Provider.of<GlobalConfig>(context).currentConfig;
    if (this.currentConfig != current) {
      this.currentConfig = current;
    }
    // TODO: implement didChangeDependencies
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
      height: 500.h,
      width: double.infinity,
      child: Column(
        children: [
          TabBarWidget(_tabController, _tabValues),
          Flexible(
            flex: 1,
            child: Container(
              child: TabViewBox(_tabController, _tabValues),
            ),
          ),
        ],
      ),
    );
  }
}
