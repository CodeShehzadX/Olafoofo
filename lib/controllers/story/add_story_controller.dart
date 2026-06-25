import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/media_picker_service.dart';
import '../../widgets/custom_snackbar.dart';
import '../home/home_controller.dart';

/// Business logic + state for the Add to Story screen (GetX, no setState).
///
/// Uses the existing `image_picker` package for gallery picking and camera
/// capture. Note: `image_picker` has NO live camera preview and cannot flip the
/// camera in-app — it only opens the OS camera UI and accepts a
/// `preferredCameraDevice`. A true in-app preview + live front/back switch would
/// require the `camera` package (not added).
class AddStoryController extends GetxController {
  /// Photo picked/captured via the OS (gallery or camera).
  final Rxn<XFile> selectedFile = Rxn<XFile>();

  /// Selected dummy gallery thumbnail (asset path).
  final RxnString selectedAsset = RxnString();

  /// Preferred camera for the next capture (image_picker hint).
  final RxBool useFrontCamera = false.obs;

  /// Dummy gallery thumbnails built from existing assets.
  final List<String> galleryThumbnails = const [
    'assets/images/story_1.png',
    'assets/images/story_2.png',
    'assets/images/1stStory_chris.png',
    'assets/images/2ndStory_general.png',
    'assets/images/3rdStory_ojogbon.png',
    'assets/images/4thStory_john.png',
    'assets/images/1st_post_image.png',
    'assets/images/2nd_post_image.png',
  ];

  bool get hasSelection =>
      selectedFile.value != null || selectedAsset.value != null;

  /// Path of the current selection (captured/picked file, or chosen asset).
  String? get selectedPath =>
      selectedFile.value?.path ?? selectedAsset.value;

  /// The picked file as a dart:io [File], for the preview.
  File? get selectedFileIo =>
      selectedFile.value == null ? null : File(selectedFile.value!.path);

  /// Select one of the dummy gallery thumbnails.
  void selectThumbnail(String asset) {
    selectedAsset.value = asset;
    selectedFile.value = null;
  }

  /// Open the system gallery to pick an image.
  Future<void> pickFromGallery() async {
    try {
      final XFile? image = await MediaPickerService.pickImageFromGallery();
      if (image != null) {
        selectedFile.value = image;
        selectedAsset.value = null;
      }
    } catch (_) {
      _showError('gallery');
    }
  }

  /// Capture a photo with the camera (tap).
  Future<void> capturePhoto() async {
    try {
      final XFile? photo =
          await MediaPickerService.capturePhoto(front: useFrontCamera.value);
      if (photo != null) {
        selectedFile.value = photo;
        selectedAsset.value = null;
      }
    } catch (_) {
      _showError('camera');
    }
  }

  /// Capture a video with the camera (hold).
  Future<void> captureVideo() async {
    try {
      final XFile? video =
          await MediaPickerService.captureVideo(front: useFrontCamera.value);
      if (video != null) {
        // TODO: preview/upload the captured video. We only render an image
        // preview for now; playback needs a video_player package.
        CustomSnackbar.success(title: 'Recorded', message: 'Video captured');
      }
    } catch (_) {
      _showError('camera');
    }
  }

  /// Toggle the preferred front/back camera for the next capture.
  void toggleCamera() => useFrontCamera.value = !useFrontCamera.value;

  /// Add the selected image to the current user's story group, then return.
  void postStory() {
    final path = selectedPath;
    if (path == null) return;
    Get.find<HomeController>().addStoryMedia(path);
    Get.back();
  }

  void onBack() => Get.back();

  void _showError(String which) {
    CustomSnackbar.error(
      title: 'Unavailable',
      message: 'Could not access the $which. Check app permissions.',
    );
  }
}
