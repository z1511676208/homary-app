import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:homary/common/utils/dialog.dart';
import 'package:homary/common/utils/entrance.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluro/fluro.dart';
import 'package:homary/entity/appUpgrade.dart';
import 'package:homary/pages/home/contorller.dart';
import 'package:homary/provider/productEtaInfo.dart';

import 'package:homary/router/routes.dart';
import 'package:homary/generated/l10n.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/analytics.dart' as Analytics;
import 'package:homary/pages/index/main.dart';
import 'package:homary/common/utils/navigateWatcher.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

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
        ChangeNotifierProvider(create: (context) => GlobalConfig()),
        ChangeNotifierProvider(create: (context) => HomeCtrl()),
        ChangeNotifierProvider(create: (context) => ProductEtaInfo()),
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
            ],
            //加入路由统计
            home: MainPage(),
            builder: EasyLoading.init(),
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

  @override
  void initState() {
    super.initState();
    initPlatformState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<GlobalConfig>(context, listen: false).getCommonConfig();
      Provider.of<GlobalConfig>(context, listen: false).getShoppingCartNumber();
      Provider.of<GlobalConfig>(context, listen: false).getNavList();
      Provider.of<ProductEtaInfo>(context, listen: false).getAreaByIp();

      String firebaseMessageToken = await FirebaseMessaging.instance.getToken();
      Provider.of<GlobalConfig>(context, listen: false)
          .pushDeviceInfo(params: {"device_number": firebaseMessageToken});

      //获取app升级信息，判断是否弹出升级提示框
      UpgradeRes upGradeInfo =
          await Provider.of<GlobalConfig>(context, listen: false)
              .getAppUpgradeInfo();
      if (upGradeInfo != null && upGradeInfo.data.isUpgrade != 0) {
        Widget content = HtmlWidget(upGradeInfo.data.content ?? '');
        Widget popup = Container(
          decoration: BoxDecoration(
              borderRadius: AppStyle.primaryBorderRaduis, color: Colors.white),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Update Available:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
              SizedBox(
                width: double.infinity,
                height: 12.w,
              ),
              Text(
                'Latest version:v${upGradeInfo.data.upgradeVersion}',
                style: TextStyle(fontSize: 14.sp),
              ),
              SizedBox(
                width: double.infinity,
                height: 12.w,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: content,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 12.w,
              ),
              Container(
                  width: double.infinity,
                  height: 40.w,
                  child: Builder(builder: (ctx) {
                    return OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColor.primaryColor),
                          elevation: MaterialStateProperty.all(0),
                          overlayColor: MaterialStateProperty.all(
                              AppColor.primaryPressed),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36.0.w),
                          ))),
                      onPressed: () async {},
                      child: Text('Update',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    );
                  })),
              Offstage(
                  offstage: upGradeInfo.data.isUpgrade == 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'No thanks',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: AppColor.primaryText),
                        )),
                  ))
            ],
          ),
        );
        AppDialog.show(
            context: context,
            widget: Container(width: 0.76.sw, height: 280.w, child: popup),
            canCancel: upGradeInfo.data.isUpgrade == 2);
      }
    });

    // 當 app 處於開啟狀態時，監聽推撥訊息用
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null && android != null) {
        await flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: 'launcher_small',
                color: AppColor.primaryColor,
                largeIcon: DrawableResourceAndroidBitmap('launcher_icon'),
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // 這邊可以寫在 app 關閉狀態，點通知訊息時，打開 app 後要做的事情
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
      designSize: Size(375, 648),
      builder: () => IndexPage(),
    );
  }
}
