/*
 * @Author       : JHao
 * @Date         : 2021-07-12 17:38:02
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-16 16:56:56
 */
import 'dart:convert';

import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/entity/topChannelCategory.dart';
import 'package:homary/pages/home/contorller.dart';
import 'controller.dart';
import 'components/leftNav.dart';
import 'components/rightListLayout.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryCtrl>(
            create: (context) => CategoryCtrl()),
        // ChangeNotifierProvider.value(value: PaymentCtrl())
      ],
      child: ProductListView(),
    );
  }
}

class ProductListView extends StatefulWidget {
  ProductListView({Key key}) : super(key: key);

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  var currentConfig;

  @override
  void didChangeDependencies() async {
    var current =
        jsonEncode(Provider.of<GlobalConfig>(context).currentConfig?.toJson());
    if (this.currentConfig != current) {
      // Toast.loading();
      this.currentConfig = current;
      Map<String, dynamic> channelMap =
          await Provider.of<HomeCtrl>(context, listen: false)
              .getTopChannelCategory();
      List<TopChannelDatum> topChannelList = channelMap['topChannelList'];
      Provider.of<CategoryCtrl>(context, listen: false)
          .setActiveCategoryId(topChannelList[0]?.categoryId);
      await Provider.of<CategoryCtrl>(context, listen: false).getCategoryList(
          params: {"category_id": topChannelList[0]?.categoryId ?? ""});
      // Toast.clear();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          LeftNav(),
          SizedBox(width: 12.w),
          // Selector<CategoryCtrl, String>(
          //   builder: (BuildContext context, String data, child) {
          //     return RightListLayout();
          //   },
          //   selector: (BuildContext context, CategoryCtrl categoryCtrl) {
          //     return categoryCtrl.activeCategoryId;
          //   },
          //   shouldRebuild: (pre, next) {
          //     return pre != next;
          //   },
          // ),
          RightListLayout()
        ],
      ),
    );
  }
}
