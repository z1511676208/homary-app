/*
 * @Author       : JHao
 * @Date         : 2021-09-26 14:56:55
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-30 14:47:23
 */

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:homary/api/cart.dart';
import 'package:homary/api/home.dart';
import 'package:homary/api/common.dart';
import 'package:homary/api/usercenter.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/storage/cookie-manager.dart';
import 'package:homary/common/storage/cookie.dart';
import 'package:homary/common/storage/webview-cookie.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/entity/cart_change_res.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/entity/pay_method_res.dart';
import 'package:homary/entity/productEtaInfoRes.dart';
import 'package:homary/entity/product_info.dart';
import 'package:homary/entity/product_static_info.dart';
import 'package:homary/entity/recommend.dart';
import 'package:homary/common/utils/utils.dart';
import 'package:homary/entity/areaByIp.dart';
import 'package:homary/entity/searchCoupon.dart';
import 'package:homary/entity/shoppingCartData.dart';
import 'package:homary/main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CouponStatusEnum {
  static int noApplyCoupon = 0; // 未领取劵状态
  static int recievedApplyCoupon = 1; // 已领取劵状态
  static int drawTypeById = 1; // 优惠券id方式领劵
  static int drawTypeByCouponAlias = 2; // 优惠券识别码方式领劵
}

class ShoppingCartCtrl with ChangeNotifier {
  bool _isDispose = false;
  ShoppingCartResData cartData;
  List<ShoppingCart> saveForLater;
  List<ShoppingCart> shoppingCart;
  List<Total> orderSummary;

  Summary summary;
  Total total;
  List<PayMethodDatum> payMethodIconList;
  List<ModuleDataProductList> recommendList;
  int page = 1;

  bool isShowBottomCheckout = true;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  // 优惠券相关
  TextEditingController inputCtrl = new TextEditingController();
  CouponList couponList;
  Coupon activeCanUseCoupon; //当前选中可用的优惠券
  String useCode = ''; //券码框的值
  bool showCoupons = false;
  bool isApply = true; //输入框是否是待申请状态  为false已经用了券
  String drawCouponError = ''; //领取优惠券的错误
  dynamic couponUserId = 0; //空字符串代表匹配最佳优惠券，数字0代表不用优惠券
  List skuIdQtyList = [];
  List<ListElement> bestCouponList = []; // 实时搜索的最优优惠券列表
  bool isGuest = false;

  // ETA 相关
  String errorZipCode = "";
  Map<String, dynamic> areaData =
      Localstorage().getJSON(StorageKey.ETA_CACHE) ?? null;
  Map<String, dynamic> currentConfig =
      Localstorage().getJSON(StorageKey.CURRENT_CONFIG) ?? {};
  String zipInputError = "";
  String shippingStr = "";
  String currentZipCode = ""; // 当前输入框的值
  bool showETAInput = false;

  // 缓存商品详情
  String cacheSkuId;
  ProductInfoResData productInfo;
  ProductStaticInfoResData productStaticInfo;
  ProductEtaInfoRes etaInfoRes;

  @override
  void dispose() {
    inputCtrl.dispose();
    super.dispose();
    _isDispose = true;
  }

  void _safeNotifyListeners() {
    if (_isDispose) {
      return;
    }
    notifyListeners();
  }

  Future<void> getShoppingCartData(
      {couponUserId, bool isShowLoading = true}) async {
    if (isShowLoading) {
      Toast.loading();
    }
    DioResult res = await CartApi.getShoppingCart(
        params: {"source": 1, "coupon_user_id": couponUserId ?? ''});
    Toast.clear();
    if (res.error == null) {
      Toast.clear();
      ShoppingCartRes result = ShoppingCartRes.fromJson(res.result);
      cartData = result.data;
      saveForLater = cartData.saveForLater;
      shoppingCart = cartData.shoppingCart;
      couponList = cartData.couponList;
      orderSummary = cartData.orderSummary;
      summary = cartData.summary;
      total = cartData.total;
      this.getDataActiveCoupon(couponUserId: couponUserId);
      //查看是否为游客
      this.checkIsGuest();
      this.getSkuIdQtyList();
      this.getRecommendList();
      _safeNotifyListeners();
    }
  }

  //查看是否为游客
  checkIsGuest() async {
    bool isLogin = Localstorage().getBool(StorageKey.IS_LOGIN);
    String token = getToken();
    Cookie isGuest = await getCookie('isGuest');
    this.isGuest = isGuest != null;
    //已经设置过token的返回
    if ((isLogin && token != "") || (isGuest != null && token != "")) {
      return;
    }
    if (this.cartData.token != "") {
      setGuest("true");
      setToken(this.cartData.token);
      setTokenCookie();
    }
  }

  Future<void> handleSearchCoupon({params}) async {
    DioResult res = await CartApi.searchCoupon(params: params);
    if (res.error == null) {
      SearchCouponRes result = SearchCouponRes.fromJson(res.result);
      this.bestCouponList = result.data?.list ?? [];
      _safeNotifyListeners();
    }
  }

  // 领取优惠券
  Future<void> applyCoupon(String code) async {
    DioResult result = await UserCenterApi.drawCoupons(params: {
      'draw_type': CouponStatusEnum.drawTypeByCouponAlias,
      'coupon_alias': code
    });
    if (result.error == null) {
      this.couponUserId = result.result['data'] != null
          ? result.result['data']['coupon_user_id']
          : '';
    } else {
      this.drawCouponError = result.error['message'] ?? 'Error';
    }
    _safeNotifyListeners();
  }

  // 点击Apple按钮兑换优惠券
  handleApplyCoupon() async {
    sendGTMData({
      "event": 'apply_from_cart',
      "ecommerce": {"non_interaction": false}
    });
    //输入的券码是可用优惠券里面的  直接触发把优惠券ID给订单
    Coupon canUseCoupon = this.couponList.useableList.firstWhere(
        (e) => e.couponAlias.toUpperCase() == inputCtrl.text.toUpperCase(),
        orElse: () => null);
    if (canUseCoupon != null) {
      this.getShoppingCartData(couponUserId: canUseCoupon.couponUserId);
      return;
    }

    //输入的券码是不可用优惠券里面的  直接提示不能用
    Coupon noUseCoupon = this.couponList.diabledList.firstWhere(
        (e) => e.couponAlias.toUpperCase() == inputCtrl.text.toUpperCase(),
        orElse: () => null);
    if (noUseCoupon != null) {
      this.drawCouponError =
          "This coupon cannot be used for the current product, please select the coupon again";
      return;
    }
    await this.applyCoupon(inputCtrl.text);
    Localstorage().setGaTicketList(TicketList.beginCheckout);
    this.getShoppingCartData(couponUserId: this.couponUserId);
  }

  // 获取购物车内所有商品的skuId-qty数组
  getSkuIdQtyList() {
    if (this.shoppingCart != null && this.shoppingCart is List) {
      this.skuIdQtyList = this
          .shoppingCart
          .map((e) => {"sku_id": e.skuId, "qty": e.qty})
          .toList();
    }
  }

  // 设置可使用的优惠券
  getDataActiveCoupon({couponUserId}) {
    Coupon activeCoupon = couponList != null && couponList.useableList != null
        ? couponList.useableList.firstWhere(
            (element) => element.isSelected == 1,
            orElse: () => null)
        : null;
    if (activeCoupon != null) {
      this.setCanUseCoupon(activeCoupon);
      _safeNotifyListeners();
    } else if (couponUserId != null &&
        couponUserId != 0 &&
        couponUserId != '') {
      //如果有优惠券，但是不适合订单使用的
      this.setNoUseCoupon();
    } else {
      this.isApply = true; //输入框变成可申请状态
      this.useCode = '';
      this.couponUserId = 0;
      inputCtrl.text = "";
    }
  }

  //设置可用优惠券
  setCanUseCoupon(Coupon coupon) {
    this.drawCouponError = '';
    this.useCode = coupon.couponAlias;
    inputCtrl.text = this.useCode;
    this.couponUserId = coupon.couponUserId;
    this.activeCanUseCoupon = coupon;
    this.isApply = false; //可申请状态变为不可申请状态
    _safeNotifyListeners();
  }

  //不可用的优惠券
  setNoUseCoupon() {
    //提示错误信息
    this.isApply = true; //输入框变成可申请状态
    this.activeCanUseCoupon = null;
    this.drawCouponError =
        'This coupon cannot be used for the current product, please select the coupon again';
    _safeNotifyListeners();
  }

  resetCouponInput() {
    sendGTMData({
      "event": 'remove_from_cart',
      "ecommerce": {"non_interaction": false}
    });
    this.getShoppingCartData(couponUserId: 0); //0代表不使用优惠券
    this.isApply = true; //输入框变成可申请状态
    this.useCode = '';
    this.couponUserId = 0;
    inputCtrl.text = "";
  }

  // ZIP Input 相关
  Map<String, RegExp> zipRegExpList = {
    'us': RegExp(r'^[0-9]{5}$'),
    'uk': RegExp(r'^[A-Za-z0-9\s]{2,10}$'),
    'ca': RegExp(r'^[A-Za-z0-9\s]{2,10}$'),
  };
  Map<String, String> zipErrorTips = {
    'us': 'Please enter a valid 5 digit US zip code.',
    'uk': 'Please enter a valid UK zip code.',
    'ca': 'Please enter a valid CA zip code.',
  };
  RegExp zipRegexp() {
    String site = this.currentConfig['site'] ?? 'us';
    return zipRegExpList[site];
  }

  Future initZipInputData() async {
    // 判断本地是否有地址可用 没有则请求最新地址
    if (this.areaData == null) {
      DioResult res = await CommonApi.getAreaByIp();
      if (res.error == null) {
        AreaByIpRes result = AreaByIpRes.fromJson(res.result);
        this.areaData = result.data.toJson();
        Localstorage().setJSON(StorageKey.ETA_CACHE, result.data.toJson());
      }
    }
    this.getShippingStr();
  }

  getShippingStr() {
    if (errorZipCode != "") {
      //有zip 说明zip是错误的则还是显示原来的
      this.shippingStr = errorZipCode;
    } else {
      String _shipTo = this.areaData['city'] ?? '';
      String _zip = this.areaData['zip'] ?? '';
      this.shippingStr = '$_zip${_shipTo != "" ? '-$_shipTo' : ''}';
    }
    _safeNotifyListeners();
  }

  final _debounceZipInput = Debouncer(milliseconds: 200);
  handleZipInputChange(String value) {
    this.currentZipCode = value;
    _debounceZipInput.run(() {
      RegExp regExp = zipRegexp();
      if (!regExp.hasMatch(value)) {
        String site = this.currentConfig['site'] ?? 'us';
        this.zipInputError = zipErrorTips[site];
      } else {
        this.zipInputError = "";
      }
      _safeNotifyListeners();
    });
  }

  updateETA() async {
    if (this.currentZipCode == "") {
      return;
    }
    //先清空本地的错误的zipcode
    this.errorZipCode = "";
    Toast.loading();
    DioResult res =
        await CartApi.getAreaByZip(params: {"zip": this.currentZipCode});
    Toast.clear();
    if (res.error == null) {
      //输入的邮编有返回数据
      AreaByIpRes result = AreaByIpRes.fromJson(res.result);
      if (result.data != null) {
        this.areaData = result.data.toJson();
        Localstorage().setJSON(StorageKey.ETA_CACHE, result.data.toJson());
      } else {
        this.errorZipCode = this.currentZipCode;
      }
    } else {
      //邮编拿不到数据，则保存输入的邮编到本地
      this.errorZipCode = this.currentZipCode;
    }
    this.getShippingStr();
    this.toggleETAInput();

    if (this.errorZipCode == "") {
      this.getShoppingCartData(couponUserId: this.couponUserId);
    }
  }

  toggleETAInput() {
    this.showETAInput = !this.showETAInput;
    _safeNotifyListeners();
  }

  // Zip Input 相关 end

  /// 修改单个购物车商品
  Future<CartChangeDatum> changeItem({params}) async {
    Toast.loading();
    DioResult result = await CartApi.change(params: params);
    Toast.clear();
    if (result.error == null) {
      CartChangeRes res = CartChangeRes.fromJson(result.result);
      if (res.data == null || res.data.isEmpty) {
        this.getShoppingCartData();
        return null;
      }
      // 修改失败
      return res.data[0];
    }
    return null;
  }

  /// 获取支付类型图标
  void getPayMethodIconList() async {
    DioResult result = await CartApi.getMethodList();
    if (result.error == null) {
      PayMethodRes res = PayMethodRes.fromJson(result.result);
      payMethodIconList = res.data;
      _safeNotifyListeners();
    }
  }

  /// 获取推荐商品流
  Future<void> getRecommendList({params}) async {
    if (shoppingCart != null && shoppingCart.isNotEmpty) {
      // 购物车存在商品时，不显示推荐列表
      page = 1;
      recommendList = [];
      _safeNotifyListeners();
      return;
    }
    DioResult res = await HomeApi.getRecommendList(params: {
      'page': page++,
      'page_size': 20,
    });
    if (res.error == null) {
      RecommendListRes result = RecommendListRes.fromJson(res.result);
      List<ModuleDataProductList> newResult = result?.data?.list ?? [];
      recommendList = [...(recommendList ?? []), ...newResult];
      int hasMorePage = result?.data?.hasMorePage ?? 1;
      if (hasMorePage == 0) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      _safeNotifyListeners();
    }
  }

  void onRefresh() async {
    page = 1;
    await this.getShoppingCartData(isShowLoading: false);
    this.getPayMethodIconList();
    refreshController.refreshCompleted();
  }

  void setBottomCheckout(bool isShow) {
    if (isShowBottomCheckout != isShow) {
      isShowBottomCheckout = isShow;
      notifyListeners();
    }
  }

  handleCheckout({String eventName}) async {
    if (eventName != null) {
      var currentConfig =
          Localstorage().getJSON(StorageKey.CURRENT_CONFIG) ?? {};
      sendProductItemGTM(
          data: [...this.shoppingCart.map((e) => e.toJson()).toList()],
          itemListName: 'Shopping Cart',
          eventName: eventName,
          extraParms: {
            'currency': currentConfig['currency'] ?? 'usd',
            'value': this.summary.subtotal,
          });
    }

    DioResult result;
    Toast.loading();
    if (this.isGuest) {
      result = await CartApi.touristGoosListCheck(
          params: {"goods_list": this.skuIdQtyList});
    } else {
      result = await CartApi.goosListCheck(
          params: {"goods_list": this.skuIdQtyList});
    }
    if (result.error == null) {
      Toast.clear();
      CartChangeRes res = CartChangeRes.fromJson(result.result);
      if (res.data == null || res.data.isEmpty) {
        Localstorage().setGaTicketList(TicketList.beginCheckout);
        BuildContext context = navigatorKey.currentState.overlay.context;
        Routes.push(context, '/webview', params: {
          "content":
              '{"url":"https://m.homary.com/order/place?source=2&couponUserId=${this.couponUserId}"}'
        });
      } else {
        List<String> errorTips = [];
        res.data.forEach((element) {
          ShoppingCart errorData = shoppingCart
              .firstWhere((e) => e.skuId == element.skuId, orElse: () => null);
          if (errorData != null) {
            errorData.qtyError = element.msg;
            errorTips.add(element.msg);
          }
        });
        this.shoppingCart = [...this.shoppingCart];
        Toast.message(errorTips.join(', '));
        _safeNotifyListeners();
      }
    }
  }
}
