import 'rect.dart';

/// A captured still photo. Contains one image in standard mode or two stacked images in dual camera mode.
class Photo {
  /// Creates a new instance of [Photo].
  const Photo({
    required this.images,
    required this.duration,
  });

  /// The individual image(s) of the photo capture.
  final List<PhotoImage> images;

  /// The duration stamped on the photo, in milliseconds.
  /// Note: the React Native bridge passes this value in seconds instead.
  final double duration;

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'images': images.map((image) => image.toJson()).toList(),
      'duration': duration,
    };
  }

  /// Creates a new instance from a JSON map.
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      images: (json['images'] as List)
          .map((item) =>
              PhotoImage.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList(),
      duration: (json['duration'] as num).toDouble(),
    );
  }
}

/// A single image inside a photo capture.
class PhotoImage {
  /// Creates a new instance of [PhotoImage].
  const PhotoImage({
    required this.uri,
    required this.rect,
  });

  /// A url to the photo file that is stored in a temporary location.
  final String uri;

  /// The position and size of the image inside the dual-camera layout.
  final Rect rect;

  /// Converts this instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'uri': uri,
      'rect': rect.toJson(),
    };
  }

  /// Creates a new instance from a JSON map.
  factory PhotoImage.fromJson(Map<String, dynamic> json) {
    return PhotoImage(
      uri: json['uri'] as String,
      rect: Rect.fromJson(Map<String, dynamic>.from(json['rect'] as Map)),
    );
  }
}
