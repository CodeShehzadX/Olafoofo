import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/chat/chat_detail_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/message_bubble.dart';
import '../../widgets/user_avatar.dart';

/// A single conversation: header, dated message bubbles and an input bar.
class ChatDetailScreen extends GetView<ChatDetailController> {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              _appBar(),
              const Divider(height: 1, color: AppColors.lightBorder),
              Expanded(child: _messages()),
              _inputBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
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
          Expanded(
            child: Column(
              children: [
                Text(
                  controller.chat.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  controller.chat.lastSeen,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
          UserAvatar(image: controller.chat.avatar, size: 40),
        ],
      ),
    );
  }

  Widget _messages() {
    return Obx(
      () => ListView.builder(
        controller: controller.scrollController,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        itemCount: controller.messages.length,
        itemBuilder: (context, index) {
          final message = controller.messages[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (message.daySeparator != null)
                _daySeparator(message.daySeparator!),
              MessageBubble(message: message),
            ],
          );
        },
      ),
    );
  }

  Widget _daySeparator(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textHint),
        ),
      ),
    );
  }

  Widget _inputBar() {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Row(
          children: [
            // Plus button
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.splashCircle,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 10),
            // Input field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.splashCircle.withValues(alpha: 0.5),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: controller.inputController,
                  onSubmitted: (_) => controller.send(),
                  textInputAction: TextInputAction.send,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.blackText,
                  ),
                  decoration: const InputDecoration(
                    isCollapsed: true,
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    hintText: 'Type a comment',
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: AppColors.textHint,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Send button
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: controller.send,
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.splashCircle,
                ),
                child: const Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
