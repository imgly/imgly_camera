/// A class containing all necessary settings to setup the camera.
class CameraSettings {
  /// Creates a new instance of [CameraSettings].
  const CameraSettings({
    this.license,
    this.userId,
  });

  /// The license of the editor. Pass `null` to run the SDK in evaluation mode with a watermark.
  final String? license;

  /// Unique ID tied to your application's user.
  /// This helps us accurately calculate monthly active users (MAU).
  final String? userId;

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'license': license,
      'userId': userId,
    };
  }

  /// Creates a new instance from a JSON map.
  factory CameraSettings.fromJson(Map<String, dynamic> json) {
    return CameraSettings(
      license: json['license'],
      userId: json['userId'],
    );
  }
}
