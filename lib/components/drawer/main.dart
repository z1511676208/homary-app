/*
 * @Author       : zhhjie
 * @Date         : 2021-07-06 10:11:04
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-09 18:58:52
 */

import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'components/slideNav/main.dart';
import 'components/navItem.dart';
import 'package:tuple/tuple.dart';
import 'controller.dart';

class GlobalDrawerView extends StatefulWidget {
  GlobalDrawerView({Key key}) : super(key: key);

  @override
  _GlobalDrawerViewState createState() => _GlobalDrawerViewState();
}

class _GlobalDrawerViewState extends State<GlobalDrawerView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SlideNavCtrl>(context, listen: false).getNavList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: Stack(
          children: [
            Selector<SlideNavCtrl, List>(
              selector: (context, SlideNavCtrl slideNavCtrl) {
                return slideNavCtrl.navList;
              },
              shouldRebuild: (pre, next) {
                return pre != next;
              },
              builder: (context, List data, child) {
                return ListView.builder(
                    itemBuilder: (context, index) {
                      return NavItem(index);
                    },
                    itemCount: data.length ?? 0);
              },
            ),
            Selector<SlideNavCtrl, Tuple2<bool, List>>(
              selector: (context, SlideNavCtrl slideNavCtrl) {
                return Tuple2(
                    slideNavCtrl.showSubList, slideNavCtrl.subNavList);
              },
              shouldRebuild: (pre, next) {
                return pre != next;
              },
              builder: (context, Tuple2<bool, List> data, child) {
                return SlideNav();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GlobalDrawer extends StatelessWidget {
  const GlobalDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SlideNavCtrl>(
          create: (context) => SlideNavCtrl(),
        )
      ],
      child: GlobalDrawerView(),
    );
  }
}
