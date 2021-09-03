/*
 * @Author       : JHao
 * @Date         : 2021-08-27 18:11:57
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-03 16:25:10
 */

import 'package:homary/common/storage/cookie.dart';

Map<String, String> _siteLink = {
  'us': "https://m.homary.com/lego/sale-154.html?pageFrom=HomaryApp",
  "uk": "https://muk.homary.com/lego/sale-160.html?pageFrom=HomaryApp",
  "fr":
      "https://mfr.homary.com/lego/bon-plan-pour-la-maison-164.html?pageFrom=HomaryApp",
  "es": "https://mes.homary.com/lego/buenasofertas-73.html?pageFrom=HomaryApp",
  "de": "https://mde.homary.com/lego/angebote-126.html?pageFrom=HomaryApp",
  "au": "https://mau.homary.com/lego/saleau-129.html?pageFrom=HomaryApp",
  "ca": "https://mca.homary.com/lego/saleca-132.html?pageFrom=HomaryApp",
  "global":
      "https://mglobal.homary.com/channel/hot-sales-2.html?pageFrom=HomaryApp"
};

String getSalePageLink() {
  String _site = getCurrentConfig()['site'] ?? 'us';
  return _siteLink[_site];
}
