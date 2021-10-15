import 'package:homary/common/utils/main.dart';
import 'package:homary/components/button/button.dart';
import 'package:homary/pages/closeAccount/components/bubble_shape.dart';
import 'package:homary/pages/closeAccount/controller.dart';

class CloseAccountReason extends StatelessWidget {
  const CloseAccountReason({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CloseAccountCtrl ctrl = context.watch<CloseAccountCtrl>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ctrl.reasonData.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 8.w),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: ctrl.reasonData.content.length ?? 0,
          itemBuilder: (context, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => ctrl.checkReason(index),
              child: Container(
                height: 44.w,
                child: Row(
                  children: [
                    ctrl.reasonData.content[index].isSelect ?? false
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
                        ctrl.reasonData.content[index].content,
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
        Offstage(
          offstage: !ctrl.isShowInput,
          child: CustomPaint(
            painter: BubbleShape(ctrl.isReasonError
                ? AppColor.primaryErrorTip
                : Color(0xFFD6D6D6)),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity,
              ),
              child: TextField(
                maxLines: null,
                onChanged: ctrl.onReasonChange,
                style: TextStyle(
                  height: 1.3,
                  fontSize: 13.sp,
                ),
                keyboardType: TextInputType.multiline,
                cursorColor: AppColor.primaryText,
                decoration: InputDecoration(
                  hintText: S.of(context).account_setting_reason_error,
                  hintStyle: TextStyle(
                    fontSize: 13.sp,
                    color: ctrl.isReasonError
                        ? AppColor.primaryErrorTip
                        : AppColor.couponsHintColor,
                  ),
                  contentPadding: EdgeInsets.all(10.w),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 36.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppRoundedButton(
              width: 158.w,
              height: 44.w,
              type: AppRoundedButtonType.StrokeBlack,
              onTap: ctrl.showDefault,
              child: Text(
                S.of(context).account_setting_cancel,
                style: TextStyle(
                  color: AppColor.primaryText,
                  fontSize: 15.sp,
                ),
              ),
            ),
            AppRoundedButton(
              width: 158.w,
              height: 44.w,
              type: AppRoundedButtonType.DefaultBlack,
              onTap: ctrl.closeAccount,
              child: Text(
                S.of(context).account_setting_close_account,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
