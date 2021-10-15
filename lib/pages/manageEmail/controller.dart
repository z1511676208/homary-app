import 'package:homary/api/account_setting.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';

class ManageEmailCtrl extends ChangeNotifier{

  dynamic data = 0;

  ManageEmailCtrl(){
    init();
  }

  void init({bool showLoading = true}) async {
    if (showLoading) {
      Toast.loading();
    }
    final result = await AccountSettingApi.getSubscribeList();
    if (result.error == null) {
      Toast.clear();
      notifyListeners();
    }
  }

  void submit(){
    // 埋点
    sendGTMData({'event': 'custom_unsubscribe'});
  }
}