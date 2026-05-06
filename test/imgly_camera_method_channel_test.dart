import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imgly_camera/imgly_camera.dart';
import 'package:imgly_camera/imgly_camera_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelIMGLYCamera platform = MethodChannelIMGLYCamera();
  const MethodChannel channel = MethodChannel('imgly_camera');

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('openCamera', () async {
    final settings = CameraSettings(license: "MY_LICENSE");
    final metadata = {"custom": true};

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        expect(methodCall.method, "openCamera");
        expect(methodCall.arguments, {
          "video": "MY_VIDEO_URI",
          "settings": settings.toJson(),
          "metadata": metadata
        });
        final result = <String, dynamic>{
          "recording": <String, dynamic>{
            "recordings": [
              {
                "videos": [
                  {
                    "uri": "video1.mp4",
                    "rect": {
                      "x": 0.0,
                      "y": 0.0,
                      "width": 100.0,
                      "height": 100.0
                    }
                  }
                ],
                "duration": 1234.0
              }
            ]
          },
          "reaction": <String, dynamic>{
            "video": <String, dynamic>{
              "videos": [
                {
                  "uri": "reaction.mp4",
                  "rect": {"x": 1.0, "y": 1.0, "width": 50.0, "height": 50.0}
                }
              ],
              "duration": 5678.0
            },
            "recordings": []
          },
          "metadata": <String, dynamic>{"key": "value"}
        };
        return Map<String, dynamic>.from(result);
      },
    );

    final result = await platform.openCamera(settings,
        video: "MY_VIDEO_URI", metadata: metadata);

    expect(result, isNotNull);
    expect(result?.recording, isNotNull);
    expect(result?.reaction, isNotNull);
    expect(result?.metadata, {"key": "value"});
    expect(result!.recording!.recordings.first.videos.first.uri, "video1.mp4");
    expect(result.reaction!.video.videos[0].uri, "reaction.mp4");
  });
}
