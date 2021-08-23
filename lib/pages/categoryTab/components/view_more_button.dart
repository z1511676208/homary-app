/*
 * @Author       : zhhjie
 * @Date         : 2021-08-16 20:34:50
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-23 15:31:40
 */
import 'package:homary/common/utils/main.dart';

class ViewMoreButton extends StatelessWidget {
  const ViewMoreButton({Key key, this.isLoading = false, this.onLoadMore})
      : super(key: key);

  final bool isLoading;
  final Function onLoadMore;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      margin: EdgeInsets.only(top: 20.w, bottom: 10.w),
      child: OutlinedButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10.w)),
          side: MaterialStateProperty.all(
            BorderSide(
              color: AppColor.primaryBorderHard,
              width: 1.w,
            ),
          ),
        ),
        child: isLoading == false
            ? Text(
                S.of(context).home_viewMore,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColor.primaryText,
                ),
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
          if (isLoading) {
            return;
          }
          onLoadMore?.call();
        },
      ),
    );
  }
}
