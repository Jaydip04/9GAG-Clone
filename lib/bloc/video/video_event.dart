import 'package:equatable/equatable.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object?> get props => [];
}

class PlayVideo extends VideoEvent {
  final String url;

  const PlayVideo(this.url);

  @override
  List<Object?> get props => [url];
}

class PauseVideo extends VideoEvent {}

// import 'package:equatable/equatable.dart';
//
// abstract class VideoEvent extends Equatable {
//   const VideoEvent();
//
//   @override
//   List<Object> get props => [];
// }
//
// class PlayVideo extends VideoEvent {
//   final String url;
//
//   const PlayVideo(this.url);
//
//   @override
//   List<Object> get props => [url];
// }
//
// class PauseVideo extends VideoEvent {}
//
// class StopVideo extends VideoEvent {}