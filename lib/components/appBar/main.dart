/*
 * @Author       : zhhjie
 * @Date         : 2021-07-30 19:16:48
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-19 10:33:07
 */
import 'package:flutter/services.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/widget/cartAndNumber.dart';
import 'package:homary/widget/wishIconButton.dart';
import 'search/main.dart';

class GlobalAppbar extends StatelessWidget {
  const GlobalAppbar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          color: Colors.black,
                          icon: Icon(
                            Iconfont.More,
                          ),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Center(
                      child: Image.asset('assets/logo.png', width: 100),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Row(
                      children: [WishIconButton(), CartAndNumber()],
                    ),
                  ),
                ],
              ),
              AppbarSearch(heroTag: 'search',),
            ],
          ),
        ),
      ),
    );
  }
}
