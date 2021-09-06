import 'package:exposure/exposure.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/GoodsCard/main.dart';
import 'package:homary/entity/home.dart';

class GoodsCartSliverGrid extends StatelessWidget {
  const GoodsCartSliverGrid({
    Key key,
    @required this.productList,
    this.onExposure,
    this.showCorner = false,
    this.showSkuList = false,
    this.showFreeShipping = false,
    this.showRating = false,
    this.showDispatch = false,
  }) : super(key: key);

  final List<ModuleDataProductList> productList;

  final Function(List<Map> list) onExposure;

  final bool showCorner; // 是否显示角标
  final bool showSkuList; // 是否显示 sku 切换列表
  final bool showFreeShipping; // 是否显示Free Shipping
  final bool showRating; // 是否显示评分
  final bool showDispatch; // 是否显示48小时配送

  @override
  Widget build(BuildContext context) {
    ExposureDetectorController.instance.exposureTime = 100; //设置曝光时长 (ms)
    ExposureDetectorController.instance.exposureFraction = 0.5; // 设置曝光比例
    ExposureDetectorController.instance.updateInterval =
        Duration(milliseconds: 200); // 设置延时检测时间
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(12.w, 12.w, 12.w, 0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            int leftIndex = index * 2;
            int rightIndex = leftIndex + 1;
            bool hasRight = true;
            if (rightIndex >= productList.length) {
              hasRight = false;
            }

            double width = (1.sw - 24.w - 8.w) / 2;

            double leftHeight = GoodsCard.getHeight(
              context,
              productList[leftIndex],
              width: width,
              showCorner: showCorner,
              showSkuList: showSkuList,
              showFreeShipping: showFreeShipping,
              showRating: showRating,
              showDispatch: showDispatch,
            );
            double rightHeight = hasRight
                ? GoodsCard.getHeight(
                    context,
                    productList[rightIndex],
                    width: width,
                    showCorner: showCorner,
                    showSkuList: showSkuList,
                    showFreeShipping: showFreeShipping,
                    showRating: showRating,
                    showDispatch: showDispatch,
                  )
                : 0;
            double height = leftHeight > rightHeight ? leftHeight : rightHeight;

            return Padding(
              padding: EdgeInsets.only(bottom: 8.w),
              child: ExposureDetector(
                key: Key('Category_${productList[leftIndex].skuId}'),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GoodsCard(
                      key: UniqueKey(),
                      width: width,
                      height: height,
                      data: productList[leftIndex],
                      showCorner: showCorner,
                      showSkuList: showSkuList,
                      showFreeShipping: showFreeShipping,
                      showRating: showRating,
                      showDispatch: showDispatch,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    if (hasRight)
                      GoodsCard(
                        key: UniqueKey(),
                        width: width,
                        height: height,
                        data: productList[rightIndex],
                        showCorner: showCorner,
                        showSkuList: showSkuList,
                        showFreeShipping: showFreeShipping,
                        showRating: showRating,
                        showDispatch: showDispatch,
                      ),
                  ],
                ),
                onExposure: (visibilityInfo) {
                  onExposure?.call([
                    productList[leftIndex].toJson(),
                    if (hasRight) productList[rightIndex].toJson(),
                  ]);
                },
              ),
            );
          },
          childCount: (productList.length / 2).ceil(),
        ),
      ),
    );
  }
}
