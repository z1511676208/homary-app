import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homary/common/utils/device.dart';
import 'package:homary/common/utils/entrance.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluro/fluro.dart';
import 'package:homary/pages/home/contorller.dart';

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
    ..displayDuration = const Duration(milliseconds: 3000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 40.0
    ..radius = 10.0
    ..maskType = EasyLoadingMaskType.none
    ..maskColor = Colors.blue.withOpacity(0.3)
    ..userInteractions = false
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
  // @override
  // void didUpdateWidget(covariant MyApp oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: GlobalConfig()),
          ChangeNotifierProvider.value(value: HomeCtrl()),
        ],
        child: Consumer<GlobalConfig>(
            builder: (context, GlobalConfig value, child) {
          return MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              S.delegate
            ],
            locale: value.curLocale,
            supportedLocales: [
              const Locale('en', 'UK'),
              const Locale('de', 'DE'),
              const Locale('fr', 'FR'),
              const Locale('es', 'ES'),
            ],
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: AppColor.primaryMaterialColor,
              primaryColor: AppColor.primaryColor,
              accentColor: AppColor.primaryColor,
            ),
            // 配置路由
            onGenerateRoute: Routes.router.generator,
            navigatorKey: navigatorKey,
            navigatorObservers: <NavigatorObserver>[
              Analytics.observer,
              NavigateWatcher()
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<GlobalConfig>(context, listen: false).getCommonConfig();

      var deviceId = await DeviveInfo().getDeviceId();
      Provider.of<GlobalConfig>(context, listen: false)
          .pushDeviceInfo(params: {"device_number": deviceId});
    });
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
