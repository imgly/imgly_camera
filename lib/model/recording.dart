import 'video.dart';

/// A recording of the camera that can contain multiple videos.
class Recording {
  /// Creates a new instance of [Recording].
  const Recording({
    required this.videos,
    required this.duration,
  });

  /// The individual videos of the recording.
  final List<Video> videos;

  /// The overall duration in milliseconds.
  final double duration;

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'videos': videos.map((v) => v.toJson()).toList(),
      'duration': duration,
    };
  }

  /// Creates a new instance from a JSON map.
  factory Recording.fromJson(Map<String, dynamic> json) {
    return Recording(
      videos: (List<dynamic>.from(json['videos']))
          .map((video) => Video.fromJson(Map<String, dynamic>.from(video)))
          .toList(),
      duration: json['duration'],
    );
  }
}
