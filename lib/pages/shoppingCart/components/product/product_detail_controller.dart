/*
 * @Author       : JHao
 * @Date         : 2021-09-30 18:38:58
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-01 01:38:36
 */
import 'package:homary/api/product.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/productEtaInfoRes.dart';
import 'package:homary/entity/product_info.dart';
import 'package:homary/entity/product_static_info.dart';
import 'package:homary/entity/shoppingCartData.dart';
import 'package:homary/pages/shoppingCart/controller.dart';

class ProductDetailCtrl extends ChangeNotifier {
  final ShoppingCart shoppingCart;
  final BuildContext context;

  ProductInfoResData productInfo;
  ProductStaticInfoResData productStaticInfo;
  String deliveryTime;

  bool isShowLabel = false;
  String stockLabel;
  String dispatchLabel;

  bool isLoading = true;

  ProductDetailCtrl(this.shoppingCart, this.context) {
    init();
  }

  void init() async {
    isLoading = true;
    await Future.wait([getProductInfo(), getProductStaticInfo(), getEtaInfo()]);
    isLoading = false;
    notifyListeners();
  }

  Future getProductInfo() async {
    ProductInfoResData cache = context.read<ShoppingCartCtrl>().productInfo;
    if (cache != null && cache.skuId == shoppingCart.skuId) {
      productInfo = cache;
      return;
    }
    DioResult result = await ProductApi.getProductInfo(params: {
      'sku_id': shoppingCart.skuId,
    });
    if (result.error == null) {
      ProductInfoRes productInfoRes = ProductInfoRes.fromJson(result.result);
      productInfo = productInfoRes.data;
      context.read<ShoppingCartCtrl>().productInfo = productInfoRes.data;
    }
  }

  Future getProductStaticInfo() async {
    ProductStaticInfoResData cache =
        context.read<ShoppingCartCtrl>().productStaticInfo;
    if (cache != null && cache.skuCode == shoppingCart.skuCode) {
      productStaticInfo = cache;
      return;
    }
    DioResult staticResult = await ProductApi.getProductStaticInfo(params: {
      'sku_id': shoppingCart.skuId,
    });
    if (staticResult.error == null) {
      ProductStaticInfoRes productStaticInfoRes =
          ProductStaticInfoRes.fromJson(staticResult.result);
      productStaticInfo = productStaticInfoRes.data;
      context.read<ShoppingCartCtrl>().productStaticInfo =
          productStaticInfoRes.data;
    }
  }

  Future getEtaInfo() async {
    ProductEtaInfoRes cache = context.read<ShoppingCartCtrl>().etaInfoRes;
    String cacheSkuId = context.read<ShoppingCartCtrl>().cacheSkuId;

    if (cache == null || cacheSkuId != shoppingCart.skuId) {
      Map areaData = Localstorage().getJSON(StorageKey.ETA_CACHE) ?? {};
      DioResult res = await ProductApi.getEtaInfo(params: {
        "country_code": areaData['country_code'] ?? "",
        "state_code": areaData['state_code'] ?? "",
        "sku_code": shoppingCart.skuCode
      });
      if (res.error != null) {
        return;
      }
      cache = ProductEtaInfoRes.fromJson(res.result);
    }

    context.read<ShoppingCartCtrl>().cacheSkuId = shoppingCart.skuId;
    context.read<ShoppingCartCtrl>().etaInfoRes = cache;

    Map<String, Datum> etaInfo = cache.data;
    etaInfo.forEach((key, value) {
      deliveryTime = value.deliveryTime;

      if (value.showLabel == 1) {
        isShowLabel = true;
        stockLabel = value.stockLabel;
        dispatchLabel = value.dispatchLabel;
        sendGTMData({
          "event": 'view_dispatch',
          "ecommerce": {
            "dispatch": '48h',
            "sku_id": shoppingCart.skuId,
          }
        });
      }
    });
  }
}
