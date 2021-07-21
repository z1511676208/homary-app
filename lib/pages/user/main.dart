import 'package:homary/common/utils/main.dart';
import 'components/FlexItem.dart';
import 'components/ExpandedItem.dart';
import 'components/PaddingItem.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: new Container(
            width: double.infinity,
            // height: double.infinity,
            decoration: new BoxDecoration(
              color: Colors.white,
            ),
            //测试Row对齐方式，排除Column默认居中对齐的干扰
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Container(
                      width: 46.w,
                      height: 46.h,
                      padding: EdgeInsets.only(right: 15.w),
                      child: Icon(
                        Iconfont.home_collect,
                      ),
                    ),
                    new Container(
                      width: 40.w,
                      height: 46.h,
                      child: Icon(
                        Iconfont.home_cart,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Text(
                        "Hi, Dengshuweibmkj",
                        style: TextStyle(
                            fontSize: 20.w, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    ExpandedItem('11', 'Coupons'),
                    ExpandedItem('18', 'Wishlist'),
                    ExpandedItem('25', 'Wiews')
                  ],
                ),
                PadingItem(),
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 16.0),
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Order',
                            style: TextStyle(
                                fontSize: 16.w, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'View All >',
                            style: TextStyle(
                                fontSize: 12.w,
                                color: Color.fromRGBO(153, 153, 153, 1)),
                          )
                        ],
                      ),
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        FlexItem('Unpaid', Icon(Iconfont.Unpaid, size: 24.0)),
                        FlexItem('Processing',
                            Icon(Iconfont.Processing, size: 24.0)),
                        FlexItem('Shipped', Icon(Iconfont.Shipped, size: 24.0)),
                        FlexItem('Returns', Icon(Iconfont.Returns, size: 24.0)),
                      ],
                    )
                  ],
                ),
                PadingItem(),
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 16.0),
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'More Services',
                            style: TextStyle(
                                fontSize: 16.w, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        FlexItem(
                            'Customer', Icon(Iconfont.Customer, size: 24.0)),
                        FlexItem('About', Icon(Iconfont.About, size: 24.0)),
                        FlexItem('Address', Icon(Iconfont.Address, size: 24.0)),
                        FlexItem(
                            'Personal', Icon(Iconfont.Personal, size: 24.0)),
                      ],
                    )
                  ],
                ),
                PadingItem(),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 16.0),
                          child: Text(
                            "Recently Browsed",
                            style: TextStyle(
                                fontSize: 16.w, fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        "You have not saved anything recently.",
                        style: TextStyle(
                            fontSize: 12.w,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                      )
                    ]),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 16.h,
                        ),
                        FlatButton(
                          child: Text("Go Shopping"),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Color.fromRGBO(34, 34, 34, 1),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(20.0)),
                          onPressed: () {},
                        ),
                        Container(
                          height: 40.h,
                        ),
                      ],
                    ),
                    PadingItem()
                  ],
                )
              ],
            )));
  }
}
