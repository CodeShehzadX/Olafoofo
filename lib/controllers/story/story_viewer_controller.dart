import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/story_models.dart';

/// A single live-chat comment shown in the live story overlay.
class LiveComment {
  const LiveComment({required this.username, required this.text});

  final String username;
  final String text;
}

/// Business logic + state for the Story Viewer (GetX, no setState).
///
/// Receives a [StoryGroup] (and start index) via [Get.arguments] and steps
/// through that user's media one by one; closes after the last one.
class StoryViewerController extends GetxController {
  /// The story group being viewed.
  late final StoryGroup group;

  /// Index of the currently shown media within [group].
  final RxInt currentIndex = 0.obs;

  /// Progress of the current media segment (0..1).
  final RxDouble progress = 0.0.obs;

  /// Downward drag offset for the swipe-down-to-close gesture.
  final RxDouble dragOffset = 0.0.obs;
  double _dragAccum = 0;

  /// Live like state.
  final RxBool isLiked = false.obs;
  final RxInt likeCount = 0.obs;

  /// Static live comment count.
  final int commentCount = 292;

  /// Dummy comment input + its focus (focused by swipe-up).
  final TextEditingController commentController = TextEditingController();
  final FocusNode commentFocusNode = FocusNode();

  /// Dummy live comments (live stories only).
  final List<LiveComment> liveComments = const [
    LiveComment(username: 'Micheal Bruno', text: 'woowwww dis is awesome'),
    LiveComment(
      username: 'MF 123455555',
      text: 'Really good stuff....Its amazing! love it so much',
    ),
    LiveComment(username: 'Chris Okorie', text: 'Wonderfullllllllll'),
  ];

  Timer? _timer;
  bool _isClosing = false;

  static const Duration _storyDuration = Duration(seconds: 6);
  static const Duration _tick = Duration(milliseconds: 50);

  // Swipe gesture thresholds.
  static const double _closeDragThreshold = 120; // drag down distance to close
  static const double _flingVelocity = 700; // fast fling (px/s)
  static const double _focusUpDistance = 80; // drag up distance to focus input

  int get mediaCount => group.media.length;
  StoryMedia get currentMedia => group.media[currentIndex.value];
  bool get isLive => group.isLive;

  String get username => group.username;
  String get avatar => group.avatar;
  String get watchingText => '${_compact(group.watching)} watching';
  String get likeText => _compact(likeCount.value);
  String get commentText => '$commentCount';

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as StoryViewerArgs;
    group = args.group;
    currentIndex.value =
        args.startIndex.clamp(0, (mediaCount - 1).clamp(0, mediaCount));
    likeCount.value = isLive ? 12000 : 0;
    _startProgress();
  }

  void _startProgress() {
    _timer?.cancel();
    progress.value = 0;
    final step = _tick.inMilliseconds / _storyDuration.inMilliseconds;
    _timer = Timer.periodic(_tick, (timer) {
      final next = progress.value + step;
      if (next >= 1.0) {
        progress.value = 1.0;
        timer.cancel();
        _advance();
      } else {
        progress.value = next;
      }
    });
  }

  /// Move to the next media, or close after the last one.
  void _advance() {
    if (currentIndex.value < mediaCount - 1) {
      currentIndex.value++;
      _startProgress();
    } else {
      close();
    }
  }

  /// Progress value to render for the segment at [index].
  double segmentProgress(int index) {
    if (index < currentIndex.value) return 1.0;
    if (index > currentIndex.value) return 0.0;
    return progress.value;
  }

  /// Toggle the live like.
  void toggleLike() {
    if (isLiked.value) {
      isLiked.value = false;
      likeCount.value -= 1;
    } else {
      isLiked.value = true;
      likeCount.value += 1;
    }
  }

  /// Accumulate a vertical drag; translate down only (snaps back on release).
  void onDragUpdate(double deltaDy) {
    _dragAccum += deltaDy;
    dragOffset.value = _dragAccum > 0 ? _dragAccum : 0;
  }

  /// Decide the gesture on release: swipe-down closes, swipe-up focuses input.
  void onDragEnd(double velocity) {
    final shouldClose =
        dragOffset.value > _closeDragThreshold || velocity > _flingVelocity;
    if (shouldClose) {
      _dragAccum = 0;
      close();
      return;
    }

    final shouldFocus =
        _dragAccum < -_focusUpDistance || velocity < -_flingVelocity;
    _dragAccum = 0;
    dragOffset.value = 0; // snap back
    if (shouldFocus) focusComment();
  }

  /// Focus the comment input (opens the keyboard).
  void focusComment() => commentFocusNode.requestFocus();

  /// Close the viewer and return to the previous screen.
  void close() {
    if (_isClosing) return;
    _isClosing = true;
    Get.back();
  }

  /// Format large counts as "12k" / "129k".
  static String _compact(int n) {
    if (n >= 1000) return '${(n / 1000).round()}k';
    return '$n';
  }

  @override
  void onClose() {
    _timer?.cancel();
    commentController.dispose();
    commentFocusNode.dispose();
    super.onClose();
  }
}
