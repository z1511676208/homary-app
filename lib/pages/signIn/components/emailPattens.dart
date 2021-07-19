/*
 * @Author       : zhhjie
 * @Date         : 2021-07-22 17:25:02
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-27 10:42:46
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/pages/signIn/controller.dart';

class EmailPattens extends StatelessWidget {
  final Function onSelect;
  const EmailPattens({this.onSelect, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInCtrl>(
        builder: (context, SignInCtrl controller, child) => Container(
              height: 295.w,
              width: 326.w,
              padding: EdgeInsets.only(left: 12.w),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: AppColor.primaryShadowTipShadow,
                  blurRadius: 3.5.w,
                )
              ]),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        this.onSelect(controller?.emailPatternList[index]);
                        controller.closeEmailTipPopup();
                      },
                      child: Padding(
                          padding: EdgeInsets.only(top: 12.w),
                          child: Text(
                            controller?.emailPatternList[index] ?? '',
                            style: TextStyle(
                                color: AppColor.primaryText, fontSize: 14.sp),
                          )));
                },
                itemCount: controller?.emailPatternList?.length ?? 0,
              ),
            ));
  }
}
