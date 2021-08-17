/*
 * @Author       : JHao
 * @Date         : 2021-07-19 18:31:26
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-02 16:02:51
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/entity/homeAdvInfo.dart';
import 'package:homary/pages/home/components/homeItem/components/swiper_pagination.dart';
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
          child: Selector<HomeCtrl, AdvDatum>(
            builder: (BuildContext context, AdvDatum data, child) {
              return data?.moduleData != null && data?.moduleData?.length != 0
                  ? Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return CustomNetworkImage(
                          data.moduleData[index]?.imgUrl,
                          fit: BoxFit.cover,
                        );
                      },
                      itemCount: data.moduleData?.length,
                      pagination: new SwiperPagination(
                        builder: HomeSwiperPaginationBuilder(
                          color: Color(0x99FFFFFF),
                          activeColor: Colors.white,
                          size: Size(17.w,4.w),
                          activeSize: Size(17.w,4.w),
                          space: 3.w,
                        ),
                      ),
                      scrollDirection: Axis.horizontal,
                      autoplay: true,
                      autoplayDelay: 5000,
                      onTap: (index) {
                        handleSchema(context, data.moduleData[index]?.jumpUrl);
                      },
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
          ),
        ),
      ),
    );
  }
}
