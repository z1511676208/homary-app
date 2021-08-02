/*
 * @Author       : JHao
 * @Date         : 2021-07-21 10:31:45
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-02 20:35:51
 */
import 'package:homary/api/category.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/category.dart';

class CategoryCtrl extends ChangeNotifier {
  String activeCategoryId = "";
  Data categoryList = new Data();
  Map<String, String> categoryBannerMap = {
    "jump_url": "",
    "app_category_banner": ""
  };
  List<Data> subList = [];

  // 获取二/三级分类列表
  Future<void> getCategoryList({params}) async {
    DioResult res = await CategoryApi.getCategoryList(params: params);
    if (res.error == null) {
      CategoryRes result = CategoryRes.fromJson(res.result);
      categoryList = result.data;
      categoryBannerMap['app_category_banner'] = result.data.appCategoryBanner;
      categoryBannerMap['jump_url'] = result.data.jumpUrl;
      subList = result.data.subList;
      notifyListeners();
    }
  }

  setActiveCategoryId(String id) {
    activeCategoryId = id;
    notifyListeners();
  }
}
