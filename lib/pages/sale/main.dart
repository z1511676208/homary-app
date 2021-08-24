/*
 * @Author       : JHao
 * @Date         : 2021-07-14 15:05:20
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-24 14:55:20
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
import 'package:homary/webView/webviewController.dart';

class SalePage extends StatefulWidget {
  SalePage({Key key}) : super(key: key);

  @override
  _SalePageState createState() => _SalePageState();
}

class _SalePageState extends State<SalePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WebviewCtrl(
      isInWebviewPage: false,
      needLogin: '0',
      source: '',
      content: {
        "url": "https://m.homary.com/activity-list/father-s-day-2021?current=1"
      },
    );
  }
}
