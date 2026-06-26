import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/create_lounge_sheet.dart';
import '../../widgets/live_lounge_sheet.dart';
import '../main/main_controller.dart';

/// A single Ofofo/Lounge room shown on the Ofofo list screen.
class Lounge {
  const Lounge({
    required this.title,
    required this.listeningLabel,
    required this.listenerAvatars,
    required this.hostName,
    required this.speakerName,
    required this.speakerAvatar,
    this.isLive = true,
  });

  final String title;

  /// e.g. "200k people listening".
  final String listeningLabel;

  /// Overlapping listener avatar asset paths.
  final List<String> listenerAvatars;

  final String hostName;

  /// Current speaker's display name (rendered as "`name` is speaking").
  final String speakerName;

  /// Current speaker's avatar asset path.
  final String speakerAvatar;

  final bool isLive;
}

/// Business logic + state for the Ofofo/Lounge list screen (GetX, no setState).
///
/// Dummy/local data only — no backend.
class LoungeController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  /// Dummy Ofofo rooms. The first is shown under "Feeling bored?…", the rest
  /// under "Happening Now" — matching Figma page 23.
  final List<Lounge> lounges = const [
    Lounge(
      title: 'The Chirp app is live on App Store',
      listeningLabel: '200k people listening',
      listenerAvatars: [
        'assets/images/listener_1.png',
        'assets/images/listener_2.png',
        'assets/images/listener_3.png',
      ],
      hostName: 'Oyin Dolapo',
      speakerName: 'Abdul',
      speakerAvatar: 'assets/images/speaker_1.png',
    ),
    Lounge(
      title: 'The Chirp app is live on App Store',
      listeningLabel: '200k people listening',
      listenerAvatars: [
        'assets/images/listener_4.png',
        'assets/images/listener_5.png',
        'assets/images/listener_6.png',
      ],
      hostName: 'Oyin Dolapo',
      speakerName: 'Abdul',
      speakerAvatar: 'assets/images/speaker_2.png',
    ),
    Lounge(
      title: 'The Chirp app is live on App Store',
      listeningLabel: '200k people listening',
      listenerAvatars: [
        'assets/images/listener_7.png',
        'assets/images/listener_8.png',
        'assets/images/listener_9.png',
      ],
      hostName: 'Oyin Dolapo',
      speakerName: 'Abdul',
      speakerAvatar: 'assets/images/speaker_3.png',
    ),
  ];

  /// Open the Create Lounge modal bottom sheet (floating button).
  void createOfofo() => CreateLoungeSheet.show();

  /// Open the Live Lounge bottom sheet for [lounge].
  void openLounge(Lounge lounge) => LiveLoungeSheet.show(lounge);

  /// Back button — return to the Home tab.
  void onBack() => Get.find<MainController>().changeTab(0);

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
