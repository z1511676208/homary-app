/*
 * @Author       : JHao
 * @Date         : 2021-09-08 15:30:57
 * @LastEditors  : JHao
 * @LastEditTime : 2021-09-28 18:09:00
 */
class StorageKey {
  /// requset api 本地存储
  static const String REQUEST_URL = 'storage_request_url';

  /// 动态参数
  static const String DYNAMIC_DATA = 'dynamic_data';

  /// 登录token
  static const String TOKEN = 'token';

  /// 最近搜索
  static const String RECENT_LIST = 'recent_list';

  /// 新人优惠券标记
  static const String NEW_USER_COUPON = 'new_user_coupon';

  /// 唯一ID
  static const String EID = 'EID';

  /// 用户信息
  static const String USER_INFO = 'userInfo';

  /// 是否登录
  static const String IS_LOGIN = 'isLogin';

  /// 上报设备ID
  static const String IS_PUSH_DEVICE_ID = 'isPushDeviceId';

  /// 语言站点货币配置项
  static const String CURRENT_CONFIG = 'currentConfig';

  /// 更新弹窗打开时间
  static const String UPGRADE_POP_TIME = 'upgradePopTime';

  // 首页广告区
  static const String HOME_ADV_CACHE = "home_adv";

  // ETA
  static const String ETA_CACHE = "ETA_AreaData";
  // GA Ticket
  static const String GA_TICKET_LIST = "APP_GA_TICKET_LIST";
}
