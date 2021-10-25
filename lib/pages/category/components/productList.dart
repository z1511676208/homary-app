/*
 * @Author       : JHao
 * @Date         : 2021-07-21 10:31:45
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-19 15:40:24
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/category.dart';
import 'package:homary/pages/category/components/productItem.dart';

class ProductList extends StatelessWidget {
  final List<Data> subList;
  ProductList({Key key, this.subList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return ProductItem(
          this.subList,
          index,
          key: ValueKey(this.subList[index].categoryId),
        );
      }, childCount: this.subList.length),
    );
  }
}
