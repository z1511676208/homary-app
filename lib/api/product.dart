import 'package:homary/entity/product.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/requsetUrl.dart';

class ProductApi {
  static Future<dynamic> getProduct() async {
    var url = getRequsetUrl('getProductUrl');
    var res = await Request()
        .get(url, params: {"test": 2313, "name": 'huanjie'}, diskCache: false);
    return HomeProductsRes.fromJson(res);
  }
}
