import 'package:homary/common/utils/main.dart';

class TopNav extends StatelessWidget {
  TopNav({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        pinned: true, floating: true, delegate: _SliverAppBarDelegate());
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final List<String> _topNavList = [
    'Ceiling Lights',
    'Wall Lights',
    'Table & Floor Lamps',
    'Semi Flush Lights',
    'Pendant Lights',
    'Ceiling Fans',
  ];

  Widget _topNavItem(idx) {
    return Container(
      height: 32.w,
      padding: EdgeInsets.only(right: 12.w),
      child: OutlinedButton(
          onPressed: () {},
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.w)),
            side: MaterialStateProperty.all(
                BorderSide(color: AppColor.primaryBorderOutline)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)))),
          ),
          child: Text(_topNavList[idx],
              style:
                  TextStyle(fontSize: 12.sp, color: AppColor.primarySubTitle))),
    );
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: Colors.white,
        height: 32.w,
        width: 254.5.w,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _topNavItem(index);
          },
          itemCount: _topNavList.length,
        ));
  }

  @override
  double get maxExtent => 32.w;

  @override
  double get minExtent => 32.w;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
