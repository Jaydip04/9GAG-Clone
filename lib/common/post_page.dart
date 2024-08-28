import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:gagclone/models/post_model.dart';
import 'package:video_player/video_player.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  final List<PostModel> list = [
    PostModel(
      postHeading: "Humor",
      postBottomScrollView: ["girl","funny","random","humor","no sound"],
      postSubHeading: "Oh yes...let's the kid having fun...",
      postVideoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      postLikeCount: "10K",
      postCommentCount: "256",
      postHoursCount: "10",
    ),
    PostModel(
      postHeading: "Humor",
      postBottomScrollView: ["girl","humor","no sound"],
      postSubHeading: "Oh yes...let's the kid having fun...",
      postVideoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
      postLikeCount: "1.2M",
      postCommentCount: "700",
      postHoursCount: "10",
    ),
    PostModel(
      postHeading: "Humor",
      postBottomScrollView: ["girl","funny","random"],
      postSubHeading: "Oh yes...let's the kid having fun...",
      postVideoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      postLikeCount: "4K",
      postCommentCount: "1K",
      postHoursCount: "10",
    ),
    PostModel(
      postHeading: "Humor",
      postBottomScrollView: ["funny",],
      postSubHeading: "Oh yes...let's the kid having fun...",
      postVideoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
      postLikeCount: "5.2",
      postCommentCount: "5K",
      postHoursCount: "10",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      height: MediaQuery.sizeOf(context).height/1.3,
      child: ListView.builder(
        // shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return postCard(
              heading: list[index].postHeading,
              subHeading: list[index].postSubHeading,
              bottomScroll: list[index].postBottomScrollView,
              videoURL: list[index].postVideoUrl,
              likeCount: list[index].postLikeCount,
              commentCount: list[index].postCommentCount,
              postHours: list[index].postHoursCount,
            );
          },
      ),
    );
  }

  Widget postCard({
    required heading,
    required subHeading,
    required videoURL,
    required likeCount,
    required bottomScroll,
    required commentCount,
    required postHours,
  }) {
    return Container(
        child: Column(
          children: [
            postTitle(heading: heading, subHeading: subHeading, hours: postHours),
            SizedBox(
              height: 5,
            ),
            // PostVideo(videoURL: videoURL,),
            postBottomScrollView(list: bottomScroll,listItem: bottomScroll,),
            postBottom(likeCount: likeCount, commentCount: commentCount),
            SizedBox(
              height: 5.0,
            ),
            Divider(
              thickness: 7.0,
              color: Colors.grey.withOpacity(0.2),
            ),
          ],
        ),
    );
  }

  TextStyle commonTextStyle(color, weight, size) {
    return TextStyle(color: color, fontWeight: weight, fontSize: size);
  }

  Widget commonContainerBorder(name) {
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

  Widget postTitle(
      {required String heading,
      required String subHeading,
      required String hours}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        heading,
                        style: commonTextStyle(
                            Colors.black, FontWeight.bold, 14.00),
                      ),
                      Text(
                        " . $hours" + "h",
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
          Text(
            subHeading,
            style: commonTextStyle(Colors.black, FontWeight.bold, 14.00),
          ),
        ],
      ),
    );
  }

  Widget postBottom({required String likeCount, required String commentCount}) {
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
                  Text(likeCount),
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
                  Text(commentCount),
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
}
class PostVideo extends StatefulWidget {
  final String videoURL;
  const PostVideo({super.key,required this.videoURL});

  @override
  _PostVideoState createState() => _PostVideoState();
}

class _PostVideoState extends State<PostVideo> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(widget.videoURL);

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      // autoPlay: true,
      looping: true,
      allowMuting: true,
      showControls: true,
      autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        width: MediaQuery.sizeOf(context).width,
        child: Center(
          child: Chewie(
            controller: _chewieController,
          ),
        ),
      );
  }
}

class postBottomScrollView extends StatefulWidget {
  final List<String> list;
  final List<String> listItem;
  const postBottomScrollView({super.key,required this.list,required this.listItem});

  @override
  State<postBottomScrollView> createState() => _postBottomScrollViewState();
}

class _postBottomScrollViewState extends State<postBottomScrollView> {
  @override
  Widget build(BuildContext context) {
    return Container(
            height: 35.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2.0),
                  child: Container(
                    child: Text(widget.listItem[index], style: commonTextStyle(Colors.black, FontWeight.bold, 14.00),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey, width: 1)),
                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  ),
                );
              },
            ),
          );
  }
  TextStyle commonTextStyle(color, weight, size) {
    return TextStyle(
        color: color,
        fontWeight: weight,
        fontSize: size,);
  }
}



