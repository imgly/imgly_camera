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
        recording: CameraRecording(recordings: [
          Recording(videos: [
            Video(
                uri: "MY_VIDEO_URI",
                rect: Rect(x: 0, y: 0, width: 100, height: 100))
          ], duration: 1000000.0)
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
    expect(
        result?.recording,
        const CameraRecording(recordings: [
          Recording(videos: [
            Video(
                uri: "MY_VIDEO_URI",
                rect: Rect(x: 0, y: 0, width: 100, height: 100))
          ], duration: 1000000.0)
        ]));
    expect(result?.reaction, null);
    expect(result?.metadata, {});
  });

  group("EditorResult Parsing", () {
    test('EditorResult Parsing - Full', () {
      const resultMock = {
        "recording": {
          "recordings": [
            {
              "videos": [
                {
                  "uri": "MY_VIDEO_URI",
                  "rect": {"x": 0.0, "y": 0.0, "width": 100.0, "height": 100.0}
                }
              ],
              "duration": 1000000.0
            }
          ]
        },
        "metadata": {}
      };

      final result = CameraResult.fromJson(resultMock);
      expect(result, isNotNull);
      expect(result.recording?.toJson(), resultMock["recording"]);
      expect(result.reaction?.toJson(), resultMock["reaction"]);
      expect(result.metadata, resultMock["metadata"]);
    });

    test('EditorResult Parsing - Null', () {
      const resultMock = {
        "scene": null,
        "artifact": null,
        "thumbnail": null,
        "metadata": null
      };

      final result = CameraResult.fromJson(resultMock);
      expect(result, isNotNull);
      expect(result.recording, null);
      expect(result.reaction, null);
      expect(result.metadata, {});
    });

    test('EditorResult Parsing - Empty', () {
      const Map<String, dynamic> resultMock = {};

      final result = CameraResult.fromJson(resultMock);
      expect(result, isNotNull);
      expect(result.recording, null);
      expect(result.reaction, null);
      expect(result.metadata, {});
    });
  });
}
