/*
 * @Author       : zhhjie
 * @Date         : 2021-07-27 15:53:52
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-06 19:30:16
 */
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/dropMenu/bubble_shape.dart';
import 'package:homary/components/dropMenu/drop_menu.dart';

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
          DropMenuManager.instance.showDropDownMenu(
            context,
            id: 99,
            isShowShadow: false,
            menu: ListItems(),
            menuHeight: 180.w,
            marginTop:
                DropMenuManager.instance.getWeightMarginTop(context) + 42.w,
          );
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
      {
        'title': S.of(context).Home,
        'icon': Icon(Iconfont.More_home),
        'url': '/'
      },
      {
        'title': S.of(context).usercenter_wishlists,
        'icon': Icon(Iconfont.More_collect),
        'url': '/usercenter/wishlists',
        'isNeedLogin': true
      },
      {
        'title': S.of(context).appBar_recentyle_views,
        'icon': Icon(Iconfont.More_recent),
        'url': '/usercenter/viewed',
        'isNeedLogin': true
      },
      {
        'title': S.of(context).appBar_support,
        'icon': Icon(Iconfont.More_support),
        'url': 'https://m.homary.com/appPages/customerService',
        'isNeedLogin': false
      }
    ];
    return Container(
      width: 180.w,
      margin: EdgeInsets.only(left: 185.w),
      child: CustomPaint(
        painter: BubbleShape(),
        size: Size(180.w, 180.w),
        child: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 10.w),
              children: list
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        DropMenuManager.instance.hide();
                        String url = e['url'];
                        if (url.startsWith('https://')) {
                          bool isLogin =
                              Localstorage().getBool(StorageKey.IS_LOGIN);
                          if (e['isNeedLogin'] && !isLogin) {
                            Routes.push(context, '/signIn');
                          } else {
                            Routes.push(context, '/webview', params: {
                              "showAppLoading": '0',
                              "content": '{"url":"$url"}'
                            });
                          }
                        } else {
                          if (url == '/') {
                            Routes.goHome();
                          } else {
                            Routes.push(context, url);
                          }
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
                                  fontSize: 15.sp, color: AppColor.primaryText),
                            ))
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
