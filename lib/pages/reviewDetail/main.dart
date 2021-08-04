/*
 * @Author       : JHao
 * @Date         : 2021-07-26 10:13:01
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-04 14:40:34
 */
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/homeReviewModule.dart';
import 'package:homary/pages/home/contorller.dart';
import 'package:homary/pages/reviewDetail/components/item.dart';

class ReviewsDetail extends StatelessWidget {
  final String index;
  const ReviewsDetail({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SwiperController _controller = new SwiperController();
    return Scaffold(
        body: SafeArea(
      child: Selector<HomeCtrl, ReviewData>(
        builder: (BuildContext context, ReviewData data, child) {
          return data != null &&
                  data?.reviewList != null &&
                  data.reviewList.length > 0
              ? Stack(
                  children: [
                    Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return ReviewItem(
                          data: data.reviewList[index],
                        );
                      },
                      index: int.parse(this.index),
                      itemCount: data.reviewList?.length,
                      scrollDirection: Axis.horizontal,
                      autoplay: false,
                      controller: _controller,
                      onTap: (index) {},
                    ),
                    Positioned(
                        left: 12.w,
                        top: 0.5.sw - 16.w,
                        child: GestureDetector(
                          child: ClipOval(
                            child: Container(
                              alignment: Alignment.center,
                              child: Icon(
                                Iconfont.ArrowRight,
                                size: 16.sp,
                                color: Colors.white,
                                textDirection: TextDirection.rtl,
                              ),
                              width: 32.w,
                              height: 32.w,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                          onTap: () {
                            _controller.previous();
                          },
                        )),
                    Positioned(
                        right: 12.w,
                        top: 0.5.sw - 16.w,
                        child: GestureDetector(
                          child: ClipOval(
                            child: Container(
                              alignment: Alignment.center,
                              child: Icon(
                                Iconfont.ArrowRight,
                                size: 16.sp,
                                color: Colors.white,
                              ),
                              width: 32.w,
                              height: 32.w,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                          onTap: () {
                            _controller.next();
                          },
                        )),
                    Positioned(
                        top: 12.w,
                        right: 12.w,
                        child: GestureDetector(
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                          onTap: () {
                            Routes.pop();
                          },
                        ))
                  ],
                )
              : Container();
        },
        selector: (BuildContext context, HomeCtrl homeData) {
          return homeData.reviewList;
        },
        shouldRebuild: (pre, next) {
          return pre != next;
        },
      ),
    ));
  }
}
