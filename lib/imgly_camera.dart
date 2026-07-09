import 'imgly_camera_platform_interface.dart';
import 'model/camera_settings.dart';

export 'model/camera_capture.dart';
export 'model/camera_configuration.dart';
export 'model/camera_result.dart';
export 'model/camera_settings.dart';
export 'model/capture.dart';
export 'model/capture_count.dart';
export 'model/capture_type.dart';
export 'model/photo.dart';
export 'model/recording.dart';
export 'model/rect.dart';
export 'model/video.dart';

/// The entry point for the IMGLY Camera plugin.
class IMGLYCamera {
  /// Opens the camera for recording or reaction mode.
  ///
  /// [settings] - Configuration settings for the camera.
  /// [video] - Optional video input to trigger reactions (iOS only).
  /// [metadata] - Optional metadata to pass to the native module.
  static Future<CameraResult?> openCamera(
    CameraSettings settings, {
    String? video,
    Map<String, dynamic>? metadata,
  }) {
    return IMGLYCameraPlatform.instance.openCamera(
      settings,
      video: video,
      metadata: metadata,
    );
  }
}
