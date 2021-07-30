/*
 * @Author       : JHao
 * @Date         : 2021-07-20 13:44:02
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-28 16:40:57
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/commonConfig.dart';
import 'package:homary/generated/l10n.dart';

class ServiceItems extends StatelessWidget {
  const ServiceItems({Key key}) : super(key: key);

  Widget _item(String imgLink, String text) {
    return Container(
      width: (1.sw - 24.w) / 3,
      child: Row(
        children: [
          Image.asset(
            imgLink,
            width: 16.w,
          ),
          SizedBox(
            width: 4.w,
          ),
          Expanded(
              child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12.sp, color: AppColor.primarySubTitle),
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Consumer<GlobalConfig>(
        //   builder: (BuildContext context, GlobalConfig data, child) {
        //     print(data.currentConfigList);
        //     return _item('assets/images/home/head_serve_off.png',
        //         'Get ${data?.commonAmountList?.couponNewuserAmountStr ?? ''} Off');
        //   },
        // ),
        Selector<GlobalConfig, CommonAmountList>(
          selector: (context, GlobalConfig globalConfig) {
            return globalConfig.commonAmountList;
          },
          shouldRebuild: (pre, next) {
            return pre != next;
          },
          builder: (context, CommonAmountList data, child) {
            print(data);
            return _item('assets/images/home/head_serve_off.png',
                '${S.of(context).HomePage_ServiceIcon1} ${data?.couponNewuserAmountStr ?? ''} Off');
          },
        ),
        _item('assets/images/home/head_serve_free.png',
            '${S.of(context).HomePage_ServiceIcon2}'),
        _item('assets/images/home/head_serve_return.png',
            '${S.of(context).HomePage_ServiceIcon3}')
      ],
    ));
  }
}
