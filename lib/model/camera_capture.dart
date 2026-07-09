import 'capture.dart';

/// The result for a camera capture session producing photos, videos, or both.
class CameraCapture {
  /// Creates a new instance of [CameraCapture].
  const CameraCapture({
    required this.captures,
  });

  /// The individual captures from the session.
  final List<Capture> captures;

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'captures': captures.map((c) => c.toJson()).toList(),
    };
  }

  /// Creates a new instance from a JSON map.
  factory CameraCapture.fromJson(Map<String, dynamic> json) {
    return CameraCapture(
      captures: (List<dynamic>.from(json['captures']))
          .map(
              (capture) => Capture.fromJson(Map<String, dynamic>.from(capture)))
          .toList(),
    );
  }
}
