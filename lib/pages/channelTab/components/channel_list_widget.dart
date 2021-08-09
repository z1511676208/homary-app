import 'package:homary/common/utils/main.dart';
import 'package:homary/pages/channelTab/controller.dart';
import 'package:homary/widget/networkImg.dart';
import 'package:homary/entity/topic_flow_res.dart';

class ChannelListWidget extends StatelessWidget {
  const ChannelListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChannelTabCtrl ctrl = context.watch<ChannelTabCtrl>();
    if(ctrl.channelList.isEmpty){
      return SliverToBoxAdapter();
    }
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 8.w,
              left: 12.w,
              bottom: 16.w,
            ),
            child: Text(
              'Shop by department',
              style: TextStyle(
                color: AppColor.primaryText,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 100.w,
            child: ListView.builder(
              itemCount: ctrl.channelList.length,
              padding: EdgeInsets.only(top: 8.w),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return buildItem(context, ctrl.channelList[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, ChannelList channel, int index) {
    return GestureDetector(
      onTap: () {
        context.read<ChannelTabCtrl>().changeChannel(index);
      },
      child: Container(
        width: 88.w,
        child: Column(
          children: [
            Stack(
              children: [
                ClipOval(
                  child: Container(
                    color: AppColor.primaryBackground,
                    child: CustomNetworkImage(
                      channel.imgUrl,
                      width: 57.w,
                      height: 57.w,
                    ),
                  ),
                ),
                Container(
                  width: 57.w,
                  height: 57.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: channel.isSelected == 1
                          ? AppColor.primaryColor
                          : Colors.transparent,
                      width: 0.5.w,
                    ),
                    borderRadius: BorderRadius.circular(57.w / 2),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.5.w),
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  Text(
                    channel.channelName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: channel.isSelected == 1
                          ? AppColor.primaryColor
                          : AppColor.primaryText,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
