import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../common/post_page.dart';

class TopTab extends StatefulWidget {
  const TopTab({super.key});

  @override
  State<TopTab> createState() => _TopTabState();
}

class _TopTabState extends State<TopTab> {
  final String videoUrl =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  late FlickManager flickManager;
  late FlickManager flickManager2;
  late FlickManager flickManager3;
  late FlickManager flickManager4;
  late FlickManager flickManager5;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
        videoPlayerController:
        VideoPlayerController.networkUrl(Uri.parse(videoUrl)));
    flickManager2 = FlickManager(
        videoPlayerController:
        VideoPlayerController.networkUrl(Uri.parse(videoUrl)));
    flickManager3 = FlickManager(
        videoPlayerController:
        VideoPlayerController.networkUrl(Uri.parse(videoUrl)));
    flickManager4 = FlickManager(
        videoPlayerController:
        VideoPlayerController.networkUrl(Uri.parse(videoUrl)));
    flickManager5 = FlickManager(
        videoPlayerController:
        VideoPlayerController.networkUrl(Uri.parse(videoUrl)));
  }

  @override
  void dispose() {
    super.dispose();
    flickManager.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async{
          flickManager = FlickManager(
              videoPlayerController:
              VideoPlayerController.networkUrl(Uri.parse(videoUrl)));
          flickManager2 = FlickManager(
              videoPlayerController:
              VideoPlayerController.networkUrl(Uri.parse(videoUrl)));
          flickManager3 = FlickManager(
              videoPlayerController:
              VideoPlayerController.networkUrl(Uri.parse(videoUrl)));
          flickManager4 = FlickManager(
              videoPlayerController:
              VideoPlayerController.networkUrl(Uri.parse(videoUrl)));
          flickManager5 = FlickManager(
              videoPlayerController:
              VideoPlayerController.networkUrl(Uri.parse(videoUrl)));
        },
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 5.0,),
                PostPage(flickManager: flickManager,),
                PostPage(flickManager: flickManager2,),
                PostPage(flickManager: flickManager3,),
                PostPage(flickManager: flickManager4,),
                PostPage(flickManager: flickManager5,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
