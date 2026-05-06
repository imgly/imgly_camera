#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint imgly_camera.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'imgly_camera'
  s.version          = '1.73.1'
  s.summary          = 'Camera SDK for Flutter.'
  s.homepage         = 'https://img.ly'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'IMG.LY GmbH' => 'contact@img.ly' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'

  s.dependency 'Flutter'
  s.dependency 'IMGLYCamera', s.version.to_s

  s.platform = :ios, '16.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.10'
end
