/*
 * @Author       : zhhjie
 * @Date         : 2021-08-27 13:47:49
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-27 15:22:33
 */
import 'dart:async';

import 'package:homary/common/utils/main.dart';

class NewUserSuccessDialog extends StatefulWidget {
  const NewUserSuccessDialog({Key key, @required this.totalAmountStr})
      : super(key: key);
  final String totalAmountStr;

  @override
  _NewUserSuccessDialogState createState() => _NewUserSuccessDialogState();
}

class _NewUserSuccessDialogState extends State<NewUserSuccessDialog> {
  Timer _timer;
  int second = 2;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        --second;
        if (second == 0) {
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      height: 165.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 28.w,
              left: 12.w,
              right: 12.w,
            ),
            child: Text(
              S.of(context).new_user_received_all(widget.totalAmountStr),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColor.primaryText,
              ),
            ),
          ),
          Container(
            width: 260.w,
            height: 36.w,
            margin: EdgeInsets.only(top: 24.w),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                '${S.of(context).new_user_use_now} ($second S)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
