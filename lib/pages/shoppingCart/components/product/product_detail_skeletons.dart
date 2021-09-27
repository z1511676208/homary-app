/*
 * @Author       : JHao
 * @Date         : 2021-09-24 13:55:32
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-01 01:59:51
 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skeletons/skeletons.dart';
import 'package:homary/common/utils/main.dart';

class ProductDetailSkeletons extends StatelessWidget {
  const ProductDetailSkeletons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(color: Colors.white),
      child: SkeletonItem(
          child: Column(
        children: [
          SkeletonAvatar(
            style: SkeletonAvatarStyle(
              width: 1.sw - 32.w,
              height: 1.sw - 32.w,
            ),
          ),
          SkeletonParagraph(
            style: SkeletonParagraphStyle(
                lines: 4,
                spacing: 6,
                lineStyle: SkeletonLineStyle(
                    height: 16.w,
                    borderRadius: BorderRadius.circular(6),
                    width: 1.sw)),
          ),
          SkeletonParagraph(
            style: SkeletonParagraphStyle(
                lines: 2,
                spacing: 6,
                padding: EdgeInsets.symmetric(horizontal: 8),
                lineStyle: SkeletonLineStyle(
                    randomLength: true,
                    height: 16.w,
                    borderRadius: BorderRadius.circular(6),
                    maxLength: 0.7.sw,
                    minLength: 0.5.sw)),
          ),
        ],
      )),
    );
  }
}
