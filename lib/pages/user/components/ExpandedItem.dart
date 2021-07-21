import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';

class ExpandedItem extends StatefulWidget {
  String num;
  String title;
  ExpandedItem(this.num, this.title, {Key key}) : super(key: key);

  @override
  _ExpandedItemState createState() => _ExpandedItemState();
}

class _ExpandedItemState extends State<ExpandedItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        flex: 1,
        child: Container(
          height: 100.h,
          // color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(widget.num,
                    style:
                        TextStyle(fontSize: 18.w, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                  child: Text(widget.title, style: TextStyle(fontSize: 12.w)))
            ],
          ),
        ),
      ),
    );
  }
}
