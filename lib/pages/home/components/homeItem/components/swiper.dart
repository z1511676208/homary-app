/*
 * @Author       : JHao
 * @Date         : 2021-07-19 18:31:26
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-23 15:40:29
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/pages/home/contorller.dart';
import 'package:homary/widget/networkImg.dart';

class BannerList extends StatelessWidget {
  BannerList({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(6.w),
      child: Container(
          height: 186.w,
          child: Selector<HomeCtrl, Module>(
            builder: (BuildContext context, Module data, child) {
              return data?.moduleData != null && data?.moduleData?.list != null
                  ? Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return CustomNetworkImage(
                          data.moduleData.list[index]?.imgUrl,
                          fit: BoxFit.cover,
                        );
                      },
                      itemCount: data.moduleData.list?.length,
                      pagination: new SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                        color: Color(0x99FFFFFF),
                        activeColor: Colors.white,
                      )),
                      scrollDirection: Axis.horizontal,
                      autoplay: true,
                      autoplayDelay: 5000,
                      onTap: (index) => print('点击了第$index个'),
                    )
                  : Image.asset(
                      'assets/baseImage.png',
                      fit: BoxFit.cover,
                    );
            },
            selector: (BuildContext context, HomeCtrl homeData) {
              return homeData.bannerList;
            },
            shouldRebuild: (pre, next) {
              return pre != next;
            },
          )),
    ));
  }
}
