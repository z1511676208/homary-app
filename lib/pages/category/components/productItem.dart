/*
 * @Author       : JHao
 * @Date         : 2021-07-15 11:35:54
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-30 18:37:59
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/category.dart';
import 'package:homary/pages/category/Watcher.dart';
import 'package:homary/widget/networkImg.dart';

class ProductItem extends StatefulWidget {
  final List<Data> subList;
  final int idx;
  ProductItem(this.subList, this.idx, {Key key}) : super(key: key);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  Widget _productItem() {
    /// product list
    List<Data> productInfo = widget.subList[widget.idx].subList;
    List<Widget> products = productInfo.map((element) {
      return Container(
          width: 65.w,
          margin: EdgeInsets.only(bottom: 14.5.h),
          child: Column(children: [
            Container(
                height: 65.w,
                width: 65.w,
                child: element.channelImgApp != ""
                    ? CustomNetworkImage(element.channelImgApp)
                    : Image.asset("assets/baseImage.png")),
            SizedBox(height: 4.h),
            Text(element.categoryName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColor.primaryText, fontSize: 14.sp))
          ]));
    }).toList();
    return Container(
        padding: EdgeInsets.only(top: 16.w),
        decoration: BoxDecoration(
            border: widget.idx == widget.subList.length - 1
                ? null
                : Border(
                    bottom: BorderSide(
                        color: AppColor.primaryBorderOutline, width: 0.5.w))),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  widget.subList[widget.idx] != null
                      ? widget.subList[widget.idx].categoryName
                      : '',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 16.w),
            Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 24.5.w,
                  children: products,
                ))
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        if (Watcher.productListItemHeight.length == widget.subList.length) {
          return;
        }
        double currentOffsetHeight = 0;
        double bannerHeight = 110.w; // 顶部banner
        double height = context?.size?.height;
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
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _productItem();
  }
}
