/*
 * @Author       : JHao
 * @Date         : 2021-07-21 10:31:45
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-25 17:11:50
 */
import 'package:homary/api/category.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/category.dart';
import 'package:homary/entity/topChannelCategory.dart';
import 'package:homary/main.dart';
import 'package:homary/pages/home/contorller.dart';

class CategoryCtrl extends ChangeNotifier {
  String activeCategoryId = "";
  Data categoryList = new Data();
  Map<String, String> categoryBannerMap = {
    "jump_url": "",
    "app_category_banner": ""
  };
  List<Data> subList = [];
  List<TopChannelDatum> topChannelList = [];

  // 获取一级分类列表
  Future<void> getTopChannelCategory({params}) async {
    DioResult res = await CategoryApi.getTopChannelCategory(params: params);
    if (res.error == null) {
      TopChannelCategoryRes result = TopChannelCategoryRes.fromJson(res.result);
      topChannelList = result.data;
      notifyListeners();
    }
  }

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

  resetData() {
    subList = [];
    notifyListeners();
  }

  setActiveCategoryId(String id) {
    activeCategoryId = id;
    notifyListeners();
  }
}
