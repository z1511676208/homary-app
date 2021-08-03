/*
 * @Author       : zhhjie
 * @Date         : 2021-07-07 15:43:25
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-03 14:43:14
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/drawer/components/configNav/configItem.dart';
import 'package:homary/widget/networkImg.dart';
import '../../controller.dart';
import 'expansionItem.dart';

class SlideNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SlideNavCtrl>(
        builder: (BuildContext context, SlideNavCtrl slideNavCtrl, child) =>
            AnimatedPositioned(
                left: slideNavCtrl.showSubList
                    ? 0.0
                    : -MediaQuery.of(context).size.width * 0.8,
                duration: Duration(milliseconds: 200),
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: SafeArea(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 13.h, bottom: 13.h),
                              width: double.infinity,
                              child: Text(slideNavCtrl?.subTitle ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColor.primaryText,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Positioned(
                              left: 0,
                              top: 2.h,
                              child: IconButton(
                                  onPressed: () {
                                    slideNavCtrl.subListToggle();
                                  },
                                  iconSize: 30,
                                  color: AppColor.primaryText,
                                  icon: Icon(Icons.chevron_left)),
                            )
                          ],
                        ),
                        Container(
                          color: AppColor.primaryBackground,
                          child: SizedBox(
                            height: 12.h,
                            width: double.infinity,
                          ),
                        ),
                        Flexible(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return slideNavCtrl.isConfigSecondary
                                  ? Container(
                                      margin: EdgeInsets.only(left: 16.w),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 0.5.w,
                                                  color: AppColor
                                                      .primaryBorderOutline))),
                                      child: ConfigItem(
                                        trailing: slideNavCtrl.configType == 1
                                            ? CustomNetworkImage(
                                                slideNavCtrl?.subNavList[index]
                                                    ?.iconUrl,
                                                height: 15.h,
                                                width: 22.w,
                                              )
                                            : Text(''),
                                        title: slideNavCtrl?.configType == 1
                                            ? slideNavCtrl
                                                ?.subNavList[index]?.siteName
                                            : slideNavCtrl?.configType == 2
                                                ? slideNavCtrl
                                                    ?.subNavList[index]?.name
                                                : slideNavCtrl
                                                    ?.subNavList[index]?.enName,
                                        configType: slideNavCtrl?.configType,
                                        configData:
                                            slideNavCtrl?.subNavList[index],
                                      ))
                                  : ExpansionItem(
                                      list: slideNavCtrl
                                          ?.subNavList[index]?.subList,
                                      jumpUrl: slideNavCtrl
                                          ?.subNavList[index]?.jumpUrl,
                                      title: slideNavCtrl
                                          ?.subNavList[index]?.categoryName);
                            },
                            itemCount: slideNavCtrl?.subNavList?.length,
                          ),
                        )
                      ],
                    ),
                  ),
                )));
  }
}
