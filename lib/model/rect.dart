/// A rect used to determine video dimensions on the canvas.
class Rect {
  /// Creates a new instance of [Rect].
  const Rect({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  /// The x coordinate of the top-left corner.
  final double x;

  /// The y coordinate of the top-left corner.
  final double y;

  /// The width.
  final double width;

  /// The height.
  final double height;

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
      'width': width,
      'height': height,
    };
  }

  /// Creates a new instance from a JSON map.
  factory Rect.fromJson(Map<String, dynamic> json) {
    return Rect(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
    );
  }
}
