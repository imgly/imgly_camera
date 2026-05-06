import 'rect.dart';

/// An individual video.
class Video {
  /// Creates a new instance of [Video].
  const Video({
    required this.uri,
    required this.rect,
  });

  /// A url to the video file that is stored in a temporary location.
  final String uri;

  /// A rect that contains the position of each video as it was shown in the
  /// camera preview.
  final Rect rect;

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'uri': uri,
      'rect': rect.toJson(),
    };
  }

  /// Creates a new instance from a JSON map.
  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      uri: json['uri'],
      rect: Rect.fromJson(Map<String, dynamic>.from(json['rect'])),
    );
  }
}
