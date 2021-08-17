/*
 * @Author       : zhhjie
 * @Date         : 2021-07-13 10:15:30
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-19 14:48:01
 */
import 'package:homary/common/style/main.dart';
import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String innerText; //输入框placeholder
  final String errorText;
  final bool isPwd; //是否密码框
  final Function onSaved; //保存事件
  final Function validator; //校验事件 错误返回字符串错误信息，正确返回null
  final Function onChange; //input onchang事件
  final Function onBlur; //input 失焦事件
  final Function onFocus; //input 聚焦事件
  final Function onClear; //input 清除事件
  final bool enable;
  final bool autoValidator; //是否onchanged自动校验
  final TextEditingController textController; //文本控制器--可以控制输入框内容
  final FocusNode focusNode; //类似输入框焦点控制，可以监听到焦点触发事件，也可以手动聚焦失焦
  Input(
      {Key key,
      @required this.innerText,
      this.errorText,
      this.onSaved,
      this.validator,
      this.onChange,
      this.onFocus,
      this.onBlur,
      this.onClear,
      this.enable = true,
      this.isPwd = false,
      this.autoValidator = false,
      this.focusNode,
      this.textController})
      : super(key: key);

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  FocusNode focusNode;
  TextEditingController textEditingController;
  bool isFocus = false;
  String errorText;
  bool showCloseIcon = false;
  bool obscureText = false;

  void focusEventListener() {
    setState(() {
      isFocus = focusNode.hasFocus;
      showCloseIcon = isFocus && textEditingController.text.trim() != '';
    });
    if (!focusNode.hasFocus) {
      if (widget.validator != null) {
        errorText = widget.validator(textEditingController.text.trim());
      }
      widget.onBlur != null &&
          widget.onBlur(textEditingController.text.trim() ?? '');
    } else {
      widget.onFocus != null && widget.onFocus(textEditingController.text);
    }
  }

  void textIsEmptyListener() {
    if (textEditingController.text == '') {
      errorText = null;
    }
  }

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPwd ?? false;
    focusNode = widget.focusNode ?? FocusNode();
    textEditingController = widget.textController ?? TextEditingController();
    focusNode.addListener(focusEventListener);
    textEditingController.addListener(textIsEmptyListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    focusNode.removeListener(focusEventListener);
    textEditingController.removeListener(textIsEmptyListener);
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: AppStyle.primaryBorderRaduis,
              border: Border.all(
                width: 1.w,
                color: errorText != null
                    ? AppColor.primaryErrorTip
                    : isFocus
                        ? AppColor.primaryColor
                        : AppColor.primaryBorderOutline,
                style: BorderStyle.solid,
              ),
            ),
            child: TextFormField(
              controller: textEditingController,
              obscureText: obscureText,
              enabled: widget.enable,
              focusNode: focusNode,
              decoration: InputDecoration(
                  labelStyle: TextStyle(fontSize: 16.sp),
                  labelText: widget.innerText,
                  // hintText: this.innerText,
                  contentPadding: EdgeInsets.only(
                      top: 9.h, right: 12.w, bottom: 9.h, left: 12.w),
                  border: InputBorder.none),
              onSaved: (val) {
                if (widget.validator != null) {
                  setState(() {
                    errorText = widget.validator(val.trim());
                  });
                }
                if (widget.onSaved != null) {
                  widget.onSaved(val.trim(), errorText);
                }
              },
              onChanged: (val) {
                setState(() {
                  showCloseIcon = val != '';
                });
                if (widget.onChange != null) {
                  widget.onChange(val);
                }
                if (widget.autoValidator) {
                  errorText = widget.validator(val);
                }
              },
              // validator: (val) => widget.validator(val)
            )),
        Positioned(
            top: 8.w,
            right: 2.w,
            child: Offstage(
              offstage: !showCloseIcon || widget.isPwd,
              child: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    showCloseIcon = false;
                  });
                  textEditingController.clear();
                  if (widget.onClear != null) {
                    widget.onClear();
                  }
                },
              ),
            )),
        Positioned(
            top: 8.w,
            right: 8.w,
            child: Offstage(
              offstage: !widget.isPwd,
              child: IconButton(
                iconSize: 16.w,
                icon: obscureText
                    ? Icon(Iconfont.PwdClose)
                    : Icon(Iconfont.PwdOpen),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              ),
            )),
        Positioned(
            top: 56.w,
            left: 0,
            child: Offstage(
              offstage: errorText == null,
              child: Container(
                width: 325.w,
                margin: EdgeInsets.only(top: 6.w),
                alignment: Alignment.centerLeft,
                child: Text(
                  errorText ?? '',
                  style: TextStyle(color: AppColor.primaryErrorTip),
                ),
              ),
            )),
      ],
    );
  }
}
