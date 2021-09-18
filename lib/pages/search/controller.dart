/*
 * @Author       : zhhjie
 * @Date         : 2021-07-19 16:33:28
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-16 10:55:15
 */
import 'dart:async';

import 'package:homary/api/search.dart';
import 'package:homary/common/request/request.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/localstorage.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/schema2path.dart';
import 'package:homary/common/utils/utils.dart';
import 'package:homary/entity/main.dart';
import 'package:homary/entity/search_associate.dart';

class SearchCtrl with ChangeNotifier {
  List<WordList> filterList = []; //模糊查询列表
  List recentSearchs = []; //最近搜索缓存列表
  List popularSearchs = []; //热搜列表
  // List channelList = []; //频道列表
  bool showFilter = false; //输入框输入搜索显示过滤列表
  String keyword = '';

  Future getSearchHotKeywords() async {
    DioResult res = await SearchApi.getSearchHotKeywords();
    if (res.error == null) {
      HotKeywordRes result = HotKeywordRes.fromJson(res.result);
      this.popularSearchs = result.data.hotKeywords;
      // this.channelList = result.data.channelList;
      notifyListeners();
    }
  }

  Future getAnalyze(context) async {
    String keyword = this.keyword;
    if (keyword == '') {
      Routes.push(context, Routes.category, params: {
        'isSearchPage': 'true',
        'keyword': '',
      });
      return false;
    }
    Map<String, dynamic> params = {'keyword': keyword};
    DioResult res = await SearchApi.getAnalyze(params);
    if (res.error == null) {
      AnalyzeRes result = AnalyzeRes.fromJson(res.result);
      this.toProductList(context, result.data.keyWord, result.data.jumpUrl,
          'view_search_results');
      notifyListeners();
    }
  }

  void clearAll() {
    this.recentSearchs = [];
    Localstorage().remove(StorageKey.RECENT_LIST);
    notifyListeners();
  }

  void removeItem(index) {
    this.recentSearchs.removeAt(index);
    Localstorage().setJSON(StorageKey.RECENT_LIST, this.recentSearchs);
    notifyListeners();
  }

  void showFilterToggle() {
    this.showFilter = !this.showFilter;
    notifyListeners();
  }

  void inputChange(String val) {
    if (val != '') {
      this.showFilter = true;
      debounce((){
        getFilterList(val.trim());
      },Duration(milliseconds: 50))();
    } else {
      this.showFilterToggle();
    }
  }

  getFilterList(val) async {
    this.keyword = val;
    DioResult res = await SearchApi.getAssociateWordList({
      'keyword':val,
    });
    if (res.error == null) {
      SearchAssociate result = SearchAssociate.fromJson(res.result);
      filterList = [...result.data?.wordList??[]];
      notifyListeners();
    }
  }

  // 存储有效数据localStorage
  toProductList(context, String keyword, String url, String event) {
    String keyName = keyword;
    int i =
        this.recentSearchs.indexWhere((element) => element['name'] == keyName);
    if (i >= 0 && keyName != null) {
      this.recentSearchs.removeAt(i);
      this.recentSearchs.insert(0, {
        'name': keyName,
        'url': url,
        'searchTime': DateTime.now().toString()
      });
      Localstorage().setJSON(StorageKey.RECENT_LIST, this.recentSearchs);
      sendGTMData({
        // 埋点
        'event': event,
        'ecommerce': {'search_term': keyName}
      });
      if (url != null && url != '') {
        handleSchema(context, url);
      } else {
        Routes.push(context, Routes.category, params: {
          'isSearchPage': 'true',
          'keyword': keyName,
        });
      }
      notifyListeners();
      return;
    }
    this.setStore(context, keyName, url, event);
  }

  //获取缓存中最近搜索的词汇
  getStore() {
    List list = Localstorage().getJSON(StorageKey.RECENT_LIST);
    DateTime now = DateTime.now();
    if (list != null && list.isNotEmpty) {
      list
          .where((element) =>
              now.difference(DateTime.parse(element['searchTime'])).inDays > 7)
          .toList();
      this.recentSearchs = list;
      Localstorage().setJSON(StorageKey.RECENT_LIST, this.recentSearchs);
    }
  }

  setStore(context, String name, String url, event) {
    Map<String, dynamic> map = {
      'name': name.trim(),
      'url': url,
      'searchTime': DateTime.now().toString()
    };
    if (this.recentSearchs.length >= 5) {
      this.recentSearchs.removeLast();
    }
    this.recentSearchs.insert(0, map);
    Localstorage().setJSON(StorageKey.RECENT_LIST, this.recentSearchs);
    sendGTMData({
      // 埋点
      "event": event,
      'ecommerce': {'search_term': name.trim()}
    });
    if (url != null && url != '') {
      handleSchema(context, url);
    } else {
      Routes.push(context, Routes.category, params: {
        'isSearchPage': 'true',
        'keyword': name,
      });
    }
    notifyListeners();
  }
}
