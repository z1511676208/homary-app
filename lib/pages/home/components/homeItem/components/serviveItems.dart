/*
 * @Author       : JHao
 * @Date         : 2021-07-20 13:44:02
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-26 10:06:11
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/terms_of_service.dart';
import 'package:homary/entity/terms_of_service_detail.dart';
import 'package:homary/widget/networkImg.dart';

class ServiceItems extends StatelessWidget {
  const ServiceItems({Key key}) : super(key: key);

  Widget _item(String imgLink, String text, int index) {
    List<double> itemWidthList = [50.w, 55.w, 75.w, 75.w];
    return Container(
      margin: EdgeInsets.only(right: 12.w),
      child: Row(
        children: [
          CustomNetworkImage(
            imgLink,
            width: 24.w,
          ),
          SizedBox(
            width: 8.w,
          ),
          Container(
              width: itemWidthList[index],
              child: Text(
                text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12.sp, color: AppColor.serviceItemColor),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Selector<GlobalConfig, List<TermsOfService>>(
      builder: (BuildContext context, List<TermsOfService> data, child) {
        return data != null && data.length > 0
            ? Padding(
                padding: EdgeInsets.fromLTRB(4.w, 0.w, 4.w, 0),
                child: Container(
                    height: 30.w,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            sendGTMData({
                              "event": 'custom_click_ads',
                              "ecommerce": {
                                "event_label": data[index]?.eventLabel
                              }
                            });
                            Provider.of<GlobalConfig>(context, listen: false)
                                .getTermsDetail();
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.w),
                                  topRight: Radius.circular(8.w),
                                ),
                              ),
                              builder: (BuildContext _) {
                                return TermsDetail();
                              },
                            );
                          },
                          child: _item(
                              data[index].icon, data[index].title, index)),
                      itemCount: data.length,
                    )))
            : SizedBox();
      },
      selector: (BuildContext context, GlobalConfig global) {
        return global.termsOfService;
      },
      shouldRebuild: (pre, next) {
        return pre != next;
      },
    ));
  }
}

class TermsDetail extends StatelessWidget {
  const TermsDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          height: 0.8.sh,
          child: Selector<GlobalConfig, TermsOfServiceDetail>(
            builder: (BuildContext context, TermsOfServiceDetail data, child) {
              return data != null
                  ? Column(children: [
                      Container(
                        height: 50.w,
                        child: Stack(
                          children: [
                            Center(
                              child: Text(
                                data?.title ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 16.w),
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context, false),
                                  child: Image.asset(
                                    'assets/images/home/popup_close.png',
                                    width: 18.w,
                                    height: 18.w,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.w),
                              child: ListView.builder(
                                  itemBuilder: (context, index) => Column(
                                        children: [
                                          Row(
                                            children: [
                                              CustomNetworkImage(
                                                data.termsOfService[index].icon,
                                                width: 22.w,
                                              ),
                                              SizedBox(
                                                width: 6.w,
                                              ),
                                              Text(
                                                data.termsOfService[index]
                                                    .title,
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColor.primaryText),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8.w,
                                          ),
                                          HtmlWidget(
                                            data.termsOfService[index].content
                                                .join(''),
                                            textStyle: TextStyle(
                                                fontSize: 14.sp,
                                                color:
                                                    AppColor.primarySubTitle),
                                          ),
                                          SizedBox(
                                            height: 12.w,
                                          ),
                                        ],
                                      ),
                                  itemCount: data.termsOfService.length)))
                    ])
                  : SizedBox();
            },
            selector: (BuildContext context, GlobalConfig global) {
              return global.termsServiceDetail;
            },
            shouldRebuild: (pre, next) {
              return pre != next;
            },
          )),
    );
  }
}
