import 'package:homary/common/utils/main.dart';
import 'package:homary/components/GoodsCard/goods_cart_grid.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/pages/shoppingCart/controller.dart';

class ShoppingCartJustForYou extends StatelessWidget {
  const ShoppingCartJustForYou({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ShoppingCartCtrl, List<ModuleDataProductList>>(
      selector: (_, ctrl) => ctrl.recommendList,
      builder: (_, value, __) {
        return value != null && value.length != 0
            ? GoodsCartSliverGrid(
                productList: value,
                showCorner: false,
                showSkuList: false,
                showFreeShipping: true,
                showRating: true,
                itemListName: 'Home - Recommend Goods',
                isShoppingCart: true,
              )
            : SliverToBoxAdapter(child: Container());
      },
    );
  }
}

class ShoppingCartJustForYouTitle extends StatelessWidget {
  const ShoppingCartJustForYouTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ShoppingCartCtrl, List<ModuleDataProductList>>(
      selector: (_, ctrl) => ctrl.recommendList,
      builder: (_, value, __) {
        return value != null && value.length != 0
            ? SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.w),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Text(
                        S.of(context).shopping_cart_just_for_you,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : SliverToBoxAdapter(child: Container());
      },
    );
  }
}
