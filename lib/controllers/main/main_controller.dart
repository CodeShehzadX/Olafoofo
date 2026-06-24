import 'package:get/get.dart';

/// Holds the selected bottom-navigation tab for the main app shell.
///
/// GetX only — no setState. Screens read [currentIndex] reactively.
class MainController extends GetxController {
  /// Index of the active tab: 0 Home · 1 Ofofo · 2 Add Post · 3 Chats · 4 Profile.
  final RxInt currentIndex = 0.obs;

  /// Switch to the tab at [index].
  void changeTab(int index) => currentIndex.value = index;
}
