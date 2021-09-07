import 'dart:convert';

import 'package:homary/api/product.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/entity/product_attr_res.dart';
import 'package:homary/entity/product_res.dart';
import 'package:homary/entity/slideNav.dart';
import 'package:homary/main.dart';
import 'package:homary/provider/productEtaInfo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryTabCtrl extends ChangeNotifier {
  bool _isDispose = false;

  /// 选中的category id
  String selectedCategoryId;
  String selectedCategoryName;

  /// 类目列表
  List<Datum> categoryList = [];

  /// 属性
  List<ProductAttrMain> filterList = [];

  /// 排序规则
  List<ProductAttrOrderBy> orderByList = [];
  String sort = 'sale_num';
  String orderSort = 'desc';

  /// 是否选择了筛选条件
  bool hasFilter = false;

  /// 筛选语句
  String filterStr;

  /// 页码
  int page = 1;
  int size = 20;

  /// 是否可加载下一页
  int hasMorePage = 0;

  /// 是否显示Loading
  bool isLoading = false;

  /// 是否显示空布局
  bool isShowEmpty = false;

  /// 商品列表
  List<ModuleDataProductList> productList = [];

  /// 商品总数
  int productTotal = 0;

  // context
  BuildContext context;

  RefreshController refreshController = RefreshController(initialRefresh: false);

  /// 搜索结果页See Also
  List<SeeAlsoData> seeAlsoList;

  /// 搜索内容
  String keyword;

  /// banner图片
  String bannerImage;

  CategoryTabCtrl(
      {this.selectedCategoryId,this.selectedCategoryName, this.context,this.keyword});

  @override
  void dispose() {
    context = null;
    super.dispose();
    _isDispose = true;
  }

  void setCategoryList(List<Datum> list) {
    categoryList.clear();
    list.forEach((element) {
      Datum datum = Datum.fromJson(jsonDecode(jsonEncode(element)));
      categoryList.add(datum);
    });
    _setDefaultCategory();
    _safeNotifyListeners();
  }

  /// 进入页面时，设置默认选中的类目
  void _setDefaultCategory() {
    if(selectedCategoryId == null){
      // 搜索页没有默认选中的类目
      return;
    }
    categoryList.forEach((element) {
      int tag = _getSelectedIndex(element);
      if (tag == 1) {
        element.isExpand = true;
      }
    });
  }

  /// 递归查找当前选中类目
  int _getSelectedIndex(Datum datum) {
    if (datum.categoryId == selectedCategoryId) {
      selectedCategoryName = datum.categoryName;
      datum.isSelect = true;
      return 1;
    }
    if (datum.subList.isEmpty) {
      return 0;
    }
    int tag = 0;
    for (int i = 0; i < datum.subList.length; i++) {
      tag = _getSelectedIndex(datum.subList[i]);
      if (tag == 1) {
        datum.isExpand = true;
        return tag;
      }
    }
    return 0;
  }

  void _safeNotifyListeners() {
    if (_isDispose) {
      return;
    }
    notifyListeners();
  }

  /// 获取筛选属性和排序规则
  Future<void> getProductAttrList(String channelId) async {
    final result = await ProductApi.getProductAttrList(
        params: {'channel_id': channelId, 'keyword': keyword});
    if (result.error == null) {
      ProductAttrRes res = ProductAttrRes.fromJson(result.result);
      filterList.clear();
      filterList.addAll(res.data.main);
      int i = 0;
      filterList.forEach((element) {
        if (i < 3) {
          element.isExpand = true;
        }
        i++;
      });
      orderByList.clear();
      res.data.orderBy.forEach((element) {
        if (element.key == 'price') {
          orderByList.add(ProductAttrOrderBy(
            name:
                '${element.name} ${S.of(navigatorKey.currentState.context).category_highToLow}',
            key: element.key,
          ));
          orderByList.add(ProductAttrOrderBy(
            name:
                '${element.name} ${S.of(navigatorKey.currentState.context).category_lowToHigh}',
            key: element.key,
            orderBy: 'asc',
          ));
        } else {
          orderByList.add(element);
        }
      });
      _safeNotifyListeners();
    }
  }

  /// 获取商品列表
  Future<void> getProductList({bool isOnRefresh = false}) async {
    if (page == 1) {
      if (!isOnRefresh) {
        Toast.loading();
      }
    } else {
      isLoading = true;
      _safeNotifyListeners();
    }

    DioResult result;

    final params = {
      'channel_id': selectedCategoryId,
      'page': page++,
      'page_size': size,
      'attr': filterStr,
      'sort': sort,
      'order_sort': orderSort,
      'keyword' : keyword,
    };

    if(selectedCategoryId == null){
      // 当前为搜索页，使用搜索接口
      result = await ProductApi.getSearchList(params: params);
    } else {
      // 当前为类目页
      result = await ProductApi.getProductList(params: params);
    }

    if (result.error == null) {
      ProductRes res = ProductRes.fromJson(result.result);
      await Provider.of<ProductEtaInfo>(context, listen: false)
          .getEtaInfo(res.data.list);
      if(isOnRefresh){
        productList.clear();
      }
      productList.addAll(res.data.list);
      productTotal = res.data.total;
      hasMorePage = res.data.hasMorePage;
      if (res.data.total == 0) {
        isShowEmpty = true;
      } else {
        isShowEmpty = false;
      }
      if(hasMorePage == 0){
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }

      seeAlsoList = res.data.seeAlsoData;
      bannerImage = res.data.appCategoryBanner;
    }
    refreshController.refreshCompleted();
    Toast.clear();
    isLoading = false;
    _safeNotifyListeners();
  }

  /// 更换属性后重置列表
  void _resetAttr({bool isNeedClear = true}) {
    if(isNeedClear){
      productList.clear();
      productTotal = 0;
    }
    page = 1;
    hasMorePage = 0;
    _safeNotifyListeners();
  }

  /// 清除筛选条件
  void cleanFilter() async {
    filterList.forEach((element) {
      element.isExpand = false;
      element.filterData.forEach((e) {
        e.isSelect = false;
      });
    });
    hasFilter = false;
    filterStr = null;
    _safeNotifyListeners();
    _resetAttr();
    getProductList();
  }

  /// 替换筛选条件
  void applyFilter() async {
    List<String> list = [];
    filterList.forEach((element) {
      element.filterData.forEach((e) {
        if (e.isSelect) {
          list.add('${element.pnValue}:${e.pvValue}');
        }
      });
    });
    if (list.isNotEmpty) {
      hasFilter = true;
    } else {
      hasFilter = false;
    }
    filterStr = list.join(',');
    _resetAttr();
    getProductList();
  }

  /// 修改排序
  void changeSortBy() {
    orderByList.forEach((element) {
      if (element.isSelect) {
        sort = element.key;
        orderSort = element.orderBy;
      }
    });
    _resetAttr();
    getProductList();
  }

  /// 修改类目
  void changeCategory(Datum datum) {
    selectedCategoryId = datum.categoryId;
    selectedCategoryName = datum.categoryName;
    sort = 'sale_num';
    orderSort = 'desc';
    hasFilter = false;
    filterStr = null;
    _resetAttr();
    getProductAttrList(selectedCategoryId);
    getProductList();
  }

  void init() async {
    sort = 'sale_num';
    orderSort = 'desc';
    hasFilter = false;
    filterStr = null;
    _resetAttr();
    getProductAttrList(selectedCategoryId);
    getProductList();
  }

  Future<void> onRefresh() async {
    _resetAttr(isNeedClear: false);
    await getProductList(isOnRefresh: true);
  }
}
