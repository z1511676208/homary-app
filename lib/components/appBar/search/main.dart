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
        constraints: BoxConstraints(minHeight: 34.h),
        child: Container(
          height: 34.h,
          width: MediaQuery.of(context).size.width - 24.w,
          decoration: BoxDecoration(color: Colors.white),
          child: GestureDetector(
              child: TextField(
                enabled: false,
                maxLines: 1,
                cursorColor: Colors.orange,
                style: TextStyle(
                    color: AppColor.primaryBorderHard, fontSize: 14.sp),
                decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                    prefixIcon: Icon(Icons.search),
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
                    hintStyle: TextStyle(color: AppColor.primarySubTitle),
                    hintText: 'Find anything home...'),
              ),
              onTap: () => print('do some thing')),
        ));
  }
}
