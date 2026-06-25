import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/story/add_story_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_button.dart';

class AddStoryScreen extends GetView<AddStoryController> {
  const AddStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              _appBar(),
              Expanded(child: _preview()),
              _galleryRow(),
              // Post button — hidden until an image is selected/captured.
              Obx(
                () => controller.hasSelection
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                        child: CustomButton(
                          height: 52,
                          margin: 0,
                          borderRadius: 14,
                          title: 'Add to Story',
                          titleFontSize: 16,
                          backgroundColor: AppColors.splashCircle,
                          textColor: Colors.white,
                          onTap: controller.postStory,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(height: 12),
              _bottomControls(),
              const SizedBox(height: 10),
              const Text(
                'Hold for video, tap for photo',
                style: TextStyle(fontSize: 15, color: AppColors.blackText),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: controller.onBack,
            child: const SizedBox(
              width: 40,
              height: 40,
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: AppColors.blackText,
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Add to story',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackText,
                ),
              ),
            ),
          ),
          const SizedBox(width: 40, height: 40),
        ],
      ),
    );
  }

  /// Empty white capture area (no live preview with image_picker); shows the
  /// selected image once one is picked/captured/chosen.
  Widget _preview() {
    return Obx(() {
      final File? file = controller.selectedFileIo;
      final String? asset = controller.selectedAsset.value;
      if (file != null) {
        return Center(child: Image.file(file, fit: BoxFit.contain));
      }
      if (asset != null) {
        return Center(child: Image.asset(asset, fit: BoxFit.contain));
      }
      return const SizedBox.expand();
    });
  }

  Widget _galleryRow() {
    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: controller.galleryThumbnails.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final asset = controller.galleryThumbnails[index];
          return Obx(() {
            final selected = controller.selectedAsset.value == asset;
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => controller.selectThumbnail(asset),
              child: Container(
                width: 74,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: selected
                      ? Border.all(color: AppColors.splashCircle, width: 3)
                      : null,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(asset, fit: BoxFit.cover),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _bottomControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          // Gallery
          Expanded(
            child: Align(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: controller.pickFromGallery,
                child: const Icon(
                  Icons.image_outlined,
                  size: 30,
                  color: AppColors.blackText,
                ),
              ),
            ),
          ),
          // Capture (tap = photo, hold = video)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.keyboard_arrow_up,
                size: 26,
                color: AppColors.borderColor,
              ),
              const SizedBox(height: 4),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: controller.capturePhoto,
                onLongPress: controller.captureVideo,
                child: Container(
                  width: 74,
                  height: 74,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: AppColors.borderColor, width: 2),
                  ),
                ),
              ),
            ],
          ),
          // Camera switch
          Expanded(
            child: Align(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: controller.toggleCamera,
                child: Obx(
                  () => Icon(
                    Icons.photo_camera_outlined,
                    size: 30,
                    color: controller.useFrontCamera.value
                        ? AppColors.splashCircle
                        : AppColors.blackText,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
