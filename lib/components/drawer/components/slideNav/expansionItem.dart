/*
 * @Author       : zhhjie
 * @Date         : 2021-07-12 19:28:58
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-26 13:44:33
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/schema2path.dart';

import 'noBorderExpansionTile/main.dart';

class ExpansionItem extends StatelessWidget {
  final List list;
  final String title;
  final String jumpUrl;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final BoxBorder childBorder;
  final Color iconColor;
  final bool needPop;
  final Icon icon;
  final TextStyle childrenStyle;
  final EdgeInsets childrenPadding;
  final bool showTickerModeBottomBorder;
  const ExpansionItem(
      {Key key,
      this.list,
      this.title = '',
      this.jumpUrl,
      this.padding,
      this.margin,
      this.childBorder,
      this.iconColor,
      this.needPop = true,
      this.icon,
      this.childrenStyle,
      this.showTickerModeBottomBorder = false,
      this.childrenPadding})
      : super(key: key);

  Widget navItemChild(value, context) {
    return InkWell(
        onTap: () {
          if (this.needPop) {
            Navigator.pop(context);
          }
          if (value != null && value.jumpUrl.contains('webview')) {
            handleSchema(context, value.jumpUrl,
                appBarTitle: value?.categoryName);
          } else {
            Routes.push(context, '/webview', params: {
              "appBarTitle": value?.categoryName,
              "content": '{"url":"${value.jumpUrl}"}'
            });
          }
        },
        child: Container(
          padding: childrenPadding ?? EdgeInsets.fromLTRB(0, 15.5.h, 0, 15.5.h),
          width: double.infinity,
          decoration: BoxDecoration(
              border: childBorder ??
                  Border(
                      bottom: BorderSide(
                          width: 0.5.w, color: AppColor.primaryBorderOutline))),
          child: Text(
            value?.categoryName,
            style: childrenStyle ?? TextStyle(color: AppColor.primarySubTitle),
          ),
        ));
  }

  Widget navItem(context) {
    return NoBorderExpansionTile(
        showTickerModeBottomBorder: this.showTickerModeBottomBorder,
        icon: this.icon,
        iconColor: this.iconColor,
        tileMargin: this.margin,
        tilePadding: this.padding,
        showArrow: list.isNotEmpty,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Text(
          title,
          style: TextStyle(
              color: AppColor.primaryText, fontWeight: FontWeight.bold),
        ),
        childrenPadding: EdgeInsets.only(left: 16.w),
        children: list.map((e) => navItemChild(e, context))?.toList(),
        onExpansionChanged: (e) {
          //没有第三级菜单点击直接跳转
          if (list.isEmpty) {
            handleSchema(context, this.jumpUrl, appBarTitle: title);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: navItem(context),
    );
  }
}
