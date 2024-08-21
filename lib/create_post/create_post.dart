import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gagclone/create_post/choose_interest.dart';
import 'package:gagclone/create_post/tags.dart';
import 'package:gagclone/pages/home_page.dart';
import 'package:video_player/video_player.dart';

import '../models/post_model.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _controller = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isButtonEnabled = _controller.text.isNotEmpty;
      });
    });
  }

  PostModel post1 = PostModel(postHeading: "Humor1", postBottomScrollView: ["girl","funny","random","humor","no sound"], postSubHeading: "Oh yes...let's the kid having fun...", postVideoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4", postLikeCount: "10K", postCommentCount: "256", postHoursCount: "10");
  PostModel post2 = PostModel(postHeading: "Humor2", postBottomScrollView: ["girl","funny","random","humor","no sound"], postSubHeading: "Oh yes...let's the kid having fun...", postVideoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4", postLikeCount: "10K", postCommentCount: "256", postHoursCount: "10");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.xmark,
            color: Colors.grey,
            size: 22,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    backgroundColor: Colors.white,
                    content: Container(
                      height: 111.0,
                      width: MediaQuery.sizeOf(context).width / 1.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Are you sure?",
                                style: commonTextStyle(
                                    Colors.black, FontWeight.bold, 16.00, null),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            children: [
                              Text(
                                "Your post won't be saved",
                                style: commonTextStyle(
                                    Colors.black, FontWeight.w500, 14.00, null),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: commonTextStyle(Colors.indigo,
                                        FontWeight.bold, 14.00, null),
                                  )),
                              SizedBox(
                                width: 20.0,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(_HomeRoute());
                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => HomePage()));
                                  },
                                  child: Text(
                                    "Discard",
                                    style: commonTextStyle(Colors.indigo,
                                        FontWeight.bold, 14.00, null),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
        title: Text(
          "Create Post",
          style: commonTextStyle(Colors.black, FontWeight.bold, 18.00, null),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              PostList postList = PostList(posts: []);
              // print(postList.category);
              // for (var post in postList.posts) {
              //   print('${post.postHeading}: ${post.postSubHeading}');
              // }

              PostModel post3 = PostModel(postHeading: "Humor3", postBottomScrollView: ["girl","funny","random","humor","no sound"], postSubHeading: "Oh yes...let's the kid having fun...", postVideoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4", postLikeCount: "10K", postCommentCount: "256", postHoursCount: "10");

              postList.addPost(post3);
              postList.addPost(post1);
              for (var post in postList.posts) {
                print('[ ${post.postHeading}: ${post.postSubHeading} ]');
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  "Post",
                  style: commonTextStyle(
                      _controller.text.isEmpty ? Colors.white : Colors.grey,
                      FontWeight.bold,
                      14.00,
                      null),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.indigo,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          color: Colors.white,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(_ChooseInterestRoute());
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => ChooseInterest()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.2), width: 1.0),
                    ),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Choose an interest",
                        style: commonTextStyle(
                            Colors.black, FontWeight.bold, 14.00, null),
                      ),
                      Icon(
                        CupertinoIcons.chevron_right,
                        color: Colors.grey,
                        size: 18.0,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.2), width: 1.0),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 4,
                  maxLines: 8,
                  maxLength: 280,
                  showCursor: true,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(280), // Max 280 characters
                  ],
                  style: commonTextStyle(Colors.black, FontWeight.bold, 18.00,
                      TextDecoration.underline),
                  cursorColor: Colors.indigo,
                  controller: _controller,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(_TagsRoute());
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => Tags()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.2), width: 1.0),
                    ),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Tags",
                                style: commonTextStyle(
                                    Colors.black, FontWeight.bold, 14.00, null),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                "Add at least 1 tag",
                                style: commonTextStyle(
                                    Colors.grey, FontWeight.bold, 14.00, null),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        CupertinoIcons.chevron_right,
                        color: Colors.grey,
                        size: 18.0,
                      )
                    ],
                  ),
                ),
              ),
              PostVideo(
                videoURL:
                    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
              )
            ],
          ),
        ),
      ),
    );
  }

  Route _HomeRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 1000));
  }

  Route _ChooseInterestRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ChooseInterest(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 1000));
  }

  Route _TagsRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const Tags(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 1000));
  }

  TextStyle commonTextStyle(color, weight, size, decoration) {
    return TextStyle(
        color: color,
        fontWeight: weight,
        fontSize: size,
        decoration: decoration);
  }
}

class PostVideo extends StatefulWidget {
  final String videoURL;
  const PostVideo({super.key, required this.videoURL});

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
