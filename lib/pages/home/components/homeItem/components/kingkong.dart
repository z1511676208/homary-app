/*
 * @Author       : JHao
 * @Date         : 2021-07-20 15:12:17
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-25 17:16:52
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/entity/homeAdvInfo.dart';
import 'package:homary/pages/home/components/homeItem/components/title.dart';
import 'package:homary/widget/networkImg.dart';

class KingKong extends StatelessWidget {
  final AdvDatum data;
  final bool showTitle;
  final double paddingTop;
  const KingKong(
      {Key key, @required this.data, this.showTitle = true, this.paddingTop})
      : super(key: key);

  Widget _item(BuildContext context, ModuleAdvDatum item) {
    return GestureDetector(
        child: Container(
            child: Row(children: [
          Container(
              width: 50.w,
              height: 50.w,
              child: CustomNetworkImage(
                item.imgUrl,
                width: 50.w,
                height: 50.w,
              )),
          SizedBox(width: 8.w),
          Expanded(
              child: Text(
            item.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 13.sp, color: AppColor.primaryText),
          )),
          SizedBox(
            width: 8.w,
          )
        ])),
        onTap: () {
          sendGTMData({
            "event": 'custom_click_ads',
            "ecommerce": {"event_label": item.eventLabel ?? ''}
          });
          handleSchema(context, item.jumpUrl);
        });
  }

  @override
  Widget build(BuildContext context) {
    return data?.moduleData != null && data?.moduleData?.length != 0
        ? Padding(
            padding:
                EdgeInsets.fromLTRB(12.w, this.paddingTop ?? 28.w, 12.w, 16.w),
            child: Column(
              children: [
                this.showTitle
                    ? ContentTitle(
                        title: data.title,
                        showViewAll: false,
                      )
                    : SizedBox(),
                SizedBox(
                  height: 12.w,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data.moduleData.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.w,
                    // crossAxisSpacing: 20.w,
                    childAspectRatio: ((1.sw - 24.w) / 2) / 50.w,
                  ),
                  itemBuilder: (context, index) {
                    return _item(context, data.moduleData[index]);
                  },
                ),
              ],
            ))
        : Container();
  }
}
