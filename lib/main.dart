/*
 * @Author       : JHao
 * @Date         : 2021-07-12 12:20:08
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-14 15:22:59
 */
import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homary/common/utils/entrance.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluro/fluro.dart';
import 'package:homary/router/routes.dart';
import 'package:homary/generated/l10n.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/analytics.dart' as Analytics;
import 'package:homary/pages/index/main.dart';
import 'package:homary/common/utils/navigateWatcher.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
void main() {
  Global.init().then((e) => runApp(MyApp()));
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 5000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 40.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.red
    ..maskType = EasyLoadingMaskType.none
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Routes.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider.value(value: Lang())],
        child: Consumer<Lang>(builder: (context, Lang value, child) {
          return MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              S.delegate
            ],
            locale: value.curLocale,
            supportedLocales: [
              const Locale('zh', 'CN'),
              const Locale('en', 'US'),
            ],
            theme: ThemeData(primarySwatch: Colors.orange),
            // 配置路由
            onGenerateRoute: Routes.router.generator,
            navigatorKey: navigatorKey,
            navigatorObservers: <NavigatorObserver>[
              Analytics.observer,
              navigateWatcher()
            ], //加入路由统计
            home: MainPage(),
            builder: EasyLoading.init(),
          );
        }));
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    _sub = await initUniLinks(context);
  }

  @override
  void dispose() {
    super.dispose();
    if (_sub != null) _sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 648), builder: () => IndexPage());
  }
}
