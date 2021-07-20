/*
 * @Author       : zhhjie
 * @Date         : 2021-07-09 16:22:36
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-27 15:16:01
 */
import 'package:homary/common/utils/main.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controller.dart';

class NavItem extends StatelessWidget {
  final int index;
  final String title;
  final Widget subTitle; //副标题
  final Widget trailing; //图标
  final List subList;
  final bool isConfig; //判断是是否是配置菜单点击 1是0否
  final int configType;
  const NavItem({
    Key key,
    this.title,
    this.subTitle,
    this.index,
    this.trailing,
    this.subList,
    this.isConfig,
    this.configType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Provider.of<SlideNavCtrl>(context, listen: false)
              .setSubList(subList, title);
          if (subList == null || subList.isEmpty) {
            Navigator.of(context).pop();
          } else {
            Provider.of<SlideNavCtrl>(context, listen: false).subListToggle();
          }
          if (isConfig) {
            Provider.of<SlideNavCtrl>(context, listen: false)
                .setConfig(configType);
          }
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 0.5.w, color: AppColor.primaryBorderOutline))),
          padding: EdgeInsets.only(top: 14.h, bottom: 14.h),
          margin: EdgeInsets.only(left: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Offstage(
                        offstage: trailing == null,
                        child: Container(
                          margin: EdgeInsets.only(right: 17.w),
                          child: trailing,
                        ),
                      ),
                      Consumer<GlobalConfig>(
                        builder:
                            (BuildContext context, GlobalConfig data, child) =>
                                Text(
                          index != null
                              ? data?.navList[index]?.categoryName
                              : title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: HexColor(index != null &&
                                    data?.navList[index]?.fontColor != null
                                ? data?.navList[index]?.fontColor
                                : '#222222'),
                          ),
                        ),
                      )
                    ],
                  ),
                  Offstage(
                    offstage: subTitle == null,
                    child: subTitle,
                  )
                ],
              )),
              Container(
                margin: EdgeInsets.only(right: 16.w),
                child: Offstage(
                  offstage: subList == null || subList.isEmpty,
                  child: Icon(
                    Icons.chevron_right,
                    color: AppColor.primaryBorderLight,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
