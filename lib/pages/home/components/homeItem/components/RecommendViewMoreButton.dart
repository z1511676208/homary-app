/*
 * @Author       : JHao
 * @Date         : 2021-07-23 18:00:04
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-23 15:31:52
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/pages/home/contorller.dart';
import 'package:tuple/tuple.dart';

class RecommendViewMoreButton extends StatelessWidget {
  const RecommendViewMoreButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<HomeCtrl, Tuple2<int, bool>>(
      builder: (BuildContext context, Tuple2<int, bool> data, child) {
        return data.item1 == 1
            ? SliverPadding(
                padding: EdgeInsets.fromLTRB(12.w, 20.w, 12.w, 20.w),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Container(
                      width: 100.w,
                      child: OutlinedButton(
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(vertical: 10.w)),
                          side: MaterialStateProperty.all(BorderSide(
                              color: AppColor.primaryBorderHard, width: 1.w)),
                        ),
                        child: data.item2 == false
                            ? Text(
                                S.of(context).home_viewMore,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColor.primaryText),
                              )
                            : SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: CircularProgressIndicator(
                                  color: AppColor.primaryText,
                                  strokeWidth: 2.w,
                                ),
                              ),
                        onPressed: () {
                          Provider.of<HomeCtrl>(context, listen: false)
                              .handleGetMoreProduct();
                        },
                      ),
                    ),
                  ),
                ),
              )
            : SliverToBoxAdapter(child: null);
      },
      selector: (BuildContext context, HomeCtrl homeData) {
        return Tuple2(homeData.hasMorePage, homeData.recommendLoading);
      },
      shouldRebuild: (pre, next) {
        return pre != next;
      },
    );
  }
}
