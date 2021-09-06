import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/entity/product_res.dart';
import 'package:homary/pages/categoryTab/controller.dart';

class SeeAlso extends StatelessWidget {
  const SeeAlso({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<CategoryTabCtrl, List<SeeAlsoData>>(
      selector: (context, ctrl) => ctrl.seeAlsoList,
      builder: (context, value, _) {
        if (value == null || value.isEmpty) {
          return Container();
        }
        return Container(
          margin: EdgeInsets.only(
            left: 12.w,
            right: 12.w,
            top: 16.w,
            bottom: 4.w,
          ),
          child: Wrap(
            spacing: 12.w,
            runSpacing: 8.w,
            children: [
              Text(
                S.of(context).search_see_also,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColor.primaryText,
                ),
              ),
              ...value.map((e) => buildText(context, e)).toList(),
            ],
          ),
        );
      },
    );
  }

  Widget buildText(BuildContext context, SeeAlsoData data) {
    return GestureDetector(
      onTap: () {
        handleSchema(context, data.channelUrl);
      },
      child: Text(
        data.channelName,
        style: TextStyle(
          fontSize: 14.sp,
          color: AppColor.primaryColor,
        ),
      ),
    );
  }
}
