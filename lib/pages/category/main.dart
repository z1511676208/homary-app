/*
 * @Author       : JHao
 * @Date         : 2021-07-12 17:38:02
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-25 17:09:18
 */
import 'dart:convert';

import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/entity/main.dart';
import 'package:homary/entity/topChannelCategory.dart';
import 'package:homary/pages/category/watcher.dart';
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
  String currentConfig;

  @override
  void didChangeDependencies() async {
    CurrentConfig config = Provider.of<GlobalConfig>(context).currentConfig;
    var current = jsonEncode(config?.toJson());
    if (this.currentConfig != current) {
      Toast.loading();
      CategoryCtrl ctrl = Provider.of<CategoryCtrl>(context, listen: false);
      this.currentConfig = current;
      Watcher.refreshParams();
      await ctrl.getTopChannelCategory(params: {"category_type": 1});
      if (!mounted) {
        return;
      }
      ctrl.resetData(); // 切换语言或者币种 productItem不重新执行initState
      List<TopChannelDatum> topChannelList = ctrl.topChannelList;
      ctrl.setActiveCategoryId(topChannelList[0]?.categoryId);
      await ctrl.getCategoryList(
          params: {"category_id": topChannelList[0]?.categoryId ?? ""});

      Toast.clear();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [LeftNav(), SizedBox(width: 12.w), RightListLayout()],
      ),
    );
  }
}
