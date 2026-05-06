# IMG.LY Camera

The `imgly_camera` plugin contains the prebuilt iOS and Android Camera SDK powered by the _Creative Engine_ - made accessible for Flutter.
The Creative Engine enables you to build any design editing UI, automation and creative workflow.
It offers performant and robust graphics processing capabilities combining the best of layout, typography and image processing with advanced workflows centered around templating and adaptation.

Visit our [documentation](https://img.ly/docs/cesdk) for more tutorials on how to integrate and customize the engine for your specific use case.

## License

The Camera SDK is a commercial product. You can purchase a license at https://img.ly/pricing. Alternatively, you can use `null` as the license parameter to run the SDK in evaluation mode with a watermark.

## Integration

```Dart
import 'package:imgly_editor/imgly_camera.dart';

// Configure the camera.
final settings = CameraSettings(license: "YOUR_LICENSE");

// Open the editor and retrieve the result.
final result = await IMGLYCamera.openCamera(settings: settings);
```

## Changelog

To keep up-to-date with the latest changes, visit [CHANGELOG](https://img.ly/docs/cesdk/changelog/).
