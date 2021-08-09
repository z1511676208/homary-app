import 'package:homary/common/utils/main.dart';

class GoTopMenu extends StatelessWidget {
  const GoTopMenu({Key key, this.scrollController}) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Routes.push(context, '/webview', params: {
              "needLogin": '0',
              "source": "",
              "content": '{"url":"https://m.homary.com/AppCustomerService"}'
            });
          },
          child: Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryBorderShadow,
                  blurRadius: 5.w,
                  spreadRadius: 1.w,
                  offset: Offset(0.w, 2.w),
                )
              ],
            ),
            child: Icon(
              Iconfont.Customer,
              color: AppColor.primaryText,
              size: 26.sp,
            ),
          ),
        ),
        SizedBox(
          height: 8.w,
        ),
        GestureDetector(
          onTap: (){
            scrollController.animateTo(0,
                duration: Duration(milliseconds: 200), curve: Curves.easeIn);
          },
          child: Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryBorderShadow,
                  blurRadius: 5.w,
                  spreadRadius: 1.w,
                  offset: Offset(0.w, 2.w),
                )
              ],
            ),
            child: Icon(
              Iconfont.ArrowUp,
              color: AppColor.primaryText,
              size: 20.sp,
            ),
          ),
        ),
      ],
    );
  }
}
