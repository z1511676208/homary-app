/*
 * @Author       : zhhjie
 * @Date         : 2021-08-23 10:55:22
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-23 14:10:12
 */
import 'package:homary/common/config/packageInfo.dart';
import 'package:homary/common/utils/main.dart';
import 'package:homary/components/goBackAppBar/main.dart';
import 'package:homary/widget/listTileItem.dart';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GoBackAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTileItem(
                title: Text('update version'),
                desc: Text('v${packageInfo.version}'),
              ),
              OutlinedButton(
                onPressed: () {},
                child: Text('logout'),
              )
            ],
          ),
        ));
  }
}
