import 'capture_count.dart';
import 'capture_type.dart';

/// Configuration options that control how the camera captures media.
class CameraConfiguration {
  /// Creates a new instance of [CameraConfiguration].
  const CameraConfiguration({
    this.captureType = CaptureType.video,
    this.captureCount = CaptureCount.multi,
    this.photoClipDuration = 5.0,
  });

  /// The kind of media the camera captures.
  final CaptureType captureType;

  /// How many captures the camera session produces.
  final CaptureCount captureCount;

  /// The duration in seconds stamped on each captured photo.
  final double photoClipDuration;

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'captureType': captureType.toJson(),
      'captureCount': captureCount.toJson(),
      'photoClipDuration': photoClipDuration,
    };
  }

  /// Creates a new instance from a JSON map.
  factory CameraConfiguration.fromJson(Map<String, dynamic> json) {
    return CameraConfiguration(
      captureType: json['captureType'] == null
          ? CaptureType.video
          : CaptureType.fromJson(json['captureType']),
      captureCount: json['captureCount'] == null
          ? CaptureCount.multi
          : CaptureCount.fromJson(json['captureCount']),
      photoClipDuration: (json['photoClipDuration'] as num?)?.toDouble() ?? 5.0,
    );
  }
}
