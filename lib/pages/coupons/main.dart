import 'package:homary/common/utils/main.dart';
import 'package:homary/components/goBackAppBar/main.dart';
import 'package:homary/pages/coupons/components/coupons_available.dart';
import 'package:homary/pages/coupons/components/coupons_unavailable.dart';
import 'package:homary/pages/coupons/controller.dart';
import 'package:homary/pages/home/components/tabBar/CustomUnderlineTabIndicator.dart';

class CouponsPage extends StatelessWidget {
  const CouponsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CouponsPageCtrl(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          appBar: GoBackAppBar(
            title: S.of(context).usercenter_coupons,
            showBorder: false,
          ),
          body: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                buildTabBar(),
                Expanded(
                  child: TabBarView(
                    children: [
                      CouponsAvailable(),
                      CouponsUnavailable(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTabBar() {
    return Builder(
      builder: (context) {
        return PhysicalModel(
          color: Colors.white,
          shadowColor: Color(0x30000000),
          elevation: 6.w,
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: TabBar(
              tabs: [
                Tab(
                  text: S.of(context).coupons_available(
                      context.select<CouponsPageCtrl, int>(
                          (value) => value.availableCount)),
                ),
                Tab(
                  text: S.of(context).coupons_unavailable(
                      context.select<CouponsPageCtrl, int>(
                          (value) => value.unavailableCount)),
                ),
              ],
              labelColor: AppColor.primaryColor,
              unselectedLabelColor: AppColor.primarySubTitle,
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Urbanist',
              ),
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Urbanist',
              ),
              indicator: CustomUnderlineTabIndicator(
                  width: 72.w,
                  insets: EdgeInsets.fromLTRB(0, 0, 0, 4.w),
                  borderSide: BorderSide(
                    color: AppColor.primaryColor,
                    width: 3.h,
                  ),
                  strokeCap: StrokeCap.round),
            ),
          ),
        );
      },
    );
  }
}
