import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/lounge/live_lounge_controller.dart';
import '../controllers/lounge/lounge_controller.dart';
import '../utils/app_colors.dart';
import 'custom_button.dart';
import 'sheet_drag_handle.dart';
import 'user_avatar.dart';

/// The Live Lounge modal bottom sheet — Figma page 25.
///
/// Opened via [LiveLoungeSheet.show] when an Ofofo card is tapped. The dimmed
/// Lounge screen shows behind it (the default bottom-sheet scrim). Reactive via
/// [Obx]; no setState. Owns its [LiveLoungeController] in [State] so a fresh one
/// is created per open.
class LiveLoungeSheet extends StatefulWidget {
  const LiveLoungeSheet({super.key, required this.lounge});

  final Lounge lounge;

  /// Present the sheet for [lounge].
  static Future<void> show(Lounge lounge) {
    return Get.bottomSheet(
      LiveLoungeSheet(lounge: lounge),
      backgroundColor: Colors.white,
      isScrollControlled: true,
    );
  }

  @override
  State<LiveLoungeSheet> createState() => _LiveLoungeSheetState();
}

class _LiveLoungeSheetState extends State<LiveLoungeSheet> {
  late final LiveLoungeController controller;

  @override
  void initState() {
    super.initState();
    controller = LiveLoungeController(widget.lounge);
  }

  @override
  void dispose() {
    // Runs the controller's cleanup once the sheet is fully gone — consistent
    // with CreateLoungeSheet, so any disposables added later are released.
    controller.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.sizeOf(context).height * 0.9;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SheetDragHandle(),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _hostSection(),
                      const SizedBox(height: 24),
                      _membersGrid(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                child: Obx(
                  () => CustomButton(
                    height: 56,
                    margin: 0,
                    borderRadius: 14,
                    title: controller.isRunning.value ? 'Stop' : 'Start',
                    titleFontSize: 18,
                    fontWeight: FontWeight.w700,
                    backgroundColor: AppColors.splashCircle,
                    textColor: Colors.white,
                    onTap: controller.toggleRunning,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Host avatar centered, with the mic + record controls at the top-right.
  Widget _hostSection() {
    return Stack(
      children: [
        Center(
          child: Column(
            children: [
              UserAvatar(image: LiveLoungeController.hostImage, size: 64),
              const SizedBox(height: 10),
              Text(
                controller.hostName,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackText,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Host',
                style: TextStyle(fontSize: 13, color: AppColors.textHint),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Mic toggle — speaker/volume icon.
              Obx(
                () => _controlButton(
                  icon:
                      controller.micOn.value
                          ? Icons.volume_up
                          : Icons.volume_off,
                  label: controller.micOn.value ? 'Mic is on' : 'Mic is off',
                  background: AppColors.splashCircle,
                  onTap: controller.toggleMic,
                ),
              ),
              const SizedBox(width: 16),
              // Record toggle — mic icon.
              Obx(
                () => _controlButton(
                  icon: Icons.mic,
                  label: controller.recording.value ? 'Recording' : 'Record',
                  background:
                      controller.recording.value
                          ? AppColors.error
                          : AppColors.splashCircle,
                  onTap: controller.toggleRecording,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _controlButton({
    required IconData icon,
    required String label,
    required Color background,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: background,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.textHint),
          ),
        ],
      ),
    );
  }

  /// 4-column members grid; the trailing cell is the "+N listeners" label.
  Widget _membersGrid() {
    const int columns = 4;
    final int total =
        controller.members.length + 1; // + the "+N listeners" cell
    final int rows = (total / columns).ceil();

    return Column(
      children: [
        for (int r = 0; r < rows; r++)
          Padding(
            padding: EdgeInsets.only(bottom: r == rows - 1 ? 0 : 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int c = 0; c < columns; c++)
                  Expanded(child: _cell(r * columns + c)),
              ],
            ),
          ),
      ],
    );
  }

  /// Builds the cell at flat [index]: a member, the trailing listeners label,
  /// or an empty filler for any cell past the last item.
  Widget _cell(int index) {
    final members = controller.members;
    if (index < members.length) {
      final member = members[index];
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserAvatar(image: member.avatar, size: 34),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackText,
                  ),
                ),
                Text(
                  member.role,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
    if (index == members.length) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '+${controller.extraListeners} listeners',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.blackText,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
