import 'package:homary/common/utils/main.dart';
import 'package:homary/widget/networkImg.dart';
import 'package:dio_log/dio_log.dart';

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
        TextButton(
            onPressed: () {
              Routes.getCurPath();
            },
            child: Text('路由')),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HttpLogListWidget(),
                ),
              );
            },
            child: Text('Dio log 中心'))
      ],
    );
  }
}
