import 'package:homary/api/account_setting.dart';
import 'package:homary/common/utils/analytics.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/common/utils/utils.dart';
import 'package:homary/entity/close_account_info_res.dart';
import 'package:homary/entity/close_account_reason_res.dart';
import 'package:homary/main.dart';

class CloseAccountCtrl extends ChangeNotifier {
  CloseAccountInfoData data;
  CloseAccountReasonData reasonData;

  int status = 0;

  /// 显示密码
  bool isShowPassword = true;
  bool isPasswordError = false;
  String password;

  /// 选择原因
  bool isShowInput = false;
  bool isReasonError = false;
  String reason;

  CloseAccountCtrl() {
    init();
  }

  void init({bool showLoading = true}) async {
    if (showLoading) {
      Toast.loading();
    }
    final result = await AccountSettingApi.getCloseAccountInfo();
    if (result.error == null) {
      Toast.clear();
      CloseAccountInfoRes res = CloseAccountInfoRes.fromJson(result.result);
      data = res.data;
      showDefault();
    }
  }

  /// 取消申请
  void cancel() async {
    Toast.loading();
    final result = await AccountSettingApi.cancelClose();
    if (result.error == null) {
      init(showLoading: false);
    }
  }

  /// 校验密码
  void verifyPassword() async {
    if (isEmpty(password)) {
      isPasswordError = true;
      notifyListeners();
      return;
    }

    Toast.loading();
    final result = await AccountSettingApi.verifyPassword(params: {
      'password': password,
    });

    isPasswordError = result.error != null;
    if (!isPasswordError) {
      await getApplyList();
      Toast.clear();
      showReason();
      return;
    }
    Toast.clear();
    notifyListeners();
  }

  /// 获取取消账户原因选项
  Future<void> getApplyList({showLoading = false}) async {
    if(showLoading){
      Toast.loading();
    }
    final result = await AccountSettingApi.getApplyList();
    if (result.error == null) {
      if(showLoading){
        Toast.clear();
      }
      CloseAccountReasonRes res = CloseAccountReasonRes.fromJson(result.result);
      reasonData = res.data;
    }
  }

  /// 关闭账户
  void closeAccount() async {
    final contentIterable =
        reasonData.content.where((element) => element.isSelect);
    if (contentIterable == null || contentIterable.length==0) {
      Toast.message(
          S.of(navigatorKey.currentContext).account_setting_reason_empty);
      return;
    }
    // 埋点
    sendGTMData({'event': 'custom_close_account'});

    final content = contentIterable.first;
    if (content.code == 'OTHER' && isEmpty(reason)) {
      isReasonError = true;
      notifyListeners();
      return;
    }
    Toast.loading();
    final result = await AccountSettingApi.closeAccount(params: {
      'apply_code': content.code,
      'content': content.code == 'OTHER' ? reason : content.content,
    });
    if (result.error == null) {
      init(showLoading: false);
    }
  }

  /// 显示Miss you 首屏
  void showDefault() {
    status = 0;
    notifyListeners();
  }

  /// 显示不可关闭账户的原因
  void showPassword() {
    status = 1;
    notifyListeners();
  }

  /// 显示选择原因
  void showReason() {
    status = 2;
    notifyListeners();
  }

  /// 显示不可关闭账户的原因
  void showUnable() {
    status = 3;
    notifyListeners();
  }

  /// 切换密码明文显示
  void togglePassword() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }

  /// 选择关闭账户原因
  void checkReason(int index) {
    reasonData.content.forEach((element) {
      element.isSelect = false;
    });
    reasonData.content[index].isSelect = true;
    if (reasonData.content[index].code != 'OTHER') {
      isReasonError = false;
      isShowInput = false;
    } else {
      isShowInput = true;
    }
    notifyListeners();
  }

  /// 输入原因
  void onReasonChange(String str) {
    if (!isEmpty(str)) {
      if (isReasonError) {
        isReasonError = false;
        notifyListeners();
      }
    }
    reason = str;
  }
}
