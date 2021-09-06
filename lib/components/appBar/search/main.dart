/*
 * @Author       : JHao
 * @Date         : 2021-07-07 20:04:36
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-09-01 17:50:56
 */
import 'package:homary/common/utils/main.dart';

class AppbarSearch extends StatefulWidget {
  final double marginTop;
  final String searchContent;
  AppbarSearch({Key key, this.marginTop, this.searchContent}) : super(key: key);

  @override
  _AppbarSearchState createState() => _AppbarSearchState();
}

class _AppbarSearchState extends State<AppbarSearch> {

  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.searchContent);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(minHeight: 34.w),
        child: Container(
          height: 34.w,
          margin: EdgeInsets.only(top: widget.marginTop ?? 6.w),
          width: MediaQuery.of(context).size.width - 24.w,
          decoration: BoxDecoration(color: Colors.white),
          child: GestureDetector(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4.w),
                      ),
                      border: Border.all(
                          color: AppColor.primaryBorderHard, width: 1.w)),
                  child: TextField(
                    controller: _controller,
                    textAlignVertical: TextAlignVertical.center,
                    enabled: false,
                    maxLines: 1,
                    cursorColor: AppColor.primaryColor,
                    style: TextStyle(
                        color: AppColor.primaryText, fontSize: 14.sp),
                    decoration: InputDecoration(
                        isCollapsed: true,
                        prefixIcon: Icon(
                          Iconfont.search,
                          size: 17.sp,
                          color: AppColor.primaryLightSubTitle,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle:
                            TextStyle(color: AppColor.primaryLightSubTitle),
                        hintText: S.of(context).search_findAnything),
                  )),
              onTap: () => Routes.push(context, '/search')),
        ));
  }
}
