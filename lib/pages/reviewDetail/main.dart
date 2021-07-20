/*
 * @Author       : JHao
 * @Date         : 2021-07-26 10:13:01
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-26 16:28:01
 */
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/pages/home/contorller.dart';
import 'package:homary/pages/reviewDetail/components/item.dart';
import 'package:homary/widget/networkImg.dart';

class ReviewsDetail extends StatelessWidget {
  final String index;
  const ReviewsDetail({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SwiperController _controller = new SwiperController();
    return Scaffold(
        body: SafeArea(
      child: Selector<HomeCtrl, Module>(
        builder: (BuildContext context, Module data, child) {
          // print(data?.moduleData?.reviewList);
          return data?.moduleData != null &&
                  data?.moduleData?.reviewList != null
              ? Stack(
                  children: [
                    Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return ReviewItem(
                          data: data.moduleData.reviewList[index],
                        );
                      },
                      index: int.parse(this.index),
                      itemCount: data.moduleData.reviewList?.length,
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
          print(homeData.reviewList);
          return homeData.reviewList;
        },
        shouldRebuild: (pre, next) {
          return pre != next;
        },
      ),
    ));
  }
}
