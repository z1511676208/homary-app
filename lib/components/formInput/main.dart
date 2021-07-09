import 'package:homary/common/style/main.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String innerText;
  final bool isPwd;
  final Function onSaved;
  final Function validator;
  final bool enable;

  const Input(
      {Key key,
      @required this.innerText,
      this.onSaved,
      this.validator,
      this.enable = true,
      this.isPwd = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: this.isPwd,
        enabled: this.enable,
        decoration: InputDecoration(
            labelText: this.innerText,
            hintText: this.innerText,
            contentPadding: EdgeInsets.only(
                top: 16.h, right: 12.w, bottom: 16.h, left: 12.w),
            border: OutlineInputBorder(
              borderRadius: AppStyle.primaryBorderRaduis,
              borderSide: BorderSide(
                width: 1.w,
                color: AppColor.primaryBorderOutline,
                style: BorderStyle.solid,
              ),
            )),
        onSaved: (val) => this.onSaved(val),
        validator: (val) => this.validator(val));
  }
}
