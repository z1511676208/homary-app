/*
 * @Author       : JHao
 * @Date         : 2021-07-23 09:57:34
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-20 18:40:15
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/generated/l10n.dart';

class ContentTitle extends StatelessWidget {
  final String title;
  final String moreJumpUrl;
  final String eventName;
  final String eventLabel;
  final bool showViewAll;
  const ContentTitle(
      {Key key,
      this.title,
      this.moreJumpUrl = "",
      this.showViewAll = true,
      this.eventName = "custom_click_ads",
      this.eventLabel = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 0.8.sw,
          child: Text(this.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryText)),
        ),
        Flexible(
          flex: 1,
          child: Container(),
        ),
        this.showViewAll == true &&
                this.moreJumpUrl != null &&
                this.moreJumpUrl != ""
            ? GestureDetector(
                onTap: () {
                  sendGTMData({
                    "event": this.eventName ?? "custom_click_ads",
                    "ecommerce": {"event_label": this.eventLabel ?? ''}
                  });
                  handleSchema(context, this.moreJumpUrl);
                },
                child: Row(
                  children: [
                    Text(
                      S.of(context).more,
                      style: TextStyle(
                          fontSize: 14.sp, color: AppColor.primaryText),
                    ),
                    Icon(
                      Iconfont.ArrowRight,
                      size: 12.w,
                      color: AppColor.primaryText,
                    ),
                  ],
                ),
              )
            : Text('')
      ],
    );
  }
}
