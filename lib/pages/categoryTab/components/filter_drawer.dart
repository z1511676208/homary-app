import 'package:homary/common/utils/main.dart';
import 'package:homary/pages/categoryTab/components/filter_property.dart';
import 'package:homary/pages/categoryTab/controller.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({Key key}) : super(key: key);

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  @override
  Widget build(BuildContext context) {
    CategoryTabCtrl ctrl = context.watch<CategoryTabCtrl>();
    return Container(
      width: 336.w,
      child: Drawer(
        child: Scaffold(
          appBar: buildAppbar(context),
          body: ListView(
            children: ctrl.filterList.map((e) {
              return FilterProperty(productAttrMain: e);
            }).toList(),
          ),
          bottomNavigationBar: SafeArea(
            child: buildBottom(ctrl, context),
          ),
        ),
      ),
    );
  }

  Widget buildAppbar(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(48.w),
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Stack(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Iconfont.ArrowLeft),
                iconSize: 20.w,
              ),
              Align(
                child: Text(
                  S.of(context).category_filter,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Divider(
                  height: 0.5.w,
                  color: AppColor.primaryBorderBottomLine,
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildBottom(CategoryTabCtrl ctrl, BuildContext context) {
    return Container(
      height: 60.w,
      child: Column(
        children: [
          Divider(
            height: 8.w,
            color: AppColor.primaryBorderBottomLine,
          ),
          Container(
            width: 312.w,
            height: 44.w,
            margin: EdgeInsets.only(top: 5.w),
            child: ElevatedButton(
              onPressed: () {
                ctrl.applyFilter();
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor:
                      MaterialStateProperty.all(AppColor.primaryColor),
                  overlayColor:
                      MaterialStateProperty.all(AppColor.whiteBtnPressed),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36.0.w),
                    side: BorderSide(
                      width: 1.w,
                      color: AppColor.primaryColor,
                    ),
                  ))),
              child: Text(
                "View Results",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
