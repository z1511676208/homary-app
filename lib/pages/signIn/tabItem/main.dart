import 'package:homary/common/utils/main.dart';


class TabItem extends StatelessWidget {
  final String title;
  final int tabNum;
  final int curTab;

  const TabItem(this.title, this.tabNum, this.curTab, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 6.h),
        Text(this.title,
            style: TextStyle(
                color: AppColor.primaryText,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold)),
        Offstage(
            offstage: this.curTab == this.tabNum ? false : true,
            child: Container(
              margin: EdgeInsets.only(top: 5.h),
              height: 2.5.h,
              width: 58.5.w,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
              ),
            ))
      ],
    );
  }
}
