/*
 * @Author       : JHao
 * @Date         : 2021-07-23 09:57:34
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-23 10:03:05
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';

class ContentTitle extends StatelessWidget {
  final String title;
  final bool showViewAll;
  const ContentTitle({Key key, this.title, this.showViewAll = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Text(this.title,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryText)),
          Flexible(
            flex: 1,
            child: Container(),
          ),
          this.showViewAll == true
              ? GestureDetector(
                  onTap: () {
                    Routes.push(context, '/signIn?');
                  },
                  child: Row(
                    children: [
                      Text(
                        'View All',
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
      ),
    );
  }
}
