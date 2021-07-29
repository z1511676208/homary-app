/*
 * @Author       : zhhjie
 * @Date         : 2021-07-28 16:10:53
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-30 11:12:08
 */
import 'package:flutter/material.dart';
import 'package:homary/common/utils/main.dart';

class ExpandedItem extends StatelessWidget {
  final String num;
  final String title;
  const ExpandedItem(this.num, this.title, {Key key}) : super(key: key);

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
                child: Text(this.num,
                    style:
                        TextStyle(fontSize: 18.w, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                  child: Text(this.title, style: TextStyle(fontSize: 12.w)))
            ],
          ),
        ),
      ),
    );
  }
}
