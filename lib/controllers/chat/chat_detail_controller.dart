import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'chat_controller.dart';

/// A single message in a conversation.
class Message {
  Message({
    required this.text,
    required this.time,
    required this.isSent,
    this.image,
    this.daySeparator,
  });

  /// Message body (may be empty when [image] is set).
  final String text;

  /// Display timestamp, e.g. "12:21pm".
  final String time;

  /// True = outgoing (me, right-aligned); false = incoming (left-aligned).
  final bool isSent;

  /// Optional attached image asset path.
  final String? image;

  /// If set, a centered date separator is shown above this message.
  final String? daySeparator;
}

/// Business logic for a single conversation (GetX only, no setState). Dummy data.
class ChatDetailController extends GetxController {
  final TextEditingController inputController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  /// The conversation this screen was opened for (name/avatar/last seen).
  late final ChatItem chat;

  /// Whether the input has text (drives the send button).
  final RxBool canSend = false.obs;

  final RxList<Message> messages = <Message>[
    Message(
      text: 'Hi, How are you today?',
      time: '12:21pm',
      isSent: false,
      daySeparator: 'Yesterday',
    ),
    Message(text: "I'm fine what bout you?", time: '12:22pm', isSent: true),
    Message(
      text: 'when are you ready??',
      time: '12:21pm',
      isSent: false,
      daySeparator: 'Today 06:30pm',
    ),
    Message(text: 'Okay i will....THANK YOUU', time: '06:32pm', isSent: true),
    Message(
      text:
          "I called you yesterday but you didn't pick the call, i hope all is well tho.......see you later today....xoxo",
      time: '06:33pm',
      isSent: true,
    ),
    Message(
      text: "I'm at Eden garden",
      time: '08:32pm',
      isSent: true,
      image: 'assets/images/conversation_image.jpg',
    ),
    Message(
      text: "Alright I'm coming to pick you",
      time: '06:30pm',
      isSent: false,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    chat = Get.arguments as ChatItem;
    inputController.addListener(
      () => canSend.value = inputController.text.trim().isNotEmpty,
    );
  }

  /// Append the typed text as a new outgoing message and scroll to it.
  void send() {
    final text = inputController.text.trim();
    if (text.isEmpty) return;
    messages.add(
      Message(
        text: text,
        time: DateFormat('hh:mma').format(DateTime.now()).toLowerCase(),
        isSent: true,
      ),
    );
    inputController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void onBack() => Get.back();

  @override
  void onClose() {
    inputController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
