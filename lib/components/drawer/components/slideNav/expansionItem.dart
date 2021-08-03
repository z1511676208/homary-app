/*
 * @Author       : zhhjie
 * @Date         : 2021-07-12 19:28:58
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-03 17:23:42
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/schema2path.dart';

import 'noBorderExpansionTile/main.dart';

class ExpansionItem extends StatelessWidget {
  final List list;
  final String title;
  final String jumpUrl;
  const ExpansionItem({Key key, this.list, this.title = '', this.jumpUrl})
      : super(key: key);

  Widget navItemChild(value, context) {
    return InkWell(
        onTap: () {
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
          padding: EdgeInsets.fromLTRB(0, 15.5.h, 0, 15.5.h),
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 0.5.w, color: AppColor.primaryBorderOutline))),
          child: Text(
            value?.categoryName,
            style: TextStyle(color: AppColor.primarySubTitle),
          ),
        ));
  }

  Widget navItem(context) {
    return NoBorderExpansionTile(
        showArrow: list.isNotEmpty,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Text(
          title,
          style: TextStyle(
              color: AppColor.primaryText, fontWeight: FontWeight.bold),
        ),
        childrenPadding: EdgeInsets.only(left: 16),
        children: list.map((e) => navItemChild(e, context))?.toList(),
        onExpansionChanged: (e) {
          print(e);
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
