/*
 * @Author       : zhhjie
 * @Date         : 2021-07-12 19:28:58
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-15 10:10:33
 */
import 'package:homary/common/utils/main.dart';

import 'noBorderExpansionTile/main.dart';

class ExpansionItem extends StatelessWidget {
  final List list;
  final String title;
  const ExpansionItem({Key key, this.list, this.title}) : super(key: key);

  Widget navItemChild(value, context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pop();
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
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      title: Text(
        title ?? '',
        style:
            TextStyle(color: AppColor.primaryText, fontWeight: FontWeight.bold),
      ),
      childrenPadding: EdgeInsets.only(left: 16),
      children: list?.map((e) => navItemChild(e, context))?.toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: navItem(context),
    );
  }
}
