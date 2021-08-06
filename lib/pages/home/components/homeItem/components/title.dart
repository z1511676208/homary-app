/*
 * @Author       : JHao
 * @Date         : 2021-07-23 09:57:34
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-06 15:03:04
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/generated/l10n.dart';

class ContentTitle extends StatelessWidget {
  final String title;
  final String moreJumpUrl;
  final bool showViewAll;
  const ContentTitle(
      {Key key, this.title, this.moreJumpUrl = "", this.showViewAll = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 0.76.sw,
          child: Text(this.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryText)),
        ),
        Flexible(
          flex: 1,
          child: Container(),
        ),
        this.showViewAll == true
            ? GestureDetector(
                onTap: () {
                  handleSchema(context, this.moreJumpUrl);
                },
                child: Row(
                  children: [
                    Text(
                      S.of(context).viewAll,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColor.primaryLightSubTitle),
                    ),
                    Icon(
                      Iconfont.ArrowRight,
                      size: 12.w,
                      color: AppColor.primaryLightSubTitle,
                    ),
                  ],
                ),
              )
            : Text('')
      ],
    );
  }
}
