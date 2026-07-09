import 'package:flutter_test/flutter_test.dart';
import 'package:imgly_camera/imgly_camera.dart';
import 'package:imgly_camera/imgly_camera_method_channel.dart';
import 'package:imgly_camera/imgly_camera_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIMGLYCameraPlatform
    with MockPlatformInterfaceMixin
    implements IMGLYCameraPlatform {
  @override
  Future<CameraResult?> openCamera(CameraSettings settings,
      {String? video, Map<String, dynamic>? metadata}) async {
    return const CameraResult(
        capture: CameraCapture(captures: [
          Capture(
            video: Recording(videos: [
              Video(
                  uri: "MY_VIDEO_URI",
                  rect: Rect(x: 0, y: 0, width: 100, height: 100))
            ], duration: 1000000.0),
          ),
        ]),
        metadata: {});
  }
}

void main() {
  final IMGLYCameraPlatform initialPlatform = IMGLYCameraPlatform.instance;

  test('$MethodChannelIMGLYCamera is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIMGLYCamera>());
  });

  test('openEditor', () async {
    MockIMGLYCameraPlatform fakePlatform = MockIMGLYCameraPlatform();
    IMGLYCameraPlatform.instance = fakePlatform;

    const settings = CameraSettings(license: "NO_LICENSE");
    final result = await IMGLYCamera.openCamera(settings);

    expect(result, isNotNull);
    expect(result?.capture?.captures.length, 1);
    expect(result?.capture?.captures.first.video?.videos.first.uri,
        "MY_VIDEO_URI");
    expect(result?.reaction, null);
    expect(result?.metadata, {});
  });

  group("EditorResult Parsing", () {
    test('EditorResult Parsing - Null', () {
      const resultMock = {
        "scene": null,
        "artifact": null,
        "thumbnail": null,
        "metadata": null
      };

      final result = CameraResult.fromJson(resultMock);
      expect(result, isNotNull);
      expect(result.capture, null);
      expect(result.reaction, null);
      expect(result.metadata, {});
    });

    test('EditorResult Parsing - Empty', () {
      const Map<String, dynamic> resultMock = {};

      final result = CameraResult.fromJson(resultMock);
      expect(result, isNotNull);
      expect(result.capture, null);
      expect(result.reaction, null);
      expect(result.metadata, {});
    });
  });

  group("Photo JSON", () {
    test('Photo.toJson / fromJson round-trip - single image (standard mode)', () {
      const photo = Photo(
        images: [
          PhotoImage(
            uri: "MY_PHOTO_URI",
            rect: Rect(x: 0, y: 0, width: 1080, height: 1920),
          ),
        ],
        duration: 5000.0,
      );

      final parsed = Photo.fromJson(photo.toJson());
      expect(parsed.duration, photo.duration);
      expect(parsed.images.length, 1);
      expect(parsed.images.first.uri, photo.images.first.uri);
      expect(parsed.images.first.rect.x, photo.images.first.rect.x);
      expect(parsed.images.first.rect.y, photo.images.first.rect.y);
      expect(parsed.images.first.rect.width, photo.images.first.rect.width);
      expect(parsed.images.first.rect.height, photo.images.first.rect.height);
    });

    test('Photo.toJson / fromJson round-trip - two images (dual-camera vertical)', () {
      const photo = Photo(
        images: [
          PhotoImage(
            uri: "BACK_CAMERA_URI",
            rect: Rect(x: 0, y: 0, width: 1080, height: 960),
          ),
          PhotoImage(
            uri: "FRONT_CAMERA_URI",
            rect: Rect(x: 0, y: 960, width: 1080, height: 960),
          ),
        ],
        duration: 5000.0,
      );

      final parsed = Photo.fromJson(photo.toJson());
      expect(parsed.duration, 5000.0);
      expect(parsed.images.length, 2);
      expect(parsed.images[0].uri, "BACK_CAMERA_URI");
      expect(parsed.images[1].uri, "FRONT_CAMERA_URI");
      expect(parsed.images[1].rect.y, 960);
    });

    test('CameraResult capture parsing — mixed photos + video', () {
      const resultMock = {
        "capture": {
          "captures": [
            {
              "photo": {
                "images": [
                  {
                    "uri": "PHOTO_URI",
                    "rect": {"x": 0.0, "y": 0.0, "width": 1080.0, "height": 1920.0}
                  }
                ],
                "duration": 5000.0,
              },
            },
            {
              "video": {
                "videos": [
                  {
                    "uri": "VIDEO_URI",
                    "rect": {"x": 0.0, "y": 0.0, "width": 1080.0, "height": 1920.0}
                  }
                ],
                "duration": 3000.0,
              },
            },
          ]
        },
        "metadata": {}
      };

      final result = CameraResult.fromJson(resultMock);
      expect(result.capture, isNotNull);
      expect(result.capture!.captures.length, 2);
      expect(result.capture!.captures[0].photo?.images.first.uri, "PHOTO_URI");
      expect(result.capture!.captures[0].video, null);
      expect(result.capture!.captures[1].video?.videos.first.uri, "VIDEO_URI");
      expect(result.capture!.captures[1].photo, null);
    });
  });

  group("CameraConfiguration JSON", () {
    test('toJson / fromJson round-trip with custom values', () {
      const config = CameraConfiguration(
        captureType: CaptureType.mixed,
        captureCount: CaptureCount.single,
        photoClipDuration: 3.5,
      );

      final parsed = CameraConfiguration.fromJson(config.toJson());
      expect(parsed.captureType, CaptureType.mixed);
      expect(parsed.captureCount, CaptureCount.single);
      expect(parsed.photoClipDuration, 3.5);
    });

    test('fromJson falls back to defaults for missing keys', () {
      final parsed = CameraConfiguration.fromJson({});
      expect(parsed.captureType, CaptureType.video);
      expect(parsed.captureCount, CaptureCount.multi);
      expect(parsed.photoClipDuration, 5.0);
    });

    test('CameraSettings.configuration survives the toJson round-trip', () {
      const settings = CameraSettings(
        license: "NO_LICENSE",
        configuration: CameraConfiguration(
          captureType: CaptureType.photo,
          captureCount: CaptureCount.single,
          photoClipDuration: 2.0,
        ),
      );

      final json = settings.toJson();
      final config = (json['configuration'] as Map?)?.cast<String, dynamic>();
      expect(config, isNotNull);
      expect(config!['captureType'], 'photo');
      expect(config['captureCount'], 'single');
      expect(config['photoClipDuration'], 2.0);
    });
  });
}
