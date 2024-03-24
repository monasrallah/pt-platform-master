import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayer extends StatefulWidget {
  final bool fullScreen;
  final String videoUrl;
  final Function(String) onVideoChanged;

  const MyVideoPlayer({
    Key? key,
    this.fullScreen = false,
    required this.videoUrl,
    required this.onVideoChanged,
  }) : super(key: key);

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late VideoPlayerController _videoController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    _videoController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        _chewieController = ChewieController(
          videoPlayerController: _videoController,
          aspectRatio: _videoController.value.aspectRatio,
          autoPlay: true,
          looping: true,
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
            child: const Center(child: CircularProgressIndicator()),
          ),
        );
        setState(() {}); // Refresh the UI once the player is initialized
      });
  }

  @override
  void didUpdateWidget(covariant MyVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _videoController.dispose();
      _chewieController.dispose();
      _initializePlayer();
      widget.onVideoChanged(widget.videoUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_videoController.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () {
            Navigator.of(context).pop();
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
          }),
        ),
        body: Center(
          child: Chewie(
            controller: _chewieController,
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
