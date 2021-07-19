/*
 * @Author       : zhhjie
 * @Date         : 2021-07-23 17:28:26
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-28 15:03:03
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/generated/l10n.dart';
import 'slideNav/noBorderExpansionTile/main.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key key}) : super(key: key);

  Widget contactUsItem(String label, String content, String introduction) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(style: TextStyle(fontSize: 13.sp), children: [
              TextSpan(
                  text: label,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryText)),
              TextSpan(
                  text: content,
                  style: TextStyle(color: AppColor.primarySubTitle))
            ])),
            Text(introduction,
                style: TextStyle(
                    color: AppColor.primarySubTitle, fontSize: 13.sp)),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    List list = [];
    for (var i = 0; i < 3; i++) {
      list.add({
        "label": S.of(context).bottom_contact_label.split('|')[i],
        "content": S.of(context).bottom_contact_content.split('|')[i],
        "introduction": S.of(context).bottom_contact_introduction.split('|')[i]
      });
    }
    return SliverToBoxAdapter(
        child: Container(
      color: AppColor.primaryBackground,
      child: NoBorderExpansionTile(
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: EdgeInsets.only(left: 14.w, top: 4.w, bottom: 4.w),
        title: Container(
          color: AppColor.primaryBackground,
          child: Text(
            S.of(context).bottom_contact_title,
            style: TextStyle(
                fontSize: 13.sp,
                color: AppColor.primaryText,
                fontWeight: FontWeight.bold),
          ),
        ),
        children: list
            .map((e) =>
                contactUsItem(e['label'], e['content'], e['introduction']))
            .toList(),
      ),
    ));
  }
}
