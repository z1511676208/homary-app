/*
 * @Author       : JHao
 * @Date         : 2021-07-21 10:42:50
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-27 21:18:37
 */
/*
 * @Author       : zhhjie
 * @Date         : 2021-07-14 10:59:39
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-15 19:28:40
 */
import 'package:homary/api/home.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/entity/home.dart' hide ListElement;
import 'package:homary/entity/recommend.dart';

class HomeCtrl with ChangeNotifier {
  Module bannerList;
  Module kingKongList;
  Module adList;
  Module favoredList;
  Module deaksList;
  Module reviewList;
  // 推荐商品流
  List<ModuleDataProductList> recommendList = [];
  int hasMorePage = 1;
  bool recommendLoading = false;
  Map<String, int> recommendParams = {"page": 1, "page_size": 20};

  //登录
  Future<void> getIndexData({params}) async {
    Toast.loading();
    DioResult res = await HomeApi.getIndexData(params: params);
    Toast.clear();
    if (res.error == null) {
      HomeDataRes result = HomeDataRes.fromJson(res.result);
      var moduleType0 =
          result.data.modules.where((item) => item.moduleType == 1).toList();
      bannerList = moduleType0.length > 0 ? moduleType0[0] : new Module();
      var moduleType7 =
          result.data.modules.where((item) => item.moduleType == 7).toList();
      kingKongList = moduleType7.length > 0 ? moduleType7[0] : new Module();
      var moduleType8 =
          result.data.modules.where((item) => item.moduleType == 8).toList();
      adList = moduleType8.length > 0 ? moduleType8[0] : new Module();
      var moduleType2 =
          result.data.modules.where((item) => item.moduleType == 2).toList();
      favoredList = moduleType2.length > 0 ? moduleType2[0] : new Module();
      var moduleType3 =
          result.data.modules.where((item) => item.moduleType == 3).toList();
      deaksList = moduleType3.length > 0 ? moduleType3[0] : new Module();
      var moduleType4 =
          result.data.modules.where((item) => item.moduleType == 4).toList();
      reviewList = moduleType4.length > 0 ? moduleType4[0] : new Module();
      notifyListeners();
    }
  }

  Future<void> getRecommendList({params}) async {
    recommendLoading = true;
    notifyListeners();
    DioResult res =
        await HomeApi.getRecommendList(params: params ?? recommendParams);
    recommendLoading = false;
    if (res.error == null) {
      RecommendListRes result = RecommendListRes.fromJson(res.result);
      List<ModuleDataProductList> newResilt = result?.data?.list ?? [];
      if (recommendParams['page'] == 1) {
        recommendList = [...newResilt];
      } else {
        recommendList = [...recommendList, ...newResilt];
      }
      hasMorePage = result?.data?.hasMorePage ?? 1;
      notifyListeners();
    }
  }

  handleGetMoreProduct() {
    recommendParams['page'] += 1;
    getRecommendList(params: recommendParams);
  }
}
