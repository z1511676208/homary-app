/*
 * @Author       : JHao
 * @Date         : 2021-07-08 10:21:44
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-20 15:07:02
 */
import 'package:homary/common/utils/main.dart';

class LeftNav extends StatelessWidget {
  LeftNav({Key key}) : super(key: key);

  final List<String> _productList = [
    'Furniture',
    'Outdoor',
    'Bedding & Bath',
    'Lighting',
    'Kitchen',
    'Storage & Organization',
    'Renovation',
    'Decor & Rugs',
    'Baby & Kids',
    'Pet',
    'Furniture',
    'Lighting',
    'Storage & Organizat',
    'Kitchen & Renovation'
  ];

  Widget navItem(int idx) {
    return TextButton(
        onPressed: () {},
        child: Container(
          height: 52.h,
          padding: EdgeInsets.only(left: 12.w, right: 12.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(_productList[idx],
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                )),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 103.w,
      color: AppColor.primaryNavBgColor,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return navItem(index);
        },
        itemCount: _productList.length,
        // itemExtent: 52.h,
      ),
    );
  }
}
