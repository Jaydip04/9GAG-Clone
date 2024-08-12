import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gagclone/bloc/video/video_bloc.dart';
import 'package:gagclone/bloc/video/video_event.dart';
import 'package:gagclone/bloc/video/video_state.dart';
import 'package:video_player/video_player.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final String videoUrl =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      commonContainerBG("olympics"),
                      SizedBox(
                        width: 10,
                      ),
                      commonContainerBG("deadpool"),
                      SizedBox(
                        width: 10,
                      ),
                      commonContainerBG("wolverine"),
                      SizedBox(
                        width: 10,
                      ),
                      commonContainerBG("trump"),
                      SizedBox(
                        width: 10,
                      ),
                      commonContainerBG("biden"),
                      SizedBox(
                        width: 10,
                      ),
                      commonContainerBG("stellar blade"),
                      SizedBox(
                        width: 10,
                      ),
                      commonContainerBG("latest news"),
                      SizedBox(
                        width: 10,
                      ),
                      commonContainerBG("most commented"),
                      SizedBox(
                        width: 10,
                      ),
                      commonContainerBG("weekly highlights"),
                    ],
                  ),
                ),
              ),
              postTitle(),
              SizedBox(height: 5,),
              postVideo(),
              postSingleChildScrollView(),
              postBottom(),
              SizedBox(height: 5.0,),
              Divider(
                thickness: 7.0,
                color: Colors.grey.withOpacity(0.2),
              ),

              postTitle(),
              SizedBox(height: 5,),
              postVideo(),
              postSingleChildScrollView(),
              postBottom(),
              SizedBox(height: 5.0,),
              Divider(
                thickness: 7.0,
                color: Colors.grey.withOpacity(0.2),
              ),

              postTitle(),
              SizedBox(height: 5,),
              postVideo(),
              postSingleChildScrollView(),
              postBottom(),
              SizedBox(height: 5.0,),
              Divider(
                thickness: 7.0,
                color: Colors.grey.withOpacity(0.2),
              ),

              postTitle(),
              SizedBox(height: 5,),
              postVideo(),
              postSingleChildScrollView(),
              postBottom(),
              SizedBox(height: 5.0,),
              Divider(
                thickness: 7.0,
                color: Colors.grey.withOpacity(0.2),
              ),

              postTitle(),
              SizedBox(height: 5,),
              postVideo(),
              postSingleChildScrollView(),
              postBottom(),
              SizedBox(height: 5.0,),
              Divider(
                thickness: 7.0,
                color: Colors.grey.withOpacity(0.2),
              ),

              postTitle(),
              SizedBox(height: 5,),
              postVideo(),
              postSingleChildScrollView(),
              postBottom(),
              SizedBox(height: 5.0,),
              Divider(
                thickness: 7.0,
                color: Colors.grey.withOpacity(0.2),
              ),

            ],
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
                        style:
                            commonTextStyle(Colors.black, FontWeight.bold, 14.00),
                      ),
                      Text(
                        " . 10h",
                        style:
                            commonTextStyle(Colors.grey, FontWeight.bold, 12.00),
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

  Row postVideo() {
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
          // BlocBuilder<VideoBloc, VideoState>(
          //   builder: (context, state) {
          //     return Column(
          //       children: [
          //         // Play and Pause Buttons
          //         Padding(
          //           padding: const EdgeInsets.all(16.0),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               if (state is VideoPlaying)
          //                 Positioned(
          //                   child: ElevatedButton(
          //                     onPressed: () {
          //                       context.read<VideoBloc>().add(PauseVideo());
          //                     },
          //                     child: const Text('Pause'),
          //                   ),
          //                 ),
          //               if (state is! VideoPlaying)
          //                 ElevatedButton(
          //                   onPressed: () {
          //                     context.read<VideoBloc>().add(PlayVideo(videoUrl));
          //                   },
          //                   child: const Text('Play'),
          //                 ),
          //             ],
          //           ),
          //         ),
          //         // Video Player
          //
          //         if (state is VideoLoading)
          //           const Center(child: CircularProgressIndicator())
          //          else if (state is VideoPlaying)
          //           Column(
          //             children: [
          //               AspectRatio(
          //                 aspectRatio: state.controller.value.aspectRatio,
          //                 child: VideoPlayer(state.controller),
          //               ),]
          //         // if (state is VideoLoading)
          //         //   const Center(child: CircularProgressIndicator()),
          //         // if (state is VideoPlaying || state is VideoPaused)
          //         //   AspectRatio(
          //         //     aspectRatio: ,
          //         //     child: VideoPlayer(state.controller),
          //           ),
          //       ],
          //     );
          //   },
          // ),

          // BlocBuilder<VideoBloc, VideoState>(
          //                       builder: (context, state) {
          // if (state is VideoLoading) {
          //   return const Center(child: CircularProgressIndicator());
          // } else if (state is VideoPlaying) {
          //   return Column(
          //     children: [
          //       AspectRatio(
          //         aspectRatio: state.controller.value.aspectRatio,
          //         child: VideoPlayer(state.controller),
          //       ),
          //       const SizedBox(height: 10),
          //       Positioned(
          //         top:
          //         20, // Adjust the position to your needs
          //         child: Row(
          //           mainAxisAlignment:
          //           MainAxisAlignment.center,
          //           children: [
          //             ElevatedButton(
          //               onPressed: () {
          //                 if (state is VideoPlaying) {
          //                   context
          //                       .read<VideoBloc>()
          //                       .add(PauseVideo());
          //                 } else if (state
          //                 is VideoPaused) {
          //                   context
          //                       .read<VideoBloc>()
          //                       .add(PlayVideo(videoUrl));
          //                 }
          //               },
          //               child: Text(state is VideoPlaying
          //                   ? 'Pause'
          //                   : 'Play'),
          //             ),
          //             const SizedBox(width: 10),
          //             ElevatedButton(
          //               onPressed: () {
          //                 context
          //                     .read<VideoBloc>()
          //                     .add(StopVideo());
          //               },
          //               child: const Text('Stop'),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   );
          // } else if (state is VideoPaused) {
          //   return Column(
          //     children: [
          //       AspectRatio(
          //         aspectRatio: state.controller.value.aspectRatio,
          //         child: VideoPlayer(state.controller),
          //       ),
          //       const SizedBox(height: 10),
          //       ElevatedButton(
          //         onPressed: () {
          //           state.controller.play();
          //           context.read<VideoBloc>().add(PlayVideo(videoUrl));
          //         },
          //         child: const Text('Resume'),
          //       ),
          //     ],
          //   );
          // } else if (state is VideoStopped) {
          //   return Center(
          //     child: ElevatedButton(
          //       onPressed: () {
          //         context.read<VideoBloc>().add(PlayVideo(videoUrl));
          //       },
          //       child: const Text('Play Video'),
          //     ),
          //   );
          // }
          //
          // return Center(
          //   child: ElevatedButton(
          //     onPressed: () {
          //       context.read<VideoBloc>().add(PlayVideo(videoUrl));
          //     },
          //     child: const Text('Play Video'),
          //   ),
          // );
          //                       },
          //                       ),
        ),
      ],
    );
  }
}
