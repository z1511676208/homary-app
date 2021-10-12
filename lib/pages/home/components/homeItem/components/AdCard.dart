/*
 * @Author       : JHao
 * @Date         : 2021-10-12 15:40:35
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-14 16:13:42
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/widget/networkImg.dart';

class AdCard extends StatelessWidget {
  final double width;
  final double imageHeight;
  final double textHeight;
  final bool isLastCard;
  final String adImageUrl;
  final String adText;
  final String jumpUrl;
  final String eventLabel;
  const AdCard(
      {Key key,
      @required this.imageHeight,
      @required this.textHeight,
      @required this.adText,
      @required this.adImageUrl,
      this.isLastCard = false,
      this.jumpUrl,
      this.width = double.infinity,
      this.eventLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: width,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(right: this.isLastCard ? 0 : 12.w),
        decoration: BoxDecoration(
          borderRadius: AppStyle.borderRaduis8,
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryBorderShadow,
              blurRadius: 6.w,
              spreadRadius: 1.w,
              offset: Offset(0.w, 2.w),
            )
          ],
        ),
        child: Column(
          children: [
            CustomNetworkImage(this.adImageUrl,
                width: double.infinity, height: this.imageHeight),
            Container(
              width: double.infinity,
              height: this.textHeight,
              padding: EdgeInsets.all(8.w),
              color: Colors.white,
              alignment: Alignment.centerLeft,
              child: Text(
                this.adText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.sp, color: AppColor.primaryText),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        sendGTMData({
          "event": 'custom_click_ads',
          "ecommerce": {"event_label": this.eventLabel ?? ''}
        });
        handleSchema(context, this.jumpUrl);
      },
    );
  }
}
