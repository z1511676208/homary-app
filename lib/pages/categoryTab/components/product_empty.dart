import 'package:homary/common/utils/main.dart';

class ProductEmptyWidget extends StatelessWidget {
  const ProductEmptyWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Image.asset(
            'assets/images/category/default_no_activity.png',
            width: 79.5.w,
            height: 79.5.w,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.5.w),
            child: Text(
              S.of(context).category_emptyProduct,
              style: TextStyle(
                fontSize: 11.sp,
                color: AppColor.primarySubTitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
