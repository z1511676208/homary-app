import 'package:homary/common/utils/main.dart';
import 'package:homary/components/goBackAppBar/main.dart';

class AccountSettingPage extends StatelessWidget {
  AccountSettingPage({Key key}) : super(key: key);

  final List<_SettingEntity> list = [];

  void init(BuildContext context) {
    list.clear();
    list.addAll([
      _SettingEntity(S.of(context).account_setting_my_info,
          'https://m.homary.com/usercenter/personal', S.of(context).info),
      _SettingEntity(
          S.of(context).account_setting_change_password,
          'https://m.homary.com/usercenter/password',
          S.of(context).account_setting_change_password),
      // _SettingEntity(
      //     S.of(context).account_setting_manage_email, Routes.manageEmail, ''),
      _SettingEntity(
          S.of(context).account_setting_close_account, Routes.closeAccount, ''),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    return Scaffold(
      backgroundColor: AppColor.primaryBackground,
      appBar: GoBackAppBar(
        title: S.of(context).account_setting,
      ),
      body: Container(
        margin: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (list[index].url.startsWith('https://')) {
                  Routes.push(context, '/webview', params: {
                    "appBarTitle": list[index].urlTitle,
                    "content": '{"url":"${list[index].url}"}'
                  });
                } else {
                  Routes.push(context, list[index].url);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 17.5.w,
                  horizontal: 15.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        list[index].title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(
                      Iconfont.ArrowRight,
                      size: 12.w,
                      color: AppColor.primaryBorderLight,
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Container(
              height: 1.w,
              margin: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              color: Color(0xFFEBEBEB),
            );
          },
        ),
      ),
    );
  }
}

class _SettingEntity {
  final String title;
  final String url;
  final String urlTitle;

  _SettingEntity(this.title, this.url, this.urlTitle);
}
