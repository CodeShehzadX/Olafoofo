import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/media_picker_service.dart';
import '../../widgets/custom_snackbar.dart';
import '../home/home_controller.dart';
import '../main/main_controller.dart';

/// Business logic + state for the Create Post ("Post") screen (GetX, no setState).
///
/// Reuses [MediaPickerService] (shared with Add Story) for picking the image.
/// On upload it builds a new [PostModel] via [HomeController.addPost], which
/// inserts it at the top of the existing Home Feed — no duplicate post list.
class CreatePostController extends GetxController {
  final TextEditingController captionController = TextEditingController();
  final TextEditingController hashtagController = TextEditingController();

  /// The image selected from the gallery.
  final Rxn<XFile> selectedImage = Rxn<XFile>();

  /// True while an upload is in flight (drives the button loader).
  final RxBool isUploading = false.obs;

  bool get hasImage => selectedImage.value != null;

  /// Whether the post can be uploaded. Requires at least one image; the caption
  /// is optional (the project has no caption validation rule — matches Figma).
  bool get canUpload => hasImage;

  /// The picked image as a dart:io [File], for the preview.
  File? get selectedImageIo =>
      selectedImage.value == null ? null : File(selectedImage.value!.path);

  /// Open the system gallery to pick (or replace) the post image.
  Future<void> pickImage() async {
    try {
      final XFile? image = await MediaPickerService.pickImageFromGallery();
      if (image != null) selectedImage.value = image;
    } catch (_) {
      CustomSnackbar.error(
        title: 'Unavailable',
        message: 'Could not access the gallery. Check app permissions.',
      );
    }
  }

  /// Create the post, insert it at the top of the Home Feed, then return Home.
  Future<void> upload() async {
    if (!hasImage) {
      CustomSnackbar.error(
        title: 'No image',
        message: 'Please select an image to upload.',
      );
      return;
    }

    isUploading.value = true;

    // Reuse the existing Home Feed data — no duplicate post list.
    Get.find<HomeController>().addPost(
      imagePath: selectedImage.value!.path,
      caption: captionController.text.trim(),
      hashtags: hashtagController.text.trim(),
    );

    isUploading.value = false;
    _reset();

    // Back to Home (this screen is the center tab in the shell); the new post
    // is now at the top of the feed.
    Get.find<MainController>().changeTab(0);
    CustomSnackbar.success(title: 'Posted', message: 'Your post is now live.');
  }

  void _reset() {
    captionController.clear();
    hashtagController.clear();
    selectedImage.value = null;
  }

  /// Back button — return to the Home tab.
  void onBack() => Get.find<MainController>().changeTab(0);

  @override
  void onClose() {
    captionController.dispose();
    hashtagController.dispose();
    super.onClose();
  }
}
