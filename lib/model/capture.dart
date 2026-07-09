import 'photo.dart';
import 'recording.dart';

/// A single capture from the camera. Either a still [Photo] or a video [Recording].
class Capture {
  /// Creates a new instance of [Capture].
  const Capture({
    this.photo,
    this.video,
  });

  /// The captured still photo, when this is a photo capture.
  final Photo? photo;

  /// The video recording, when this is a video capture.
  final Recording? video;

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      if (photo != null) 'photo': photo!.toJson(),
      if (video != null) 'video': video!.toJson(),
    };
  }

  /// Creates a new instance from a JSON map.
  factory Capture.fromJson(Map<String, dynamic> json) {
    return Capture(
      photo: json['photo'] == null
          ? null
          : Photo.fromJson(Map<String, dynamic>.from(json['photo'])),
      video: json['video'] == null
          ? null
          : Recording.fromJson(Map<String, dynamic>.from(json['video'])),
    );
  }
}
