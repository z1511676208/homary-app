import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';

class FlexItem extends StatefulWidget {
  String text;
  Widget Icon;
  FlexItem(this.text, this.Icon, {Key key}) : super(key: key);

  @override
  _FlexItemState createState() => _FlexItemState();
}

class _FlexItemState extends State<FlexItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        flex: 1,
        child: Container(
          height: 90.h,
          // color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.Icon,
              SizedBox(
                height: 14.h,
              ),
              Container(
                  child: Text(widget.text, style: TextStyle(fontSize: 12.w)))
            ],
          ),
        ),
      ),
    );
  }
}
