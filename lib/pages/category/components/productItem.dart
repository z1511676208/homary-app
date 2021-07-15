/*
 * @Author       : JHao
 * @Date         : 2021-07-15 11:35:54
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-15 19:44:08
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/pages/category/watcher.dart';

class ProductItem extends StatefulWidget {
  final int idx;
  ProductItem(this.idx, {Key key}) : super(key: key);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  Widget _productItem() {
    /// product list
    List<Map<String, dynamic>> productInfo =
        Watcher.productList[widget.idx]['info'];
    List<Widget> products = productInfo.map((element) {
      return Container(
          width: 65.w,
          margin: EdgeInsets.only(bottom: 14.5.h),
          child: Column(children: [
            Container(height: 65.w, width: 65.w, child: Placeholder()),
            SizedBox(height: 4.h),
            Text(element["name"],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColor.primaryText, fontSize: 14.sp))
          ]));
    }).toList();
    return Container(
        padding: EdgeInsets.only(top: 16.w),
        decoration: BoxDecoration(
            border: widget.idx == Watcher.productList.length - 1
                ? null
                : Border(
                    bottom: BorderSide(
                        color: AppColor.primaryBorderOutline, width: 0.5.w))),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  Watcher.productList[widget.idx] != null
                      ? Watcher.productList[widget.idx]['title']
                      : '',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 16.w),
            Wrap(
              spacing: 24.5.w,
              children: products,
            )
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Watcher.productListItemHeight.length == Watcher.productList.length) {
        return;
      }
      double currentOffsetHeight = 0;
      double bannerHeight = 110.w; // 顶部banner
      double height = context.size.height;
      Watcher.productListItemHeight.add(height);
      int leng = Watcher.productListItemHeight.length;
      if (widget.idx == 0 && leng == 1) {
        currentOffsetHeight = height + bannerHeight;
      } else {
        for (var i = 0; i < widget.idx; i++) {
          currentOffsetHeight += Watcher.productListItemHeight[i];
        }
        currentOffsetHeight += height + bannerHeight;
      }
      Watcher.itemOffsetList.add(currentOffsetHeight);
      // print(topHeight);
      // print("productListItemHeight   ${Watcher.productListItemHeight}");
      // print("itemOffsetList   ${Watcher.itemOffsetList}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return _productItem();
  }
}
