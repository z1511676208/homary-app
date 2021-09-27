import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:homary/common/utils/main.dart';

class ProductPagination extends SwiperPlugin {
  const ProductPagination();

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    int itemCount = config.itemCount;
    int activeIndex = config.activeIndex;

    return Container(
      width: 50.5.w,
      height: 25.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xB3FFFFFF),
        borderRadius: BorderRadius.circular(12.5.w),
      ),
      child: Text('(${activeIndex + 1}/$itemCount)',style: TextStyle(
        fontSize: 12.sp,
      ),),
    );
  }
}
