/*
 * @Author       : zhhjie
 * @Date         : 2021-07-23 14:32:22
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-28 10:34:47
 */

import 'package:homary/common/utils/main.dart';
import 'package:homary/generated/l10n.dart';

import 'tabItem/main.dart';

class SignInTabBar extends StatelessWidget {
  final Function switchTab;
  final int currentTab;
  const SignInTabBar({this.switchTab, this.currentTab, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      margin: EdgeInsets.only(bottom: 16.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Builder(builder: (ctx) {
            return GestureDetector(
                child: TabItem(S.of(context).login_signIn, 0, this.currentTab),
                onTap: () => switchTab(ctx, 0));
          }),
          Builder(builder: (ctx) {
            return GestureDetector(
                child:
                    TabItem(S.of(context).register_title, 1, this.currentTab),
                onTap: () => switchTab(ctx, 1));
          })
        ],
      ),
    );
  }
}
