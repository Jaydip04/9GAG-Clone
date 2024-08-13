import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gagclone/common/post_page.dart';
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

}
