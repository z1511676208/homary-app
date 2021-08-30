/*
 * @Author       : JHao
 * @Date         : 2021-08-26 15:09:27
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-26 18:34:10
 */
import 'package:homary/api/common.dart';
import 'package:homary/api/product.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/utils.dart';
import 'package:homary/entity/areaByIp.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/entity/productEtaInfoRes.dart';

class ProductEtaInfo with ChangeNotifier {
  // 根据IP获取到的地址信息
  AreaData areaData;
  List<Map<String, dynamic>> productEtaList = [];

  // 根据IP获取用户地址信息
  Future getAreaByIp() async {
    DioResult res = await CommonApi.getAreaByIp();
    if (res.error == null) {
      AreaByIpRes result = AreaByIpRes.fromJson(res.result);
      areaData = result.data;
    }
  }

  resetProductEtaList(){
    productEtaList = [];
  }

  Future getEtaInfo(List<ModuleDataProductList> list) async {
    if (isShowEtaInfo()) {
      // 美国/英国站才需要获取ETA信息\
      var skuCodeList = list.map((e) => e.skuCode) ?? [];
      DioResult res = await ProductApi.getEtaInfo(params: {
        "country_code": areaData?.countryCode ?? "",
        "state_code": areaData?.stateCode ?? "",
        "sku_code": skuCodeList.join(',')
      });
      if (res.error == null) {
        ProductEtaInfoRes result = ProductEtaInfoRes.fromJson(res.result);
        Map<String, Datum> etaInfo = result.data;
        etaInfo.forEach((key, value) {
          if (value.showLabel == 1 &&
              !productEtaList.asMap().keys.contains(key)) {
            productEtaList.add({
              "skuCode": key,
              "dispatchLabel": value.dispatchShortLabel != null &&
                      value.dispatchShortLabel != ""
                  ? value.dispatchShortLabel
                  : value.dispatchLabel
            });
          }
        });
      }
    } else {
      productEtaList = [];
    }
  }
}
