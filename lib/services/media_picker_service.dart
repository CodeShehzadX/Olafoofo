import 'package:image_picker/image_picker.dart';

/// Thin shared wrapper around [image_picker] so screens that pick or capture
/// media (Add Story, Create Post, …) don't duplicate the picker setup.
///
/// Callers keep their own error handling / snackbars; these methods only do the
/// raw OS pick and return the resulting [XFile] (or null if the user cancels).
class MediaPickerService {
  MediaPickerService._();

  static final ImagePicker _picker = ImagePicker();

  /// Open the system gallery to pick an image.
  static Future<XFile?> pickImageFromGallery() =>
      _picker.pickImage(source: ImageSource.gallery);

  /// Capture a photo with the camera.
  static Future<XFile?> capturePhoto({bool front = false}) => _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: front ? CameraDevice.front : CameraDevice.rear,
      );

  /// Capture a video with the camera.
  static Future<XFile?> captureVideo({bool front = false}) => _picker.pickVideo(
        source: ImageSource.camera,
        preferredCameraDevice: front ? CameraDevice.front : CameraDevice.rear,
      );
}
