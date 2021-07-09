import 'package:homary/common/utils/main.dart';
import 'search/main.dart';

class GlobalAppbar extends StatelessWidget {
  const GlobalAppbar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            children: [
              // AppBar(
              //   backgroundColor: Colors.white,
              //   shadowColor: Colors.transparent,
              //   leading: IconButton(
              //     onPressed: () {},
              //     icon: Icon(Icons.menu),
              //   ),
              //   title: Center(
              //     child: Image.asset('assets/logo.png', width: 100),
              //   ),
              //   actions: [
              //     IconButton(
              //         color: Colors.black,
              //         icon: Icon(Icons.favorite_border),
              //         onPressed: () => Routes.push(
              //             context, '/favorite/p123?name=shean&price=31')),
              //     IconButton(
              //         color: Colors.black,
              //         icon: Icon(Icons.shopping_cart_outlined),
              //         onPressed: () {})
              //   ],
              // ),
              Row(
                children: [
                  Container(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                            color: Colors.black,
                            icon: Icon(
                              Icons.menu,
                            ),
                            onPressed: () => Scaffold.of(context).openDrawer())
                      ],
                    ),
                  ),
                  Flexible(
                      child: Center(
                    child: Image.asset('assets/logo.png', width: 100),
                  )),
                  Container(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                            color: Colors.black,
                            icon: Icon(Icons.favorite_border),
                            onPressed: () => Routes.push(
                                context, '/favorite/p123?name=shean&price=31')),
                        IconButton(
                            color: Colors.black,
                            icon: Icon(Icons.shopping_cart_outlined),
                            onPressed: () {})
                      ],
                    ),
                  )
                ],
              ),
              AppbarSearch()
            ],
          )),
    );
  }
}
