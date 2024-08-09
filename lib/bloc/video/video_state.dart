import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object?> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoPlaying extends VideoState {
  final VideoPlayerController controller;

  const VideoPlaying(this.controller);

  @override
  List<Object?> get props => [controller];
}

class VideoPaused extends VideoState {
  final VideoPlayerController controller;

  const VideoPaused(this.controller);

  @override
  List<Object?> get props => [controller];
}

// import 'package:equatable/equatable.dart';
// import 'package:video_player/video_player.dart';
//
// abstract class VideoState extends Equatable {
//   const VideoState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class VideoInitial extends VideoState {}
//
// class VideoLoading extends VideoState {}
//
// class VideoPlaying extends VideoState {
//   final VideoPlayerController controller;
//
//   const VideoPlaying(this.controller);
//
//   @override
//   List<Object> get props => [controller];
// }
//
// class VideoPaused extends VideoState {
//   final VideoPlayerController controller;
//
//   const VideoPaused(this.controller);
//
//   @override
//   List<Object> get props => [controller];
// }
//
// class VideoStopped extends VideoState {}