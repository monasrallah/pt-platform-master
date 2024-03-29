import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayer extends StatefulWidget {
  MyVideoPlayer({
    this.fullScreen = false,
    super.key,
    required this.videoUrl,
    required this.onVideoChanged,
  });

  final bool fullScreen;
  String videoUrl;
  final Function(String) onVideoChanged;

  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayerController();
  }

  @override
  void didUpdateWidget(covariant MyVideoPlayer oldWidget) {
    changeVideo();
    super.didUpdateWidget(oldWidget);
  }

  void _initializeVideoPlayerController() {
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
      // progressIndicatorDelay: Duration(seconds: 1),
      // draggableProgressBar: false,
      fullScreenByDefault: widget.fullScreen,
      showControlsOnInitialize: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.lightGreen,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.grey,
      ),
      placeholder: SizedBox(
        width: 1.sw,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        ),
      ),
      autoInitialize: true,
    );
  }

  void changeVideo() {
    _videoPlayerController.pause();
    _videoPlayerController.dispose();
    _chewieController.dispose();

    setState(() {
      _initializeVideoPlayerController();
    });

    widget.onVideoChanged(widget.videoUrl);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}
