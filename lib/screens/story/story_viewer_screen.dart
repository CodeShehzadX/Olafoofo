import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/story/story_viewer_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/user_avatar.dart';

class StoryViewerScreen extends GetView<StoryViewerController> {
  const StoryViewerScreen({super.key});

  static const Color _red = Color(0xFFEB5757);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // Swipe down to close, swipe up to focus the comment input.
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragUpdate: (d) => controller.onDragUpdate(d.delta.dy),
        onVerticalDragEnd: (d) => controller.onDragEnd(d.primaryVelocity ?? 0),
        child: Obx(
          () => Transform.translate(
            offset: Offset(0, controller.dragOffset.value),
            child: _content(),
          ),
        ),
      ),
    );
  }

  Widget _content() {
    return Stack(
      children: [
        // Full-screen story media (the exact selected/captured image).
        Positioned.fill(
          child: Obx(() {
            final media = controller.currentMedia;
            return media.isAsset
                ? Image.asset(media.path, fit: BoxFit.cover)
                : Image.file(File(media.path), fit: BoxFit.cover);
          }),
        ),
        // Top scrim for header readability
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 180,
          child: const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black54, Colors.transparent],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                child: _progressBar(),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _header(),
              ),
              const Spacer(),
              if (controller.isLive)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(child: _liveComments()),
                      const SizedBox(width: 8),
                      _liveActions(),
                    ],
                  ),
                ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: _commentInput(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _progressBar() {
    return Obx(
      () => Row(
        children: List.generate(controller.mediaCount, (i) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: i == controller.mediaCount - 1 ? 0 : 4,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Container(
                  height: 3,
                  color: Colors.white.withValues(alpha: 0.35),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor:
                          controller.segmentProgress(i).clamp(0.0, 1.0),
                      child: Container(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        UserAvatar(
          image: controller.avatar,
          size: 44,
          borderColor: Colors.white,
          borderWidth: 1.5,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      controller.username,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  if (controller.isLive) ...[
                    const SizedBox(width: 10),
                    _liveTag(),
                  ],
                ],
              ),
              const SizedBox(height: 2),
              if (controller.isLive)
                Row(
                  children: [
                    const Icon(
                      Icons.visibility_outlined,
                      size: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      controller.watchingText,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                )
              else
                Text(
                  '1hr ago',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: controller.close,
          child: const Icon(Icons.close, size: 28, color: Colors.white),
        ),
      ],
    );
  }

  Widget _liveTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _red,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        'LIVE',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _liveComments() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final comment in controller.liveComments)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.username,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  comment.text,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _liveActions() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: controller.toggleLike,
          child: Obx(
            () => SvgPicture.asset(
              'assets/icons/Heart.svg',
              height: 36,
              colorFilter: ColorFilter.mode(
                controller.isLiked.value ? _red : Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Obx(
          () => Text(
            controller.likeText,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SvgPicture.asset(
          'assets/icons/Chat.svg',
          height: 30,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        const SizedBox(height: 4),
        Text(
          controller.commentText,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _commentInput() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: controller.commentController,
        focusNode: controller.commentFocusNode,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(fontSize: 16, color: AppColors.blackText),
        decoration: const InputDecoration(
          isCollapsed: true,
          filled: false,
          fillColor: Colors.transparent,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: 'Type a comment',
          hintStyle: TextStyle(color: AppColors.textHint, fontSize: 16),
        ),
      ),
    );
  }
}
