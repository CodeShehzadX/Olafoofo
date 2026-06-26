import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

/// A person shown in the "Frequently chatted" horizontal row.
class FrequentContact {
  const FrequentContact({required this.avatar, this.isOnline = true});

  final String avatar;
  final bool isOnline;
}

/// A conversation row in the "All Messages" list (and the Chat Detail header).
class ChatItem {
  const ChatItem({
    required this.name,
    required this.avatar,
    required this.preview,
    required this.time,
    this.unreadCount = 0,
    this.showArrow = false,
    this.isRead = false,
    this.lastSeen = 'Last seen 2hrs ago',
  });

  final String name;
  final String avatar;

  /// Last-message preview / subtitle.
  final String preview;

  /// Right-aligned timestamp ("08:43", "Yesterday").
  final String time;

  /// Unread message count (0 = none → no count badge).
  final int unreadCount;

  /// Show the teal chevron badge (a new chat with no explicit count).
  final bool showArrow;

  /// Show the read double-tick (last outgoing message was read).
  final bool isRead;

  /// Subtitle shown under the name in Chat Detail.
  final String lastSeen;
}

/// Business logic for the Chat list (GetX only, no setState). Dummy data.
class ChatController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  final List<FrequentContact> frequentlyChatted = const [
    FrequentContact(avatar: 'assets/images/frequently_chatted_1.png'),
    FrequentContact(
        avatar: 'assets/images/frequently_chatted_2.png', isOnline: false),
    FrequentContact(avatar: 'assets/images/frequently_chatted_3.png'),
    FrequentContact(
        avatar: 'assets/images/frequently_chatted_4.png', isOnline: false),
    FrequentContact(avatar: 'assets/images/frequently_chatted_5.png'),
  ];

  final List<ChatItem> chats = const [
    ChatItem(
      name: 'Abdul Quayyum',
      avatar: 'assets/images/chat_1.png',
      preview: 'olabodeoyindolapo@gmail.com',
      time: '08:43',
      showArrow: true,
    ),
    ChatItem(
      name: 'Chris Uil',
      avatar: 'assets/images/chat_2.png',
      preview: '1,2 and 6 are remaining',
      time: '08:43',
      showArrow: true,
    ),
    ChatItem(
      name: 'Joe Mickey',
      avatar: 'assets/images/chat_3.png',
      preview: 'Send me d link bro',
      time: '08:43',
      isRead: true,
    ),
    ChatItem(
      name: 'Ojogbon',
      avatar: 'assets/images/chat_4.png',
      preview: 'Bobo yina 👍',
      time: '08:43',
      isRead: true,
    ),
    ChatItem(
      name: 'General Focus',
      avatar: 'assets/images/chat_5.png',
      preview: 'Update from your end',
      time: '08:43',
      unreadCount: 2,
    ),
    ChatItem(
      name: 'Sister Lee',
      avatar: 'assets/images/chat_6.png',
      preview: 'okay dear...How much?',
      time: 'Yesterday',
      unreadCount: 1,
    ),
    ChatItem(
      name: 'Abdul Q',
      avatar: 'assets/images/chat_1.png',
      preview: 'See you tomorrow',
      time: 'Yesterday',
      isRead: true,
    ),
  ];

  /// Open the Chat Detail for [chat].
  void openChat(ChatItem chat) =>
      Get.toNamed(AppRoutes.chatDetail, arguments: chat);

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
