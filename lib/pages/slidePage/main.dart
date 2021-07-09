/*
 * @Author       : zhhjie
 * @Date         : 2021-07-07 15:15:08
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-07-07 15:42:24
 */
import 'package:homary/common/utils/main.dart';

class SlidePage extends StatefulWidget {
  final String id;
  SlidePage(this.id, {Key key}) : super(key: key);

  @override
  _SlidePageState createState() => _SlidePageState();
}

class _SlidePageState extends State<SlidePage> {
  List<Widget> _pageList = [
    new Center(
      child: Text('1'),
    ),
    new Center(
      child: Text('2'),
    ),
    new Center(
      child: Text('3'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    PageController _pageController =
        new PageController(initialPage: int.parse(widget.id));
    void nextPage() {
      _pageController.nextPage(
          duration: Duration(milliseconds: 100), curve: Curves.ease);
    }

    void previousPage() {
      _pageController.previousPage(
          duration: Duration(milliseconds: 100), curve: Curves.ease);
    }

    return Container(
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (value) {
              if (value == 0) {
                _pageController.jumpToPage(_pageList.length);
              }
            },
            itemBuilder: (context, index) {
              return _pageList[index % _pageList.length];
            },
          ),
          Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: nextPage, child: Text('next')),
                  ElevatedButton(onPressed: previousPage, child: Text('pre')),
                  ElevatedButton(
                    onPressed: () {
                      Routes.pop();
                    },
                    child: Text('back'),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
