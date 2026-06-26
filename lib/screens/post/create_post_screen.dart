import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/post/create_post_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/back_title_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

/// The Create Post ("Post") screen — Figma page 26.
///
/// Rendered inside the main shell as the center "+" tab, so (like [HomeScreen])
/// it has no Scaffold/bottom-nav of its own; back/upload switch tabs via the
/// controller.
class CreatePostScreen extends GetView<CreatePostController> {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          BackTitleAppBar(title: 'Post', onBack: controller.onBack),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 28, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('Select Image(s)'),
                  const SizedBox(height: 10),
                  _imagePicker(),
                  const SizedBox(height: 24),
                  _label('Add caption'),
                  const SizedBox(height: 10),
                  CustomTextfield(
                    controller: controller.captionController,
                    text: '',
                    maxLines: 5,
                    filledColor: AppColors.lightGray,
                    borderRadius: 14,
                    contentPadding: 18,
                  ),
                  const SizedBox(height: 24),
                  _label('Add hastags'),
                  const SizedBox(height: 10),
                  CustomTextfield(
                    controller: controller.hashtagController,
                    text: '',
                    filledColor: AppColors.lightGray,
                    borderRadius: 14,
                    contentPadding: 18,
                  ),
                  const SizedBox(height: 32),
                  Obx(
                    () => CustomButton(
                      height: 56,
                      margin: 0,
                      borderRadius: 14,
                      title: 'Upload',
                      titleFontSize: 18,
                      fontWeight: FontWeight.w700,
                      backgroundColor: AppColors.splashCircle,
                      textColor: Colors.white,
                      loading: controller.isUploading.value,
                      disabled: !controller.canUpload,
                      onTap: controller.upload,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.blackText,
      ),
    );
  }

  /// The "Select Image(s)" area: teal-bordered gray box that shows the picked
  /// image, with a rounded "+" button (bottom-right) to pick/replace it.
  Widget _imagePicker() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: controller.pickImage,
      child: Container(
        height: 290,
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.splashCircle, width: 1.5),
        ),
        child: Stack(
          children: [
            Obx(() {
              final file = controller.selectedImageIo;
              if (file == null) return const SizedBox.expand();
              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox.expand(
                  child: Image.file(file, fit: BoxFit.cover),
                ),
              );
            }),
            Positioned(
              right: 14,
              bottom: 14,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: controller.pickImage,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.splashCircle,
                      width: 1.5,
                    ),
                  ),
                  child: Obx(
                    () => Icon(
                      // After an image is picked, the "+" becomes a change/edit
                      // affordance.
                      controller.hasImage ? Icons.edit_outlined : Icons.add,
                      color: AppColors.splashCircle,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
