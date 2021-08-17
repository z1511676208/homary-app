/*
 * @Author       : zhhjie
 * @Date         : 2021-07-09 16:22:36
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-26 10:41:30
 */
import 'package:homary/common/utils/main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:homary/common/utils/schema2path.dart';

import '../controller.dart';

class NavItem extends StatelessWidget {
  final int index;
  final String title;
  final Widget subTitle; //副标题
  final Widget trailing; //图标
  final List subList;
  final bool isConfig; //判断是是否是配置菜单点击 1是0否
  final int configType;
  final String jumpUrl;
  final Function onTap;
  final bool showArrow;
  final EdgeInsets margin;
  final EdgeInsets padding;
  const NavItem(
      {Key key,
      this.title,
      this.subTitle,
      this.index,
      this.trailing,
      this.subList,
      this.isConfig,
      this.configType,
      this.jumpUrl,
      this.onTap,
      this.showArrow = true,
      this.margin,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (onTap == null) {
            Provider.of<SlideNavCtrl>(context, listen: false)
                .setSubList(subList, title);
            if (subList == null || subList.isEmpty) {
              Navigator.pop(context);
              handleSchema(context, this.jumpUrl, appBarTitle: title);
            } else {
              Provider.of<SlideNavCtrl>(context, listen: false).subListToggle();
            }
            if (isConfig) {
              Provider.of<SlideNavCtrl>(context, listen: false)
                  .setConfig(configType);
            }
          } else {
            onTap();
          }
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 0.5.w, color: AppColor.primaryBorderOutline))),
          padding: this.padding ?? EdgeInsets.only(top: 14.h, bottom: 14.h),
          margin: this.margin ?? EdgeInsets.only(left: 16.w),
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
                            (BuildContext context, GlobalConfig data, child) {
                          return Text(
                            index != null
                                ? data?.navList[index]?.categoryName
                                : title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: index != null &&
                                        data?.navList[index]?.fontColor != null
                                    ? HexColor(data?.navList[index]?.fontColor)
                                    : AppColor.primaryText),
                          );
                        },
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
                margin: EdgeInsets.only(right: 16.w, left: 4.w),
                child: Offstage(
                  offstage: !showArrow,
                  child: Icon(
                    Iconfont.ArrowRight,
                    color: AppColor.primaryBorderLight,
                    size: 12.w,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
