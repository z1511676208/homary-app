import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:homary/common/utils/app_update.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/entity/appUpgrade.dart';

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({Key key, this.upGradeInfo}) : super(key: key);

  final UpgradeRes upGradeInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: AppStyle.primaryBorderRaduis, color: Colors.white),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Update Available:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          SizedBox(
            width: double.infinity,
            height: 12.w,
          ),
          Text(
            'Latest version:v${upGradeInfo.data.upgradeVersion}',
            style: TextStyle(fontSize: 14.sp),
          ),
          SizedBox(
            width: double.infinity,
            height: 12.w,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: HtmlWidget(upGradeInfo.data.content ?? ''),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 12.w,
          ),
          Container(
              width: double.infinity,
              height: 40.w,
              child: Builder(builder: (ctx) {
                return OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(AppColor.primaryColor),
                      elevation: MaterialStateProperty.all(0),
                      overlayColor: MaterialStateProperty.all(
                          AppColor.primaryPressed),
                      foregroundColor:
                      MaterialStateProperty.all(Colors.white),
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36.0.w),
                          ))),
                  onPressed: () async {
                    AppUpdateUtil.goAppStore();
                  },
                  child: Text('Update',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                );
              })),
          Offstage(
              offstage: upGradeInfo.data.isUpgrade == 1,
              child: Container(
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'No thanks',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: AppColor.primaryText),
                    )),
              ))
        ],
      ),
    );
  }
}
