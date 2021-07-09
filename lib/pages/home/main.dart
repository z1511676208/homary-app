/*
 * @Author       : JHao
 * @Date         : 2021-07-07 20:28:59
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-08 14:01:58
 */
// import 'package:homary/common/storage/cookie.dart';
// import 'package:homary/common/storage/webview-cookie.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/pages/home/components/tabBar/main.dart';
import 'package:homary/pages/home/components/tabView/main.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {

//     return

// Map<String, String> config = {
//   "language": "fr",
//   "currency": "cad",
//   "site": "us"
// };
// setCurrentConfig(config); // 模拟设置站点信息
// // 模拟设置用户token
// setToken(
//     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IlNxR1NJYjNEUUVCQVFVQUE0In0.eyJpc3MiOiJodHRwczpcL1wvaG9tYXJ5LmNvbSIsImp0aSI6IlNxR1NJYjNEUUVCQVFVQUE0IiwiaWF0IjoxNjI1NTcxNjIyLCJleHAiOjE2NDExMjM2MjIsInVzZXJfaWQiOjEwOTU2MX0.tv7RH8S2m6jMbkvO9xomherXrzKloMIzfsJS3a1mxLvZwCqZgOPiIMaKmHHYqGzNEgfcfWGZl2EhLtLugFBcGlG1ut0zpiLkfAWTx5X5d1kk7dcB3Ghjy0ZtKFKa9XALqZI64Zz0cY7pzive9kKa69TcFwjvvMGimASZcDZSKZo');
// setCurrentConfigCookie(); // 模拟存储站点信息到cookie
// setTokenCookie(); // 模拟存储token到cookie
// return Center(
//     child: Column(
//   children: [
//     TextButton(
//         onPressed: () {
//           Navigator.pushNamed(context, '/signIn');
//         },
//         child: Text('signIn')),
//     TextButton(
//         onPressed: () {
//           Routes.push(
//             context,
//             '/scrollList',
//           );
//         },
//         child: Text('监听列表滚动上报埋点 demo')),
//     TextButton(
//         onPressed: () {
//           Routes.push(
//             context,
//             '/webview',
//           );
//         },
//         child: Text('webview'))
//   ],
// ));
//   }
// }

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabValues.length);
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
