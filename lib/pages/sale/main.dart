import 'package:homary/common/utils/main.dart';
import 'package:homary/widget/networkImg.dart';

class SalePage extends StatelessWidget {
  const SalePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyImage(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAG8Fmhxr42POEUjJ_d-1qSvRDmkuvkWz7fw&usqp=CAU',
          width: 260.w,
        ),
      ],
    );
  }
}
