/*
 * @Author       : zhhjie
 * @Date         : 2021-07-14 18:37:11
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-14 18:40:56
 */

import 'package:homary/common/utils/main.dart';

class Success extends StatelessWidget {
  const Success({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Success!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            height: 8.h,
          ),
          Text('Your new password has been successfully saved.'),
          SizedBox(
            height: 24.h,
          ),
          ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36.0),
                ))),
            onPressed: () {},
            child: Text('continue shipping', style: TextStyle(fontSize: 16.sp)),
          )
        ],
      ),
    );
  }
}
