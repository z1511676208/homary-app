/*
 * @Author       : JHao
 * @Date         : 2021-07-07 20:04:36
 * @LastEditors  : JHao
 * @LastEditTime : 2021-10-13 18:08:19
 */
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppColor {
  /// 主题橙色
  static const MaterialColor primaryMaterialColor = MaterialColor(
    0xFFFF9800,
    const <int, Color>{
      50: const Color(0xFFFF9800),
      100: const Color(0xFFFF9800),
      200: const Color(0xFFFF9800),
      300: const Color(0xFFFF9800),
      400: const Color(0xFFFF9800),
      500: const Color(0xFFFF9800),
      600: const Color(0xFFFF9800),
      700: const Color(0xFFFF9800),
      800: const Color(0xFFFF9800),
      900: const Color(0xFFFF9800),
    },
  );

  /// 主题橙色
  static const Color primaryColor = Color(0xFFFF9800);

  // #FEF4E8FF  tab选中的颜色
  static Color activeColor = Color(0xFB9221).withOpacity(0.1);

  /// 黑色
  static const Color primaryText = Color(0xFF222222);

  /// 灰色 #666
  static const Color primarySubTitle = Color(0xFF666666);

  /// 浅灰色 #999
  static const Color primaryLightSubTitle = Color(0xFF999999);

  /// 浅灰色 #999
  static const Color primaryBorderLight = Color(0xFF999999);

  /// 卡片阴影 #17000000
  static const Color primaryBorderShadow = Color(0x17000000);

  /// border outline color
  static const Color primaryBorderOutline = Color(0xFFCCCCCC);

  /// border BorderBottomLine color
  static const Color primaryBorderBottomLine = Color(0xFFE8E8E8);

  /// hard border
  static const Color primaryBorderHard = Color(0xFF999999);

  // #F5F6F7FF
  static const Color primaryNavBgColor = Color(0xFFF5F5F5);
  //底色
  static const Color primaryBackground = Color(0xFFF4F4F4);

  //点击状态色
  static const Color primaryPressed = Color.fromARGB(10, 0, 0, 0);
  static const Color whiteBtnPressed = Color.fromARGB(100, 255, 247, 231);

  static const Color offPriceColor = Color(0xFFCE2226); //打折后的价格

  //删除x颜色
  static const Color primaryDelete = Color(0xFFCCCCCC);

  //错误提示颜色
  static const Color primaryErrorTip = Color(0xFFE8554F);

  //提示阴影
  static const Color primaryShadowTipShadow = Color(0x17000000);

  //注册新人礼券提示语颜色
  static const Color primaryNewUserTipColor = Color(0xFFFF9800);

  // 首页秒杀背景色
  static const Color flashSaleBackgroundColor = Color(0xFFFEFBF5);

  // 首页秒杀文字颜色
  static const Color flashSaleFontColor = Color(0xFFEC1B1E);

  // 优惠券button文字颜色
  static const Color couponsButtonColor = Color(0xFFE8554F);

  // 优惠券输入框文字颜色
  static const Color couponsHintColor = Color(0xFFCACACA);

  // 优惠券提示文案颜色 #257039
  static Color couponTipsColor = HexColor('#257039');

  // 购物车绿
  static const Color cartHintColor = Color(0xFF73B8A0);
  // stock绿
  static const Color stockColor = Color(0xFF257039);

  // 商详表格背景色
  static const Color sheetBgColor = Color(0xFFF5F5F5);

  static const Color serviceItemColor = Color(0xFF434343);
  // 首页热词背景色
  static const Color hotKeywordBgColor = Color(0xFFF8F8F8);

  // 滚动条背景色
  static const Color scrollBarBgColor = Color(0xFFE9E9E9);

  // 滚动条颜色
  static const Color scrollBarColor = Color(0xFFDADADA);
}
