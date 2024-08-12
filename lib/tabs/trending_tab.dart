import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TrendingTab extends StatefulWidget {
  const TrendingTab({super.key});

  @override
  State<TrendingTab> createState() => _TrendingTabState();
}

class _TrendingTabState extends State<TrendingTab> {
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
                postTitle(),
                SizedBox(
                  height: 5,
                ),
                postVideo(flickManager),
                postSingleChildScrollView(),
                postBottom(),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  thickness: 7.0,
                  color: Colors.grey.withOpacity(0.2),
                ),
                postTitle(),
                SizedBox(
                  height: 5,
                ),
                postVideo(flickManager2),
                postSingleChildScrollView(),
                postBottom(),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  thickness: 7.0,
                  color: Colors.grey.withOpacity(0.2),
                ),
                postTitle(),
                SizedBox(
                  height: 5,
                ),
                postVideo(flickManager3),
                postSingleChildScrollView(),
                postBottom(),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  thickness: 7.0,
                  color: Colors.grey.withOpacity(0.2),
                ),
                postTitle(),
                SizedBox(
                  height: 5,
                ),
                postVideo(flickManager4),
                postSingleChildScrollView(),
                postBottom(),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  thickness: 7.0,
                  color: Colors.grey.withOpacity(0.2),
                ),
                postTitle(),
                SizedBox(
                  height: 5,
                ),
                postVideo(flickManager5),
                postSingleChildScrollView(),
                postBottom(),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  thickness: 7.0,
                  color: Colors.grey.withOpacity(0.2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle commonTextStyle(color, weight, size) {
    return TextStyle(color: color, fontWeight: weight, fontSize: size);
  }

  Container commonContainerBG(name) {
    return Container(
      child: Text(
        name,
        style: commonTextStyle(Colors.black, FontWeight.bold, 14.00),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.withOpacity(0.15)),
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
    );
  }

  Container commonContainerBorder(name) {
    return Container(
      child: Text(
        name,
        style: commonTextStyle(Colors.black, FontWeight.bold, 14.00),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 1)),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    );
  }

  Container postTitle() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(5.00)),
                        child: Icon(
                          Icons.ac_unit_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Humor",
                        style: commonTextStyle(
                            Colors.black, FontWeight.bold, 14.00),
                      ),
                      Text(
                        " . 10h",
                        style: commonTextStyle(
                            Colors.grey, FontWeight.bold, 12.00),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.more_vert_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                "Oh yes...let' see the kid having fun...",
                style: commonTextStyle(Colors.black, FontWeight.bold, 14.00),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container postSingleChildScrollView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              commonContainerBorder("girl"),
              SizedBox(
                width: 8,
              ),
              commonContainerBorder("funny"),
              SizedBox(
                width: 8,
              ),
              commonContainerBorder("random"),
              SizedBox(
                width: 8,
              ),
              commonContainerBorder("humor"),
              SizedBox(
                width: 8,
              ),
              commonContainerBorder("no sound"),
            ],
          ),
        ),
      ),
    );
  }

  Container postBottom() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/post/arrow_upper.png",
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("1.7k"),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    "assets/post/arrow_down.png",
                    width: 20,
                    height: 20,
                  ),
                ],
              )
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/post/comment.png",
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("138"),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/post/share.png",
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Share"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row postVideo(flickManager) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 300,
          width: MediaQuery.sizeOf(context).width / 1.12,
          child: FlickVideoPlayer(
            flickManager: flickManager,
          ),
        ),
      ],
    );
  }
}
