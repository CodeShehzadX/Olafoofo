import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../main/main_controller.dart';

/// Business logic + reactive data for My Profile (GetX only, no setState).
///
/// Holds the single source of truth for the editable profile fields; Edit
/// Profile writes back here so My Profile reflects changes immediately.
/// Dummy/local data only.
class MyProfileController extends GetxController {
  // ---- Editable profile fields (reactive) -----------------------------------
  final RxString name = 'Oyin Dolapo'.obs;
  final RxString region = 'Abeokuta, Ogun'.obs;
  final RxString phoneNumber = '+234 801 234 5678'.obs;
  final RxString gender = 'Female'.obs;
  final RxString about =
      "I'm a postive person. I love to travel and eat Always available for chat"
          .obs;

  // ---- Static profile data --------------------------------------------------
  static const String avatar = 'assets/images/user_profile_image.png';

  final String postsCount = '87';
  final String followingCount = '870';
  final String followersCount = '15k';

  /// Post thumbnails for the 3-column grid.
  final List<String> posts = List.generate(
    9,
    (i) => 'assets/images/profile_post_${i + 1}.png',
  );

  /// Apply edited values (called by Edit Profile on Update).
  void save({
    required String name,
    required String region,
    required String phoneNumber,
    required String gender,
    required String about,
  }) {
    this.name.value = name;
    this.region.value = region;
    this.phoneNumber.value = phoneNumber;
    this.gender.value = gender;
    this.about.value = about;
  }

  /// Open the Edit Profile screen.
  void openEditProfile() => Get.toNamed(AppRoutes.editProfile);

  /// Open settings (gear icon).
  void openSettings() {
    // TODO: navigate to a Settings screen once it exists.
  }

  /// Edit the profile picture (camera badge).
  void editProfilePicture() {
    // TODO: pick/replace the profile picture.
  }

  /// Back button — return to the Home tab.
  void onBack() => Get.find<MainController>().changeTab(0);
}
