import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile/edit_profile_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/user_avatar.dart';

/// Edit Profile — seeded from My Profile, writes changes back on Update.
class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              _appBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(),
                      const SizedBox(height: 24),

                      _label('Username'),
                      const SizedBox(height: 8),
                      CustomTextfield(
                        controller: controller.usernameController,
                        text: '',
                        borderColor: AppColors.splashCircle,
                        filledColor: Colors.white,
                        borderRadius: 14,
                        contentPadding: 16,
                      ),
                      const SizedBox(height: 18),

                      _label('Region'),
                      const SizedBox(height: 8),
                      CustomTextfield(
                        controller: controller.regionController,
                        text: '',
                        filledColor: AppColors.lightGray,
                        borderRadius: 14,
                        contentPadding: 16,
                      ),
                      const SizedBox(height: 18),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _label('Phone Number'),
                                const SizedBox(height: 8),
                                CustomTextfield(
                                  controller: controller.phoneController,
                                  text: '',
                                  textInputType: TextInputType.phone,
                                  filledColor: AppColors.lightGray,
                                  borderRadius: 14,
                                  contentPadding: 16,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _label('Gender'),
                                const SizedBox(height: 8),
                                CustomTextfield(
                                  controller: controller.genderController,
                                  text: '',
                                  filledColor: AppColors.lightGray,
                                  borderRadius: 14,
                                  contentPadding: 16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      _label('About'),
                      const SizedBox(height: 8),
                      CustomTextfield(
                        controller: controller.aboutController,
                        text: '',
                        maxLines: 4,
                        filledColor: AppColors.lightGray,
                        borderRadius: 14,
                        contentPadding: 16,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: CustomButton(
                  height: 56,
                  margin: 0,
                  borderRadius: 14,
                  title: 'Update',
                  titleFontSize: 18,
                  fontWeight: FontWeight.w700,
                  backgroundColor: AppColors.splashCircle,
                  textColor: Colors.white,
                  onTap: controller.submit,
                ),
              ),
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
                'My Profile',
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

  Widget _header() {
    return Row(
      children: [
        _avatarWithBadge(),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  controller.name.value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackText,
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Obx(
                () => Text(
                  controller.region.value,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textHint,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.blackText,
      ),
    );
  }

  /// Profile avatar with the camera/edit badge (Figma — Edit Profile only).
  Widget _avatarWithBadge() {
    return SizedBox(
      width: 58,
      height: 58,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          UserAvatar(image: controller.avatar, size: 58),
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.splashCircle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                Icons.photo_camera,
                size: 11,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
