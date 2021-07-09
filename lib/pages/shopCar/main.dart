import 'package:homary/components/goBackAppBar/main.dart';
import 'package:homary/common/utils/main.dart';

class ShopCarPage extends StatelessWidget {
  const ShopCarPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBackAppBar(),
      body: Center(
        child: Text('shop car'),
      ),
    );
  }
}
