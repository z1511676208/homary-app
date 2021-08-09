/*
 * @Author       : zhhjie
 * @Date         : 2021-07-13 10:15:30
 * @LastEditors  : JHao
 * @LastEditTime : 2021-07-20 17:56:17
 */
import 'package:cached_network_image/cached_network_image.dart';
import 'package:homary/common/utils/main.dart';

class CustomNetworkImage extends StatefulWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;

  CustomNetworkImage(this.url,
      {this.height, this.width, this.fit = BoxFit.cover, Key key})
      : super(key: key);

  @override
  _CustomNetworkImageState createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: widget.width,
      height: widget.height,
      memCacheWidth: widget.width?.toInt(),
      memCacheHeight: widget.height?.toInt(),
      fit: widget.fit,
      imageUrl: widget.url,
      placeholder: (context, url) => Image.asset(
        'assets/baseImage.png',
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
      ),
      errorWidget: (context, url, error) => Image.asset(
        'assets/baseImage.png',
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
      ),
    );
  }
}
