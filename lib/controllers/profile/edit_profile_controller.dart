import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_profile_controller.dart';

/// Business logic for Edit Profile (GetX only, no setState).
///
/// Seeds its fields from [MyProfileController] and writes them back on Update so
/// My Profile reflects the changes immediately.
class EditProfileController extends GetxController {
  final MyProfileController _profile = Get.find<MyProfileController>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  /// Avatar shown in the header (read-only here).
  String get avatar => MyProfileController.avatar;

  /// Current display name/region for the header (reactive).
  RxString get name => _profile.name;
  RxString get region => _profile.region;

  @override
  void onInit() {
    super.onInit();
    usernameController.text = _profile.name.value;
    regionController.text = _profile.region.value;
    phoneController.text = _profile.phoneNumber.value;
    genderController.text = _profile.gender.value;
    aboutController.text = _profile.about.value;
  }

  /// Save edits back to the profile and return to My Profile.
  void submit() {
    _profile.save(
      name: usernameController.text.trim(),
      region: regionController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      gender: genderController.text.trim(),
      about: aboutController.text.trim(),
    );
    Get.back();
  }

  void onBack() => Get.back();

  @override
  void onClose() {
    usernameController.dispose();
    regionController.dispose();
    phoneController.dispose();
    genderController.dispose();
    aboutController.dispose();
    super.onClose();
  }
}
