import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homary/common/config/appConfig.dart';
import 'package:homary/common/config/proxyConfig.dart';
import 'package:homary/common/utils/entrance.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluro/fluro.dart';
import 'package:homary/common/utils/firebaseMessageHandler.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/components/behavior/app_scroll_behavior.dart';
import 'package:homary/pages/home/contorller.dart';
import 'package:homary/pages/shoppingCart/controller.dart';
import 'package:homary/provider/auth_ctrl.dart';
import 'package:homary/provider/productEtaInfo.dart';

import 'package:homary/router/routes.dart';
import 'package:homary/generated/l10n.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/analytics.dart' as Analytics;
import 'package:homary/pages/index/main.dart';
import 'package:homary/common/utils/navigateWatcher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'common/storage/webview-cookie.dart';
import 'common/utils/device.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

final Connectivity _connectivity = Connectivity();
StreamSubscription<ConnectivityResult> _connectivitySubscription;

void main() async {
  if (isRelease) {
    await SentryFlutter.init(
      (options) {
        options.dsn = AppConfig.SENTRY_DSN;
      },
      appRunner: () =>
          Global.init().then((e) => runApp(MyApp())).catchError((error) {
        print('ConnectivityResult  $error');
        _connectivitySubscription = _connectivity.onConnectivityChanged
            .listen((ConnectivityResult result) {
          if (result != ConnectivityResult.none) {
            print("网络连接正常 重新初始化APP");
            _connectivitySubscription.cancel();
            Global.init().then((e) => runApp(MyApp()));
          }
        });
      }),
    );
  } else {
    Global.init().then((e) => runApp(MyApp())).catchError((error) {
      print('ConnectivityResult  $error');
      _connectivitySubscription = _connectivity.onConnectivityChanged
          .listen((ConnectivityResult result) {
        if (result != ConnectivityResult.none) {
          print("网络连接正常 重新初始化APP");
          _connectivitySubscription.cancel();
          Global.init().then((e) => runApp(MyApp()));
        }
      });
    });
  }

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
  final ThemeData theme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: AppColor.primaryMaterialColor,
      primaryColor: AppColor.primaryColor,
      unselectedWidgetColor: AppColor.primaryBorderOutline,
      fontFamily: 'Urbanist');

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GlobalConfig()),
        ChangeNotifierProvider(create: (context) => HomeCtrl()),
        ChangeNotifierProvider(create: (context) => ProductEtaInfo()),
        ChangeNotifierProvider(create: (context) => ShoppingCartCtrl()),
        ChangeNotifierProvider(create: (context) => AuthCtrl()),
      ],
      child: Consumer<GlobalConfig>(
        builder: (context, GlobalConfig value, child) {
          return MaterialApp(
            localizationsDelegates: [
              RefreshLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              S.delegate
            ],
            title: 'Homary',
            locale: value.curLocale,
            supportedLocales: [
              const Locale('en', 'UK'),
              const Locale('de', 'DE'),
              const Locale('fr', 'FR'),
              const Locale('es', 'ES'),
            ],
            theme: theme.copyWith(
              colorScheme:
                  theme.colorScheme.copyWith(secondary: AppColor.primaryColor),
            ),
            // 配置路由
            onGenerateRoute: Routes.router.generator,
            navigatorKey: navigatorKey,
            navigatorObservers: <NavigatorObserver>[
              Analytics.observer,
              NavigateWatcher()
            ],
            //加入路由统计
            home: MainPage(),
            builder: EasyLoading.init(
              builder: (BuildContext context, Widget child) {
                return GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: ScrollConfiguration(
                    behavior: AppScrollBehavior(),
                    child: child,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  StreamSubscription _sub;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<GlobalConfig>(context, listen: false).getCommonConfig();
      Provider.of<GlobalConfig>(context, listen: false).getNavList();
      Provider.of<ProductEtaInfo>(context, listen: false).getAreaByIp();
      String firebaseMessageToken = "";
      try {
        firebaseMessageToken = await FirebaseMessaging.instance.getToken();
      } catch (e) {
        print(e);
      }
      String deviceId = await DeviveInfo.getDeviceId();
      Map<String, dynamic> deviceInfo = await DeviveInfo.getDeviceInfo();
      Provider.of<GlobalConfig>(context, listen: false).pushDeviceInfo(params: {
        "device_number": firebaseMessageToken,
        'device_id': deviceId,
        'device_info': deviceInfo.toString()
      });
    });

    // APP未启动时,启动后获取 firebase meeage
    FirebaseMessageHandler.getInitialMessage();

    // 當app 處於開啟狀態時，監聽推撥訊息用
    FirebaseMessageHandler.onMessage();

    // APP在后台运行时 點通知訊息后要做的事情
    FirebaseMessageHandler.onMessageOpenedApp();

    initDynamicLinks();
  }

  Future<void> initPlatformState() async {
    _sub = await initUniLinks(context);
  }

  Future<void> initDynamicLinks() async {
    // Get any initial links
    try {
      setWebviewCookies();
      final PendingDynamicLinkData initialLink =
          await FirebaseDynamicLinks.instance.getInitialLink();
      Map initParams = initialLink?.link?.queryParameters;
      if (initParams != null && initParams['itemId'] != null) {
        String itemLink =
            'homary://webview?needLogin=0&source=&content={"url":"https:\/\/m.homary.com\/item\/modern-${initParams['itemId']}.html"}';
        handleSchema(context, itemLink);
      }
      dynamicLinks.onLink.listen((PendingDynamicLinkData dynamicLinkData) {
        Map params = dynamicLinkData?.link?.queryParameters;
        if (params != null && params['itemId'] != null) {
          String itemLink =
              'homary://webview?needLogin=0&source=&content={"url":"https:\/\/m.homary.com\/item\/modern-${params['itemId']}.html"}';
          handleSchema(context, itemLink);
        }
      }).onError((error) {
        print('onLink error');
        print(error.message);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_sub != null) _sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 648),
      builder: () => IndexPage(),
    );
  }
}
