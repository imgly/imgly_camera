import 'camera_capture.dart';
import 'recording.dart';

/// The result of a camera session.
class CameraResult {
  /// Creates a new instance of [CameraResult].
  const CameraResult({
    this.reaction,
    this.capture,
    required this.metadata,
  });

  /// The reaction result for a reaction camera session.
  final CameraReaction? reaction;

  /// The capture result for a photo, video, or mixed camera session.
  final CameraCapture? capture;

  /// The associated metadata.
  final Map<String, dynamic> metadata;

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'reaction': reaction?.toJson(),
      'capture': capture?.toJson(),
      'metadata': metadata,
    };
  }

  /// Creates a new instance from a JSON map.
  factory CameraResult.fromJson(Map<String, dynamic> json) {
    return CameraResult(
      reaction: json['reaction'] == null
          ? null
          : CameraReaction.fromJson(
              Map<String, dynamic>.from(json['reaction'])),
      capture: json['capture'] == null
          ? null
          : CameraCapture.fromJson(Map<String, dynamic>.from(json['capture'])),
      metadata: json["metadata"] == null
          ? {}
          : Map<String, dynamic>.from(json['metadata']),
    );
  }
}

/// The result for a reaction camera recording session.
class CameraReaction {
  /// Creates a new instance of [CameraReaction].
  const CameraReaction({
    required this.video,
    required this.recordings,
  });

  /// The video that was reacted to (iOS only).
  final Recording video;

  /// The recorded videos.
  final List<Recording> recordings;

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'video': video.toJson(),
      'recordings': recordings.map((r) => r.toJson()).toList(),
    };
  }

  /// Creates a new instance from a JSON map.
  factory CameraReaction.fromJson(Map<String, dynamic> json) {
    return CameraReaction(
      video: Recording.fromJson(Map<String, dynamic>.from(json['video'])),
      recordings: (List<dynamic>.from(json['recordings']))
          .map((r) => Recording.fromJson(Map<String, dynamic>.from(r)))
          .toList(),
    );
  }
}
