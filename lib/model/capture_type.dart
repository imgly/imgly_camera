/// The kind of media the camera captures.
enum CaptureType {
  /// Captures still photos only.
  photo,

  /// Records videos only.
  video,

  /// Switches between photo and video via an in-camera toggle.
  mixed;

  /// Converts this instance to a JSON-serializable value.
  String toJson() => name;

  /// Creates a new instance from a JSON value.
  static CaptureType fromJson(String value) =>
      CaptureType.values.firstWhere((e) => e.name == value);
}
