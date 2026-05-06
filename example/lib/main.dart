import 'package:flutter/material.dart';
import 'package:imgly_camera/imgly_camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('IMGLY Camera Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final result = await IMGLYCamera.openCamera(
                    const CameraSettings(
                      license: 'YOUR_LICENSE',
                      userId: 'test-user',
                    ),
                  );

                  if (result != null) {
                    debugPrint('Recording result: $result');
                  } else {
                    debugPrint('Camera cancelled');
                  }
                },
                child: const Text('Open Camera'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final result = await IMGLYCamera.openCamera(
                    const CameraSettings(
                      license: 'YOUR_LICENSE',
                      userId: 'test-user',
                    ),
                    video: 'https://example.com/test-video.mp4',
                    metadata: {'test': 'data'},
                  );

                  if (result != null) {
                    debugPrint('Reaction result: $result');
                  } else {
                    debugPrint('Camera cancelled');
                  }
                },
                child: const Text('Open Camera with Reaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
