/*
 * @Author       : zhhjie
 * @Date         : 2021-07-12 15:32:59
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-17 11:00:55
 */
import 'package:homary/common/utils/main.dart';

class ConfigItem extends StatelessWidget {
  final Widget trailing; //图标
  final String title;
  final configData;
  final int configType;
  const ConfigItem(
      {Key key, this.trailing, this.title, this.configData, this.configType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<GlobalConfig>(context, listen: false)
            .updateCurrentConfig(configData, configType);
        Provider.of<GlobalConfig>(context, listen: false)
            .getShoppingCartNumber();
        Navigator.of(context).pop();
      },
      child: Container(
        height: 44.h,
        padding: EdgeInsets.only(right: 12.w),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Offstage(
              offstage: trailing == null,
              child: Container(
                margin: EdgeInsets.only(right: 10.w),
                child: trailing,
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: AppColor.primaryText),
              ),
            ),
            Consumer<GlobalConfig>(builder:
                (BuildContext context, GlobalConfig globalConfig, child) {
              return Offstage(
                offstage: (configType == 1 &&
                        configData?.countryCode !=
                            globalConfig?.currentConfig?.countryCode) ||
                    (configType == 2 &&
                        configData?.code !=
                            globalConfig?.currentConfig?.language) ||
                    (configType == 3 &&
                        configData?.code !=
                            globalConfig?.currentConfig?.currency),
                child: Icon(Icons.check),
              );
            })
          ],
        ),
      ),
    );
  }
}
