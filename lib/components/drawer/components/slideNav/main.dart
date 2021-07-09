/*
 * @Author       : zhhjie
 * @Date         : 2021-07-07 15:43:25
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-09 18:46:41
 */
import 'package:homary/common/utils/main.dart';
import './noBorderExpansionTile/main.dart';
import '../../controller.dart';

class SlideNav extends StatefulWidget {
  SlideNav({Key key}) : super(key: key);

  @override
  _SlideNavState createState() => _SlideNavState();
}

class _SlideNavState extends State<SlideNav> {
  Widget navItemChild(value) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 13, 0, 13),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 0.5.w, color: AppColor.primaryBorderOutline))),
      child: Text(
        value?.categoryName,
        style: TextStyle(color: AppColor.primarySubTitle),
      ),
    );
  }

  Widget navItem(idx) {
    return Consumer<SlideNavCtrl>(
        builder: (BuildContext context, SlideNavCtrl slideNavCtrl, child) =>
            NoBorderExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text(
                slideNavCtrl?.subNavList[idx]?.categoryName ?? '',
                style: TextStyle(
                    color: AppColor.primaryText, fontWeight: FontWeight.bold),
              ),
              childrenPadding: EdgeInsets.only(left: 16),
              children: slideNavCtrl?.subNavList
                  ?.map((e) => navItemChild(e))
                  ?.toList(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SlideNavCtrl>(
        builder: (BuildContext context, SlideNavCtrl slideNavCtrl, child) =>
            AnimatedPositioned(
                left: slideNavCtrl.showSubList
                    ? 0.0
                    : -MediaQuery.of(context).size.width * 0.8,
                duration: Duration(milliseconds: 200),
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return navItem(index);
                    },
                    itemCount: slideNavCtrl?.subNavList?.length,
                  ),
                )));
  }
}
