import 'package:homary/common/utils/main.dart';
import 'package:homary/pages/category/watcher.dart';

class ProductList extends StatelessWidget {
  ProductList({Key key}) : super(key: key);

  Widget _productItem(int idx) {
    /// product list
    List<Map<String, dynamic>> productInfo = Watcher.productList[idx]['info'];
    List<Widget> products = productInfo.map((element) {
      return Container(
          width: 65.w,
          margin: EdgeInsets.only(top: 14.5.h),
          child: Column(children: [
            Container(height: 65.w, width: 65.w, child: Placeholder()),
            SizedBox(height: 15.h),
            Text(element["name"],
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColor.primaryText, fontSize: 14.sp))
          ]));
    }).toList();
    return Container(
        padding: EdgeInsets.only(top: 20.h),
        width: 233.w,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  Watcher.productList[idx] != null
                      ? Watcher.productList[idx]['title']
                      : '',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10.5.h),
            Wrap(
              spacing: 14.w,
              children: products,
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return _productItem(index);
      }, childCount: Watcher.productList.length),
    );
  }
}
