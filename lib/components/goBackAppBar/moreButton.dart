/*
 * @Author       : zhhjie
 * @Date         : 2021-07-27 15:53:52
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-23 17:35:37
 */
import 'package:homary/common/utils/localstorage.dart';
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
              transitionDuration: const Duration(milliseconds: 100),
              bodyBuilder: (context) => const ListItems(),
              onPop: () {},
              arrowDxOffset: -10,
              width: 174.w,
              height: 200.w);
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
      {'title': S.of(context).Home, 'icon': Icon(Iconfont.Home), 'url': '/'},
      {
        'title': S.of(context).usercenter_wishlists,
        'icon': Icon(Iconfont.Collect),
        'url': 'https://m.homary.com/usercenter/wishlists',
        'isNeedLogin': true
      },
      {
        'title': 'Recently Views',
        'icon': Icon(Iconfont.Recent),
        'url': 'https://m.homary.com/usercenter/viewed',
        'isNeedLogin': true
      },
      {
        'title': 'Support',
        'icon': Icon(Iconfont.Customer),
        'url': 'https://m.homary.com/appPages/customerService',
        'isNeedLogin': false
      }
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
                        String url = e['url'];
                        if (url.startsWith('https://')) {
                          bool isLogin = Localstorage().getBool('isLogin');
                          if (e['isNeedLogin'] && !isLogin) {
                            Routes.push(context, '/signIn');
                          } else {
                            Routes.push(context, '/webview', params: {
                              "showAppLoading": '0',
                              "content": '{"url":"$url"}'
                            });
                          }
                        } else {
                          Routes.goHome();
                        }
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
