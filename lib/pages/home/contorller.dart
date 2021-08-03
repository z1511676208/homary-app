/*
 * @Author       : JHao
 * @Date         : 2021-07-21 10:42:50
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-03 17:47:15
 */
/*
 * @Author       : zhhjie
 * @Date         : 2021-07-14 10:59:39
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-15 19:28:40
 */
import 'package:homary/api/category.dart';
import 'package:homary/api/home.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/entity/homeAdvInfo.dart';
import 'package:homary/entity/homeProductModule.dart';
import 'package:homary/entity/homeReviewModule.dart';
import 'package:homary/entity/recommend.dart';
import 'package:homary/entity/topChannelCategory.dart';

class HomeCtrl with ChangeNotifier {
  // 首页广告区
  AdvDatum bannerList;
  AdvDatum leftAd;
  AdvDatum rightAd;
  AdvDatum kingKongList;
  // 首页热销商品区
  HotSaleActivity favoredList;
  HotSaleActivity deaksList;
  // 首页评论区
  ReviewData reviewList;
  // 推荐商品流
  List<ModuleDataProductList> recommendList = [];
  int hasMorePage = 1;
  bool recommendLoading = false;
  Map<String, int> recommendParams = {"page": 1, "page_size": 20};
  // 一级分类列表
  List<TopChannelDatum> topChannelList = [];
  List<String> topChannelNameList = [];

  // 获取首页推荐商品流
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

  // 获取一级分类列表
  Future<Map<String, List>> getTopChannelCategory({params}) async {
    DioResult res = await CategoryApi.getTopChannelCategory(params: params);
    if (res.error == null) {
      TopChannelCategoryRes result = TopChannelCategoryRes.fromJson(res.result);
      topChannelList = result.data;
      topChannelNameList = topChannelList.map((e) => e.categoryName).toList();
      notifyListeners();
    }
    return {
      "topChannelList": topChannelList ?? [],
      "topChannelNameList": topChannelNameList ?? []
    };
  }

  // 获取首页广告
  Future<void> getAdvInfo({params}) async {
    Toast.loading();
    DioResult res = await HomeApi.getAdvInfo(params: params);
    Toast.clear();
    if (res.error == null) {
      AppAdvInfoRes result = AppAdvInfoRes.fromJson(res.result);
      var moduleType1 =
          result.data.where((item) => item.moduleType == 1).toList();
      bannerList = moduleType1.length > 0 ? moduleType1[0] : new AdvDatum();
      var moduleType2 =
          result.data.where((item) => item.moduleType == 2).toList();
      leftAd = moduleType2.length > 0 ? moduleType2[0] : new AdvDatum();
      var moduleType3 =
          result.data.where((item) => item.moduleType == 3).toList();
      rightAd = moduleType3.length > 0 ? moduleType3[0] : new AdvDatum();
      var moduleType4 =
          result.data.where((item) => item.moduleType == 4).toList();
      kingKongList = moduleType4.length > 0 ? moduleType4[0] : new AdvDatum();
      notifyListeners();
    }
  }

  // 获取商品模块
  Future<void> getProductModule({params}) async {
    DioResult res = await HomeApi.getProductModule(params: params);
    if (res.error == null) {
      HomeProductModuleRes result = HomeProductModuleRes.fromJson(res.result);
      favoredList = result.data.saleFlow;
      deaksList = result.data.hotSaleActivity;
      notifyListeners();
    }
  }

  // 获取首页评论模块
  Future<void> getReviewModule({params}) async {
    DioResult res = await HomeApi.getReviewModule(params: params);
    if (res.error == null) {
      HomeReviewModuleRes result = HomeReviewModuleRes.fromJson(res.result);
      reviewList = result.data;
      notifyListeners();
    }
  }
}
