import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

// 第三方视频播放库

class ChewieVideoDemo extends StatefulWidget {
  ChewieVideoDemo({Key key}) : super(key: key);

  @override
  _ChewieVideoDemoState createState() => _ChewieVideoDemoState();
}

class _ChewieVideoDemoState extends State<ChewieVideoDemo> {
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
  @override
  void initState() {
    super.initState();
    // 初始化第三方播放器视频
    videoPlayerController = VideoPlayerController.network(
        'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4');

    // http://vjs.zencdn.net/v/oceans.mp4
    // https://media.w3.org/2010/05/sintel/trailer.mp4

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );
  }

  // 销毁在播放的视频
  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('vide_player+chewie 视频播放'),
      ),
      body: Center(
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }
}
