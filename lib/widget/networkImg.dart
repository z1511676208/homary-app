import 'package:homary/common/utils/main.dart';
import 'package:extended_image/extended_image.dart';

class MyImage extends StatefulWidget {
  final String url;
  final bool cache;
  final double width;
  final double height;
  final BoxFit fit;

  MyImage(this.url,
      {this.height,
      this.width,
      this.cache = true,
      this.fit = BoxFit.fill,
      Key key})
      : super(key: key);

  @override
  _MyImageState createState() => _MyImageState();
}

class _MyImageState extends State<MyImage> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
        lowerBound: 0.0,
        upperBound: 1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      widget.url,
      width: widget.width,
      height: widget.height,
      cache: widget.cache,
      fit: widget.fit,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {

          /// loading 状态
          case LoadState.loading:
            _controller.reset();
            return Placeholder();
            break;

          /// 图片加载完成
          case LoadState.completed:
            _controller.forward();
            return FadeTransition(
              opacity: _controller,
              child: ExtendedRawImage(
                image: state.extendedImageInfo?.image,
                width: widget.width,
                height: widget.height,
              ),
            );
            break;

          /// 图片加载失败
          case LoadState.failed:
            _controller.reset();
            return Placeholder();
            break;

          /// 默认图
          default:
            return Image.asset('assets/baseImage.png');
        }
      },
    );
  }
}
