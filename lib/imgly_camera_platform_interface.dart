import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'imgly_camera_method_channel.dart';
import 'model/camera_result.dart';
import 'model/camera_settings.dart';

export 'model/camera_result.dart';

/// The interface that implementations of imgly_camera must implement.
abstract class IMGLYCameraPlatform extends PlatformInterface {
  /// Constructs a IMGLYCameraPlatform.
  IMGLYCameraPlatform() : super(token: _token);

  static final Object _token = Object();

  static IMGLYCameraPlatform _instance = MethodChannelIMGLYCamera();

  /// The default instance of [IMGLYCameraPlatform] to use.
  static IMGLYCameraPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IMGLYCameraPlatform] when
  /// they register themselves.
  static set instance(IMGLYCameraPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Opens the camera for recording or reaction mode.
  ///
  /// [settings] - Configuration settings for the camera.
  /// [video] - Optional video input to trigger reactions (iOS only).
  /// [metadata] - Optional metadata to pass to the native module.
  Future<CameraResult?> openCamera(
    CameraSettings settings, {
    String? video,
    Map<String, dynamic>? metadata,
  }) {
    throw UnimplementedError('openCamera() has not been implemented.');
  }
}
