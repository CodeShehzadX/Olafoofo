import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/chat/chat_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/back_title_app_bar.dart';
import '../../widgets/chat_tile.dart';
import '../../widgets/custom_search_bar.dart';

/// The Chats list tab — Frequently chatted row + All Messages list.
///
/// Rendered inside the main shell, so (like [HomeScreen]) it has no
/// Scaffold/bottom-nav of its own.
class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          BackTitleAppBar(title: 'Chats', onBack: controller.onBack),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: CustomSearchBar(
              controller: controller.searchController,
              hintText: 'Search chat here.....',
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              children: [
                _sectionTitle('Frequently chatted'),
                const SizedBox(height: 12),
                _frequentlyChatted(),
                const SizedBox(height: 20),
                _sectionTitle('All Messages'),
                const SizedBox(height: 4),
                for (final chat in controller.chats)
                  ChatTile(chat: chat, onTap: () => controller.openChat(chat)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: AppColors.blackText,
      ),
    );
  }

  Widget _frequentlyChatted() {
    return SizedBox(
      height: 66,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: controller.frequentlyChatted.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final contact = controller.frequentlyChatted[index];
          return SizedBox(
            width: 60,
            height: 60,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Rounded-rectangle card (not a circle).
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    contact.avatar,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          contact.isOnline
                              ? AppColors.success
                              : AppColors.error,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
