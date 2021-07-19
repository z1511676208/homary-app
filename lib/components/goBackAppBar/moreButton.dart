/*
 * @Author       : zhhjie
 * @Date         : 2021-07-27 15:53:52
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-27 16:30:27
 */
import 'package:homary/common/utils/main.dart';
import 'package:popover/popover.dart';

class MoreButton extends StatelessWidget {
  const MoreButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.only(right: 15.w, left: 5.w),
          child: Icon(Icons.more_horiz),
        ),
        onTap: () {
          showPopover(
              context: context,
              barrierColor: Colors.white.withAlpha(0),
              transitionDuration: const Duration(milliseconds: 150),
              bodyBuilder: (context) => const ListItems(),
              onPop: () {},
              arrowDxOffset: -10,
              width: 174.w,
              height: 188.5.w);
        },
      ),
    );
  }
}

class ListItems extends StatelessWidget {
  const ListItems({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List list = [
      {'title': 'Home', 'icon': Icon(Iconfont.Home)},
      {'title': 'Wishlist', 'icon': Icon(Iconfont.Collect)},
      {'title': 'Recently Viewed', 'icon': Icon(Iconfont.Recent)},
      {'title': 'Support', 'icon': Icon(Iconfont.Customer)}
    ];
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
            padding: EdgeInsets.symmetric(vertical: 10.w),
            children: list
                .map(
                  (e) => InkWell(
                      onTap: () {
                        print('#########');
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              left: 13.5.w, top: 10.w, bottom: 10.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              e['icon'],
                              SizedBox(
                                width: 12.5.w,
                              ),
                              Expanded(
                                  child: Text(
                                e['title'],
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: AppColor.primaryText),
                              ))
                            ],
                          ))),
                )
                .toList()),
      ),
    );
  }
}
