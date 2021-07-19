/*
 * @Author       : zhhjie
 * @Date         : 2021-07-19 11:35:26
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-23 14:09:32
 */
import 'package:homary/common/utils/main.dart';
import 'package:homary/common/utils/toast.dart';
import 'package:homary/pages/search/controller.dart';
import 'components/default.dart';
import 'components/filterList.dart';

class SearchView extends StatefulWidget {
  SearchView({Key key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  void initState() {
    super.initState();
    Toast.loading();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<SearchCtrl>(context, listen: false)
          .getSearchHotKeywords();
      Provider.of<SearchCtrl>(context, listen: false).getStore();
      Toast.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(96.5.w),
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 5.w),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                        color: AppColor.primaryBorderBottomLine,
                        width: 0.5.w))),
            child: SafeArea(
              top: true,
              bottom: false,
              child: Row(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 34.w),
                    child: Container(
                      margin: EdgeInsets.only(left: 12.w),
                      height: 34.w,
                      width: MediaQuery.of(context).size.width - 84.w,
                      child: TextField(
                        onChanged: (val) {
                          Provider.of<SearchCtrl>(context, listen: false)
                              .inputChange(val);
                        },
                        onSubmitted: (val) {
                          Provider.of<SearchCtrl>(context, listen: false)
                              .getAnalyze(val);
                        },
                        maxLines: 1,
                        style: TextStyle(
                            color: AppColor.primaryText, fontSize: 14.sp),
                        decoration: InputDecoration(
                            isCollapsed: true,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.w),
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColor.primaryBorderLight,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.w,
                                color: AppColor.primaryBorderHard,
                                style: BorderStyle.none,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle:
                                TextStyle(color: AppColor.primarySubTitle),
                            hintText: 'Find anything home...'),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Provider.of<SearchCtrl>(context, listen: false)
                            .cancel();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: AppColor.primaryText),
                      ))
                ],
              ),
            )),
      ),
      body: Selector<SearchCtrl, bool>(
        selector: (context, SearchCtrl controller) {
          return controller.showFilter;
        },
        shouldRebuild: (pre, next) {
          return pre != next;
        },
        builder: (context, bool show, child) {
          return show ? FilterList() : DefaultView();
        },
      ),
    );
  }
}

class Search extends StatelessWidget {
  const Search({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchCtrl>(
          create: (context) => SearchCtrl(),
        )
      ],
      child: SearchView(),
    );
  }
}
