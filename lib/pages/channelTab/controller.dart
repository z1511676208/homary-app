import 'package:homary/api/product.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/entity/home.dart';
import 'package:homary/entity/topic_flow_res.dart';

class ChannelTabCtrl extends ChangeNotifier {
  bool _isDispose = false;

  ///1=new；2=sale
  String type;

  String channelId;

  String bannerImgUrl;

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

  /// channel列表
  List<ChannelList> channelList = [];

  ChannelTabCtrl(this.channelId, this.type);

  @override
  void dispose() {
    super.dispose();
    _isDispose = true;
  }

  void _safeNotifyListeners() {
    if (_isDispose) {
      return;
    }
    notifyListeners();
  }

  /// 获取页面数据
  Future<void> getTopicFlow(
      {bool isNeedClean = false, bool isOnRefresh = false}) async {
    if (page == 1) {
      if (!isOnRefresh) {
        Toast.loading();
      }
    } else {
      isLoading = true;
      _safeNotifyListeners();
    }
    final result = await ProductApi.getTopicFlow(params: {
      'channel_id': int.tryParse(channelId ?? ''),
      'page': page++,
      'size': size,
      'type': type,
    });

    if (result.result != null) {
      TopicFlowRes res = TopicFlowRes.fromJson(result.result);

      bannerImgUrl = res.data.activityInfo?.imgUrl;

      channelList.clear();
      channelList.addAll(res.data.channelList ?? []);

      if (isNeedClean) {
        productList.clear();
      }
      productList.addAll(res.data.activityProduct ?? []);
      hasMorePage = res.data.hasMorePage ?? 0;
      if (int.parse(res.data.total ?? '0') == 0) {
        isShowEmpty = true;
      } else {
        isShowEmpty = false;
      }
    }
    Toast.clear();
    isLoading = false;
    _safeNotifyListeners();
  }

  /// 修改channel
  void changeChannel(int index) {
    channelList.forEach((element) {
      element.isSelected = 0;
    });
    channelList[index].isSelected = 1;
    channelId = channelList[index].channelId;
    page = 1;
    hasMorePage = 0;
    getTopicFlow(isNeedClean: true);
  }

  Future<void> onRefresh({bool isOnRefresh = true}) async {
    page = 1;
    hasMorePage = 0;
    await getTopicFlow(isNeedClean: true,isOnRefresh: isOnRefresh);
  }
}
