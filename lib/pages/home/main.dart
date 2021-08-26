/*
 * @Author       : JHao
 * @Date         : 2021-07-07 20:28:59
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-25 18:15:32
 */
import 'dart:async';
import 'dart:convert';
import 'package:homary/common/event/go_home.dart';
import 'package:homary/common/utils/event_bus.dart';
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
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    print('initState 111111111111111111111');
    _tabController = TabController(vsync: this, length: _tabValues.length);
    _subscription = EventBus.instance.on<GoHomeEvent>().listen((event) {
      setState(() {
        _tabController.animateTo(event.homeTabIndex ?? 0);
      });
    });
  }

  @override
  void didChangeDependencies() async {
    var current =
        jsonEncode(Provider.of<GlobalConfig>(context).currentConfig?.toJson());
    int tabIndex = _tabController.index;
    if (current != 'null' && this.currentConfig != current) {
      this.currentConfig = current;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        print('111111111111111111111');
        Provider.of<GlobalConfig>(context, listen: false).getServiceTime();
        Provider.of<HomeCtrl>(context, listen: false).getAdvInfo();
        Provider.of<HomeCtrl>(context, listen: false).getProductModule();
        Provider.of<HomeCtrl>(context, listen: false).getReviewModule();
        Provider.of<HomeCtrl>(context, listen: false).getRecommendList();
        Map<String, dynamic> channelMap =
            await Provider.of<HomeCtrl>(context, listen: false)
                .getTopChannelCategory();

        setState(() {
          _tabValues = [
            ...[S.of(context).Home],
            ...channelMap['topChannelNameList']
          ];
          _tabWebview = channelMap['topChannelList'];
          _tabController =
              TabController(vsync: this, length: _tabValues.length);
          _tabController.animateTo(tabIndex);
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _subscription?.cancel();
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
