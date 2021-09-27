import 'package:chewie/chewie.dart';
import 'package:homary/common/utils/main.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {

  const VideoWidget({Key key, this.url}) : super(key: key);
  final String url;

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {

  ChewieController chewieController;
  VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async{
    videoPlayerController = VideoPlayerController.network(widget.url);
    await videoPlayerController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: true,
      aspectRatio: videoPlayerController.value.aspectRatio,
    );
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController?.dispose();
    chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(chewieController == null){
      return Container();
    }
    return Center(
      child: AspectRatio(
        aspectRatio: videoPlayerController.value.aspectRatio,
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }
}
