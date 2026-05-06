import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'imgly_camera_platform_interface.dart';
import 'model/camera_settings.dart';

/// An implementation of [IMGLYCameraPlatform] that uses method channels.
class MethodChannelIMGLYCamera extends IMGLYCameraPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('imgly_camera');

  @override
  Future<CameraResult?> openCamera(
    CameraSettings settings, {
    String? video,
    Map<String, dynamic>? metadata,
  }) async {
    final result = await methodChannel.invokeMethod(
      'openCamera',
      {
        'settings': settings.toJson(),
        if (video != null) 'video': video,
        'metadata': metadata,
      },
    );
    return result == null
        ? null
        : CameraResult.fromJson(Map<String, dynamic>.from(result));
  }
}
