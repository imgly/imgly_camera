import 'recording.dart';

/// The result of a camera session.
class CameraResult {
  /// Creates a new instance of [CameraResult].
  const CameraResult({
    this.recording,
    this.reaction,
    required this.metadata,
  });

  /// The recording result for a default camera session.
  final CameraRecording? recording;

  /// The reaction result for a reaction camera session.
  final CameraReaction? reaction;

  /// The associated metadata.
  final Map<String, dynamic> metadata;

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'recording': recording?.toJson(),
      'reaction': reaction?.toJson(),
      'metadata': metadata,
    };
  }

  /// Creates a new instance from a JSON map.
  factory CameraResult.fromJson(Map<String, dynamic> json) {
    return CameraResult(
      recording: json['recording'] == null
          ? null
          : CameraRecording.fromJson(
              Map<String, dynamic>.from(json['recording'])),
      reaction: json['reaction'] == null
          ? null
          : CameraReaction.fromJson(
              Map<String, dynamic>.from(json['reaction'])),
      metadata: json["metadata"] == null
          ? {}
          : Map<String, dynamic>.from(json['metadata']),
    );
  }
}

/// The result for a default camera recording session.
class CameraRecording {
  /// Creates a new instance of [CameraRecording].
  const CameraRecording({
    required this.recordings,
  });

  /// The recorded videos.
  final List<Recording> recordings;

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'recordings': recordings.map((r) => r.toJson()).toList(),
    };
  }

  /// Creates a new instance from a JSON map.
  factory CameraRecording.fromJson(Map<String, dynamic> json) {
    return CameraRecording(
      recordings: (List<dynamic>.from(json['recordings']))
          .map((recording) =>
              Recording.fromJson(Map<String, dynamic>.from(recording)))
          .toList(),
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
