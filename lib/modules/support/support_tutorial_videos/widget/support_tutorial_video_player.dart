import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/cupertino.dart';

class SupportTutorialVideoPlayer extends StatefulWidget {
  const SupportTutorialVideoPlayer({
    required this.link,
    super.key,
  });
  final String link;
  @override
  State<SupportTutorialVideoPlayer> createState() =>
      _SupportTutorialVideoPlayerState();
}

class _SupportTutorialVideoPlayerState
    extends State<SupportTutorialVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;
  final CustomVideoPlayerSettings _customVideoPlayerSettings =
      const CustomVideoPlayerSettings();
  bool _isInitialized = false;
  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
      widget.link,
    )..initialize().then((value) {
        _isInitialized = true;
        setState(() {});
        _customVideoPlayerController.videoPlayerController.play();
      });
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: _customVideoPlayerSettings,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _isInitialized
          ? _customVideoPlayerController.videoPlayerController.value.aspectRatio
          : 1.77,
      child: CustomVideoPlayer(
        customVideoPlayerController: _customVideoPlayerController,
      ),
    );
  }
}
