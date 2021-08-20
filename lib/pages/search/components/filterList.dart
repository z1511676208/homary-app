/*
 * @Author       : zhhjie
 * @Date         : 2021-07-19 16:26:00
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-20 16:34:13
 */
import 'package:homary/common/utils/main.dart';
import 'package:tuple/tuple.dart';
import '../controller.dart';
import 'package:substring_highlight/substring_highlight.dart';

class FilterList extends StatelessWidget {
  const FilterList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<SearchCtrl, Tuple2<List, String>>(
      builder: (BuildContext context, Tuple2<List, String> data, chlid) =>
          ListView.builder(
        itemBuilder: (BuildContext context, index) => Container(
            padding: EdgeInsets.symmetric(vertical: 3.w),
            margin: EdgeInsets.only(top: 16.w, left: 16.w),
            child: InkWell(
                onTap: () {
                  Provider.of<SearchCtrl>(context, listen: false).toProductList(
                    context,
                    data.item1[index].channelName,
                    data.item1[index].channelUrl,
                    'search_associate_click',
                  );
                },
                child: SubstringHighlight(
                  caseSensitive: false,
                  text: data.item1[index].channelName ?? '',
                  term: data.item2,
                  textStyle: TextStyle(
                    // non-highlight style
                    color: AppColor.primarySubTitle,
                  ),
                  textStyleHighlight: TextStyle(
                      // highlight style
                      color: AppColor.primaryText,
                      fontWeight: FontWeight.bold),
                ))),
        itemCount: data.item1.length,
      ),
      selector: (BuildContext context, SearchCtrl controller) {
        return Tuple2(controller.filterList, controller.keyword);
      },
      shouldRebuild: (previous, next) => previous != next,
    );
  }
}
