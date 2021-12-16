import 'package:homary/api/cart.dart';
import 'package:homary/api/category.dart';
import 'package:homary/api/home.dart';
import 'package:homary/api/search.dart';
import 'package:homary/common/event/refreshFlashSale.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/event_bus.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/entity/flashModule.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/entity/homeAdvInfo.dart';
import 'package:homary/entity/homeProductModule.dart';
import 'package:homary/entity/homeReviewModule.dart';
import 'package:homary/entity/recommend.dart';
import 'package:homary/entity/search.dart';
import 'package:homary/entity/shoppingCartData.dart';
import 'package:homary/entity/topChannelCategory.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeCtrl with ChangeNotifier {
  // 首页广告区
  AdvDatum bannerList;
  AdvDatum leftAd;
  AdvDatum rightAd;
  AdvDatum kingKongList;
  AdvDatum fisrtRoomAds;
  AdvDatum secondRoomAds;
  AdvDatum firstGridAds;
  AdvDatum secondGridAds1;
  AdvDatum secondGridAds2;
  AdvDatum activityEntrance;
  // 首页热销商品区
  HotSaleActivity favoredList;
  HotSaleActivity deaksList;
  // 首页评论区
  ReviewData reviewList;
  // 推荐商品流
  List<ModuleDataProductList> recommendList = [];
  int hasMorePage = 0;
  bool recommendLoading = false;
  Map<String, int> recommendParams = {
    "page": 1,
    "page_size": 40,
    'page_type': 1
  };
  // 一级分类列表
  List<TopChannelDatum> topChannelList = [];
  List<String> topChannelNameList = [];

  // 秒杀模块
  FlashData flashData;

  // 热搜词
  List<HotKeyword> hotKeywordList = [];

  // 首页购物车
  List<ShoppingCart> shoppingCartData = [];
  int shoppingCartNum;
  Summary shoppingCartSummary;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  var homeAdvInfoMap = Localstorage().getJSON(StorageKey.HOME_ADV_CACHE);

  HomeCtrl() {
    if (homeAdvInfoMap != null) {
      AppAdvInfoRes result = AppAdvInfoRes.fromJson(homeAdvInfoMap);
      setHomeAdvInfo(result);
    }
  }

  // 获取首页推荐商品流
  Future<void> getRecommendList({params}) async {
    recommendLoading = true;
    if (params == null) {
      recommendParams = {"page": 1, "page_size": 40, "page_type": 1};
    }
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
      if (hasMorePage == 0) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      notifyListeners();
    }
  }

  Future handleGetMoreProduct() async {
    recommendParams['page'] += 1;
    await getRecommendList(params: recommendParams);
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
  Future<void> getAdvInfo({params, bool isShowLoading = true}) async {
    if (isShowLoading || homeAdvInfoMap == null) {
      Toast.loading();
    }
    DioResult res = await HomeApi.getAdvertInfo(params: {"page_type": 1});
    Toast.clear();
    if (res.error == null) {
      AppAdvInfoRes result = AppAdvInfoRes.fromJson(res.result);
      homeAdvInfoMap = res.result;
      Localstorage().setJSON(StorageKey.HOME_ADV_CACHE, res.result);
      setHomeAdvInfo(result);
    }
    refreshController.refreshCompleted();
  }

  setHomeAdvInfo(AppAdvInfoRes result) {
    //首页Banner
    this.bannerList = filterAdvInfo(result, 'index_home_banner');
    //首页固定频道位-1
    this.leftAd = filterAdvInfo(result, 'index_regular_ads_1');
    //首页固定频道位-2
    this.rightAd = filterAdvInfo(result, 'index_regular_ads_2');
    //首页金刚区
    this.kingKongList = filterAdvInfo(result, 'index_shop_by_department');
    //首页页中showroom-1
    this.fisrtRoomAds = filterAdvInfo(result, 'index_showroom_1');
    //首页页中showroom-2
    this.secondRoomAds = filterAdvInfo(result, 'index_showroom_2');
    //首页页中格栅广告位
    this.firstGridAds = filterAdvInfo(result, 'index_middle_special_ads');
    //首页页尾格栅广告位
    this.secondGridAds1 = filterAdvInfo(result, 'index_bottom_special_ads');
    //首页页中尾格栅广告位-1
    this.secondGridAds2 = filterAdvInfo(result, 'index_bottom_special_ads_1');
    //首页浮窗活动入口
    this.activityEntrance = filterAdvInfo(result, 'site_floating_window');
    notifyListeners();
  }

  AdvDatum filterAdvInfo(AppAdvInfoRes result, String moduleKey) {
    return result.data.firstWhere((item) => item.moduleKey == moduleKey,
        orElse: () => new AdvDatum());
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
    DioResult res = await HomeApi.getReviewModule(params: {'page_size': 6});
    if (res.error == null) {
      HomeReviewModuleRes result = HomeReviewModuleRes.fromJson(res.result);
      reviewList = result.data;
      notifyListeners();
    }
  }

  // 获取秒杀商品模块
  Future<void> getFlashSaleModule({params}) async {
    DioResult res = await HomeApi.getFlashSaleModule(params: {"page_type": 1});
    if (res.error == null) {
      FlashModuleRes result = FlashModuleRes.fromJson(res.result);
      flashData = result.data;
      EventBus.instance.emit(RefreshFlashSaleEvent());
      notifyListeners();
    }
  }

  // 获取热搜词
  Future getSearchHotKeywords() async {
    DioResult res = await SearchApi.getSearchHotKeywords();
    if (res.error == null) {
      HotKeywordRes result = HotKeywordRes.fromJson(res.result);
      this.hotKeywordList = result.data.hotKeywords.isNotEmpty
          ? result.data.hotKeywords.length >= 12
              ? result.data.hotKeywords.sublist(0, 12)
              : result.data.hotKeywords
          : [];
      notifyListeners();
    }
  }

  Future<void> getShoppingCartData() async {
    DioResult res =
        await CartApi.getShoppingCart(params: {"source": 1, "method": 2});
    if (res.error == null) {
      Toast.clear();
      ShoppingCartRes result = ShoppingCartRes.fromJson(res.result);
      shoppingCartData = result.data.shoppingCart.length > 3
          ? result.data.shoppingCart.sublist(0, 3)
          : result.data.shoppingCart;
      shoppingCartNum = result.data.shoppingItemsNum;
      shoppingCartSummary = result.data.summary;
      notifyListeners();
    }
  }
}
