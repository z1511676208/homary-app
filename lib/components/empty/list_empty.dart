import 'package:homary/common/utils/main.dart';

class ListEmptyWidget extends StatelessWidget {
  const ListEmptyWidget({Key key, this.isShowGoHome = false, this.marginTop}) : super(key: key);

  final bool isShowGoHome;
  final double marginTop;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(height: marginTop),
          Image.asset(
            'assets/images/category/default_no_list.png',
            width: 80.w,
            height: 80.w,
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.w),
            child: Text(
              S.of(context).channel_emptyList,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColor.primaryText,
              ),
            ),
          ),
          Visibility(
            visible: isShowGoHome,
            child: Padding(
              padding: EdgeInsets.only(top: 24.w),
              child: SizedBox(
                width: 160.w,
                height: 44.w,
                child: ElevatedButton(
                  onPressed: () {
                    Routes.goHome();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                  ),
                  child: Text(
                    S.of(context).channel_returnHome,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
