/*
 * @Author       : JHao
 * @Date         : 2021-07-07 20:28:59
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-04 11:34:30
 */
import 'dart:convert';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/topChannelCategory.dart';
import 'package:homary/pages/home/components/tabBar/main.dart';
import 'package:homary/pages/home/components/tabView/main.dart';
import 'package:homary/pages/home/contorller.dart';

class HomePageView extends StatefulWidget {
  HomePageView({Key key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with TickerProviderStateMixin {
  List<String> _tabValues = ["Home"];
  List<TopChannelDatum> _tabWebview = [];
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
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        await Provider.of<GlobalConfig>(context, listen: false)
            .getServiceTime();
        Provider.of<HomeCtrl>(context, listen: false).getAdvInfo();
        Provider.of<HomeCtrl>(context, listen: false).getProductModule();
        Provider.of<HomeCtrl>(context, listen: false).getReviewModule();
        Provider.of<HomeCtrl>(context, listen: false).getRecommendList();
        Map<String, dynamic> channelMap =
            await Provider.of<HomeCtrl>(context, listen: false)
                .getTopChannelCategory();
        setState(() {
          _tabValues = [
            ...['Home'],
            ...channelMap['topChannelNameList']
          ];
          _tabWebview = channelMap['topChannelList'];
          _tabController =
              TabController(vsync: this, length: _tabValues.length);
        });
      });
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
              child: TabViewBox(_tabController, _tabWebview),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return HomePageView();
  }
}
