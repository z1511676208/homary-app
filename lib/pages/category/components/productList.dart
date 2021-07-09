import 'package:homary/common/utils/main.dart';

class ProductList extends StatelessWidget {
  ProductList({Key key}) : super(key: key);

  final List<Map<String, dynamic>> _productList = [
    {
      "title": "Wall Lights",
      "info": [
        {"image": "heecvrll", "name": "sdflllkeUwr"},
        {"image": "heecvrll", "name": "wttk"},
        {"image": "heecvrll", "name": "wttk"},
        {"image": "heecvrll", "name": "sdfef * sldfke"},
        {"image": "heecvrll", "name": "wttk"}
      ]
    },
    {
      "title": "Ceiling Lights",
      "info": [
        {"image": "heecvrll", "name": "sdfsdf"},
        {"image": "heecvrll", "name": "wttk"},
        {"image": "heecvrll", "name": "sdfefe"},
        {"image": "heecvrll", "name": "wttk"},
        {"image": "heecvrll", "name": "wsdfsdfttk"}
      ]
    },
    {
      "title": "Renovation Lights",
      "info": [
        {"image": "heecvrll", "name": "welrwler"},
        {"image": "heecvrll", "name": "wttk"},
        {"image": "heecvrll", "name": "sdlfkdf"},
        {"image": "heecvrll", "name": "wttk"},
        {"image": "heecvrll", "name": "ooiuwe"}
      ]
    },
    {
      "title": "Outdoor",
      "info": [
        {"image": "heecvrll", "name": "powerir"},
        {"image": "heecvrll", "name": "cvxv"},
        {"image": "heecvrll", "name": "wtwerwtk"},
        {"image": "heecvrll", "name": "oov"},
        {"image": "heecvrll", "name": "sdfefwwer"}
      ]
    },
    {
      "title": "PetRenov",
      "info": [
        {"image": ";ppe", "name": "wttk"},
        {"image": "heecvrll", "name": "llsdjfe"},
        {"image": "234", "name": "dfkke"},
        {"image": "qwee", "name": "sde"},
        {"image": "dfefe", "name": "dsfefe"}
      ]
    },
  ];

  Widget _productItem(int idx) {
    /// product list
    List<Map<String, dynamic>> productInfo = _productList[idx]['info'];
    List<Widget> products = productInfo.map((element) {
      return Container(
          width: 65.w,
          margin: EdgeInsets.only(top: 14.5.h),
          child: Column(children: [
            Container(height: 65.w, width: 65.w, child: Placeholder()),
            SizedBox(height: 15.h),
            Text(element["name"],
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColor.primaryText, fontSize: 14.sp))
          ]));
    }).toList();
    return Container(
        padding: EdgeInsets.only(top: 20.h),
        width: 233.w,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  _productList[idx] != null ? _productList[idx]['title'] : '',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10.5.h),
            Wrap(
              spacing: 14.w,
              children: products,
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return _productItem(index);
      }, childCount: _productList.length),
    );
  }
}
