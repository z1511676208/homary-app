/*
 * @Author       : JHao
 * @Date         : 2021-07-07 20:04:36
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-19 14:36:02
 */
import 'package:homary/common/utils/main.dart';

class AppbarSearch extends StatefulWidget {
  AppbarSearch({Key key}) : super(key: key);

  @override
  _AppbarSearchState createState() => _AppbarSearchState();
}

class _AppbarSearchState extends State<AppbarSearch> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(minHeight: 34.w),
        child: Container(
          height: 34.w,
          margin: EdgeInsets.only(top: 6.w),
          width: MediaQuery.of(context).size.width - 24.w,
          decoration: BoxDecoration(color: Colors.white),
          child: GestureDetector(
              child: TextField(
                enabled: false,
                maxLines: 1,
                cursorColor: AppColor.primaryColor,
                style: TextStyle(
                    color: AppColor.primaryBorderHard, fontSize: 14.sp),
                decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: EdgeInsets.only(top: 9.w),
                    prefixIcon: Icon(
                      Iconfont.search,
                      size: 18.sp,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2.w,
                        color: AppColor.primaryBorderHard,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: TextStyle(color: AppColor.primaryLightSubTitle),
                    hintText: 'Find anything home...'),
              ),
              onTap: () => Routes.push(context, '/search')),
        ));
  }
}
