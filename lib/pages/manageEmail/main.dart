import 'package:flutter/gestures.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/bottomSheet/keep_alive_bottom_sheet.dart';
import 'package:homary/components/button/button.dart';
import 'package:homary/components/goBackAppBar/main.dart';
import 'package:homary/pages/manageEmail/controller.dart';
import 'package:homary/pages/signIn/components/ArticlePopup.dart';

class ManageEmailPage extends StatelessWidget {
  const ManageEmailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ManageEmailCtrl(),
      child: KeepAliveBottomSheet(
        bottomSheet: [ArticlePopup('57'), ArticlePopup('58')],
        child: Scaffold(
          backgroundColor: AppColor.primaryBackground,
          appBar: GoBackAppBar(
            title: S.of(context).account_setting_manage_email,
          ),
          body: Consumer<ManageEmailCtrl>(
            builder: (context, ctrl, __) {
              if (ctrl.data == null) {
                return Container();
              }
              return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                    top: 10.w,
                    bottom: 10.w + MediaQuery.of(context).padding.bottom,
                  ),
                  child: Column(
                    children: [
                      buildTop(context, ctrl),
                      SizedBox(height: 10.w),
                      buildCenter(context, ctrl),
                      SizedBox(height: 10.w),
                      buildBottom(context, ctrl),
                    ],
                  ));
            },
          ),
        ),
      ),
    );
  }

  Widget buildCart(Widget child) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 18.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: child,
    );
  }

  Widget buildTop(BuildContext context, ManageEmailCtrl ctrl) {
    return buildCart(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Manage Email Preferences',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        Container(
          width: double.infinity,
          height: 0.5.w,
          color: Color(0xFFE2E2E2),
          margin: EdgeInsets.only(
            top: 12.w,
            bottom: 15.5.w,
          ),
        ),
        Text(
          'Get updates on the topics that interest you',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 12.w),
        Text(
          'It may take up to 48 hours for any changes to be applied. We will continue to send you emails about your shipping, delivery, and order information regardless of your email subscription.',
          style: TextStyle(
            fontSize: 12.sp,
          ),
        ),
      ],
    ));
  }

  Widget buildCenter(BuildContext context, ManageEmailCtrl ctrl) {
    return buildCart(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What do you want in your inbox?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 12.sp),
        Text(
          'Be the first to know about daily deals, promotions, and other exclusive savings.',
          style: TextStyle(
            fontSize: 14.sp,
          ),
        ),
      ],
    ));
  }

  Widget buildBottom(BuildContext context, ManageEmailCtrl ctrl) {
    return buildCart(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
              child: Container(
                height: 40.w,
                child: Row(
                  children: [
                    index == 1 ?? false
                        ? Image.asset(
                            'assets/images/common/checkbox.png',
                            width: 16.w,
                            height: 16.w,
                          )
                        : Container(
                            width: 16.w,
                            height: 16.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.w),
                              border: Border.all(
                                  color: AppColor.primaryBorderOutline,
                                  width: 1.w),
                            ),
                          ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'xxxxxx xxxx xxxxx',
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Container(
          width: double.infinity,
          height: 0.5.w,
          color: Color(0xFFE2E2E2),
          margin: EdgeInsets.only(
            top: 12.w,
            bottom: 15.5.w,
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(style: TextStyle(
            fontSize: 12.sp,
            color: AppColor.primaryText,
          ), children: [
            TextSpan(text: 'By subscribing to our newsletter,you agree to The '),
            TextSpan(
              text: S.of(context).register_privacy,
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  KeepAliveBottomSheetManager.of(context).show(index: 0);
                },
            ),
            TextSpan(text: S.of(context).register_agreeTipsAnd),
            TextSpan(
              text: S.of(context).register_terms,
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  KeepAliveBottomSheetManager.of(context).show(index: 1);
                },
            ),
          ]),
        ),
        SizedBox(height: 14.sp),
        AppRoundedButton(
          width: double.infinity,
          height: 44.w,
          type: AppRoundedButtonType.DefaultBlack,
          onTap: () {},
          child: Text(
            'Save Changes',
            style: TextStyle(
              fontSize: 15.sp,
            ),
          ),
        ),
      ],
    ));
  }
}
