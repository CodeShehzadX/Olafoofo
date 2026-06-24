import 'package:get/get.dart';

/// A single notification row.
///
/// The text is split into a bold lead, an optional regular part, and an
/// optional trailing italic word (e.g. *photo* / *post*) to match the design.
class NotificationItem {
  const NotificationItem({
    required this.avatar,
    required this.boldText,
    this.normalText,
    this.italicText,
    required this.time,
  });

  final String avatar;
  final String boldText;
  final String? normalText;
  final String? italicText;
  final String time;
}

/// A dated group of notifications (e.g. "Today", "12 January 2022").
class NotificationSection {
  const NotificationSection({required this.title, required this.items});

  final String title;
  final List<NotificationItem> items;
}

/// Business logic + state for the Notifications screen (GetX, no setState).
class NotificationController extends GetxController {
  /// Grouped notifications (reactive so clearing updates the UI).
  final RxList<NotificationSection> sections = <NotificationSection>[
    const NotificationSection(
      title: 'Today',
      items: [
        NotificationItem(
          avatar: 'assets/images/1stpost_user_image.png',
          boldText: 'Patrick',
          normalText: ' Followed you',
          time: 'Just Now',
        ),
        NotificationItem(
          avatar: 'assets/images/2ndpost_user_image.png',
          boldText: 'Chris',
          normalText: ' Followed you',
          time: '2mins ago',
        ),
        NotificationItem(
          avatar: 'assets/images/like_user_image_1.png',
          boldText: 'Segun Liked your',
          italicText: ' photo',
          time: '15mins ago',
        ),
        NotificationItem(
          avatar: 'assets/images/like_user_image_2.png',
          boldText: 'Chris commented on your',
          italicText: ' post',
          time: '1hour ago',
        ),
      ],
    ),
    const NotificationSection(
      title: '12 January 2022',
      items: [
        NotificationItem(
          avatar: 'assets/images/like_user_image_3.png',
          boldText: 'Patrick',
          normalText: ' Followed you',
          time: '11:20am',
        ),
        NotificationItem(
          avatar: 'assets/images/1stStory_user_image.png',
          boldText: 'Chris',
          normalText: ' Followed you',
          time: '10:00am',
        ),
        NotificationItem(
          avatar: 'assets/images/2ndStory_user_image.png',
          boldText: 'Segun Liked your',
          italicText: ' photo',
          time: '09:00am',
        ),
        NotificationItem(
          avatar: 'assets/images/3rdStory_user_image.png',
          boldText: 'Chris commented on your',
          italicText: ' post',
          time: '07:00am',
        ),
      ],
    ),
  ].obs;

  /// Whether there are no notifications left.
  bool get isEmpty => sections.isEmpty;

  /// Clear all notifications (trash icon).
  void clearAll() => sections.clear();

  /// Pop back to the previous screen.
  void onBack() => Get.back();
}
