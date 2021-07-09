/*
 * @Author       : zhhjie
 * @Date         : 2021-07-09 16:22:36
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-09 18:54:21
 */
import 'package:homary/common/utils/main.dart';
import 'package:hexcolor/hexcolor.dart';
import '../controller.dart';

class NavItem extends StatelessWidget {
  final int index;
  const NavItem(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SlideNavCtrl>(
        builder: (BuildContext context, SlideNavCtrl data, child) =>
            GestureDetector(
                onTap: () {
                  data.showSubList = true;
                  data.getSubList(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 0.5.w,
                              color: AppColor.primaryBorderOutline))),
                  padding: EdgeInsets.fromLTRB(0, 13, 10, 13),
                  margin: EdgeInsets.only(left: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        data?.navList[index]?.categoryName,
                        style: TextStyle(
                            color: HexColor(
                                data?.navList[index]?.fontColor ?? '#222222')),
                      )),
                      Offstage(
                        offstage: data?.navList[index].subList.isEmpty,
                        child: Icon(Icons.chevron_right),
                      )
                    ],
                  ),
                )));
  }
}
