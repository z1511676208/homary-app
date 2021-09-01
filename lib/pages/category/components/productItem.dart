/*
 * @Author       : JHao
 * @Date         : 2021-07-15 11:35:54
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-01 11:15:46
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/entity/category.dart';
import 'package:homary/pages/category/Watcher.dart';
import 'package:homary/pages/category/controller.dart';
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
      return GestureDetector(
        child: Container(
            width: 65.w,
            margin: EdgeInsets.only(bottom: 16.w),
            child: Column(children: [
              Container(
                  height: 65.w,
                  width: 65.w,
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: AppStyle.primaryBorderRaduis),
                  child: element.channelImgApp != ""
                      ? CustomNetworkImage(element.channelImgApp)
                      : Image.asset("assets/baseImage.png")),
              SizedBox(height: 4.h),
              Text(element.categoryName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: AppColor.primaryText, fontSize: 12.sp))
            ])),
        onTap: () {
          handleSchema(context, element.jumpUrl);
        },
      );
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
              child: GestureDetector(
                  onTap: () {
                    handleSchema(context, widget.subList[widget.idx].jumpUrl);
                  },
                  child: Text(
                      widget.subList[widget.idx] != null
                          ? widget.subList[widget.idx].categoryName
                          : '',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold))),
            ),
            SizedBox(height: 12.w),
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
        Map<String, String> categoryBannerMap =
            Provider.of<CategoryCtrl>(context, listen: false).categoryBannerMap;
        double currentOffsetHeight = 0;
        double bannerHeight = categoryBannerMap['app_category_banner'] != ""
            ? 102.w
            : 0; // 顶部banner
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
