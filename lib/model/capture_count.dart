/// How many captures the camera session produces.
enum CaptureCount {
  /// Produces a single capture and dismisses.
  single,

  /// Stacks multiple captures into the progress ring.
  multi;

  /// Converts this instance to a JSON-serializable value.
  String toJson() => name;

  /// Creates a new instance from a JSON value.
  static CaptureCount fromJson(String value) =>
      CaptureCount.values.firstWhere((e) => e.name == value);
}
