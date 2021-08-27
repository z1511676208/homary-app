/*
 * @Author       : JHao
 * @Date         : 2021-07-14 15:05:20
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-27 16:41:32
 */

// import 'package:homary/common/utils/main.dart';
// import 'package:homary/widget/networkImg.dart';
// import 'package:dio_log/dio_log.dart';
// class SalePage extends StatelessWidget {
//   const SalePage({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 260.w,
//           child: CustomNetworkImage(
//             'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAG8Fmhxr42POEUjJ_d-1qSvRDmkuvkWz7fw&usqp=CAU',
//             fit: BoxFit.cover,
//             width: 1.sw,
//           ),
//         ),
//         TextButton(
//             onPressed: () {
//               Routes.getCurPath();
//             },
//             child: Text('路由')),
//         TextButton(
//             onPressed: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => HttpLogListWidget(),
//                 ),
//               );
//             },
//             child: Text('Dio log 中心'))
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:homary/common/storage/cookie.dart';
import 'package:homary/webView/webviewController.dart';

class SalePage extends StatefulWidget {
  SalePage({Key key}) : super(key: key);

  @override
  _SalePageState createState() => _SalePageState();
}

class _SalePageState extends State<SalePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => false;

  Map<String, String> _siteLink = {
    'us': "https://m.homary.com/lego/sale-154.html",
    "uk": "https://muk.homary.com/lego/sale-160.html",
    "fr": "https://mfr.homary.com/lego/bon-plan-pour-la-maison-164.html",
    "es": "https://mes.homary.com/lego/buenasofertas-73.html",
    "de": "https://mde.homary.com/lego/angebote-126.html",
    "au": "https://mau.homary.com/lego/saleau-129.html",
    "ca": "https://mca.homary.com/lego/saleca-132.html",
    "global": "https://m.homary.com/channel/new-products-1.html?current=1"
  };
  String _site = getCurrentConfig()['site'] ?? 'us';

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WebviewCtrl(
      isInWebviewPage: false,
      needLogin: '0',
      source: '',
      content: {"url": _siteLink[_site]},
    );
  }
}
