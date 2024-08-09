import 'package:bloc/bloc.dart';
import 'package:gagclone/bloc/video/video_event.dart';
import 'package:gagclone/bloc/video/video_state.dart';
import 'package:video_player/video_player.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoPlayerController? _controller;

  VideoBloc() : super(VideoInitial()) {
    on<PlayVideo>((event, emit) async {
      emit(VideoLoading());

      _controller = VideoPlayerController.network(event.url);
      await _controller!.initialize();
      _controller!.play();

      emit(VideoPlaying(_controller!));
    });

    on<PauseVideo>((event, emit) {
      if (_controller != null && _controller!.value.isPlaying) {
        _controller!.pause();
        emit(VideoPaused(_controller!));
      }
    });
  }

  @override
  Future<void> close() {
    _controller?.dispose();
    return super.close();
  }
}

//
//
// import 'package:bloc/bloc.dart';
// import 'package:gagclone/bloc/video/video_event.dart';
// import 'package:gagclone/bloc/video/video_state.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoBloc extends Bloc<VideoEvent, VideoState> {
//   VideoPlayerController? _controller;
//
//   VideoBloc() : super(VideoInitial()) {
//     on<PlayVideo>((event, emit) async {
//       emit(VideoLoading());
//
//       _controller = VideoPlayerController.network(event.url);
//       await _controller!.initialize();
//       _controller!.play();
//
//       emit(VideoPlaying(_controller!));
//     });
//
//     on<PauseVideo>((event, emit) {
//       if (_controller != null) {
//         _controller!.pause();
//         emit(VideoPaused(_controller!));
//       }
//     });
//
//     on<StopVideo>((event, emit) {
//       if (_controller != null) {
//         _controller!.dispose();
//         _controller = null;
//       }
//       emit(VideoStopped());
//     });
//   }
//
//   @override
//   Future<void> close() {
//     _controller?.dispose();
//     return super.close();
//   }
// }