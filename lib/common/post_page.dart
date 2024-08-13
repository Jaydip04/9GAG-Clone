import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  final FlickManager flickManager;
  const PostPage({super.key, required this.flickManager});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final List<String> scrollview = [
    "girl",
    "funny",
    "random",
    "humor",
    "no sound",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          postTitle(),
          SizedBox(
            height: 5,
          ),
          postVideo(widget.flickManager),
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
    );
  }

  TextStyle commonTextStyle(color, weight, size) {
    return TextStyle(color: color, fontWeight: weight, fontSize: size);
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
      height: 35.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: scrollview.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2.0),
            child: Container(
              child: Text(
                scrollview[index],
                style: commonTextStyle(Colors.black, FontWeight.bold, 14.00),
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
