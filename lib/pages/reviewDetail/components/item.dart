/*
 * @Author       : JHao
 * @Date         : 2021-07-26 15:28:09
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-20 11:05:13
 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/entity/homeReviewModule.dart';
import 'package:homary/widget/networkImg.dart';
import 'package:homary/common/utils/main.dart';

class ReviewItem extends StatelessWidget {
  final ReviewList data;
  const ReviewItem({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        CustomNetworkImage(
          this.data.imgUrl,
          width: 1.sw,
          height: 1.sw,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(12.w, 12.w, 12.w, 22.w),
          padding: EdgeInsets.fromLTRB(6.w, 6.w, 12.w, 6.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(2.w)),
            color: AppColor.primaryBackground,
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(2.w)),
                child: this.data.productImage == ""
                    ? Image.asset(
                        'assets/baseImage.png',
                        width: 72.w,
                        height: 72.w,
                        fit: BoxFit.cover,
                      )
                    : CustomNetworkImage(
                        this.data.productImage,
                        width: 72.w,
                        height: 72.w,
                      ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                  child: Column(
                children: [
                  Text(
                    this.data.title,
                    style: TextStyle(
                        color: AppColor.primaryText,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 8.w,
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: RatingBarIndicator(
                          rating: this.data.score == ""
                              ? 0
                              : double.parse(this.data.score.toString()),
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Color(0xFFFFB400),
                          ),
                          unratedColor: Color(0xFFE3E3E3),
                          itemCount: 5,
                          itemSize: 22.w,
                          direction: Axis.horizontal,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        this.data.score == ''
                            ? '0'
                            : double.parse(this.data.score.toString())
                                .toStringAsFixed(1),
                        style: TextStyle(
                            color: AppColor.primaryText,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(),
                      ),
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.w))),
                          padding: EdgeInsets.fromLTRB(12.w, 4.w, 12.w, 4.w),
                          child: Text('Buy Now',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                        onTap: () {
                          handleSchema(context, this.data.jumpUrl);
                        },
                      )
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            this.data.content,
            style: TextStyle(fontSize: 14.sp, color: AppColor.primaryText),
          ),
        ),
        Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: this.data.headImg != ""
                      ? CustomNetworkImage(this.data.headImg,
                          width: 24.w, height: 24.w)
                      : Container(
                          width: 24.w,
                          height: 24.w,
                          color: AppColor.primaryText,
                          alignment: Alignment.center,
                          child: Text(
                            this.data.username.substring(0, 1),
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.sp),
                          ),
                        ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.data.username,
                      style: TextStyle(
                          color: AppColor.primaryText,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      this.data.job,
                      style: TextStyle(
                          color: AppColor.primaryText, fontSize: 12.sp),
                    )
                  ],
                ))
              ],
            )),
      ],
    ));
  }
}
