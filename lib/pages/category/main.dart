/*
 * @Author       : JHao
 * @Date         : 2021-07-12 17:38:02
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-15 16:35:00
 */
import 'package:homary/common/utils/main.dart';
import 'controller.dart';
import 'components/leftNav.dart';
import 'components/rightListLayout.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductListCtrl>(
            create: (context) => ProductListCtrl()),
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
