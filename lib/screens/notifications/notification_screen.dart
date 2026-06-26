import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/notifications/notification_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/back_title_app_bar.dart';
import '../../widgets/notification_tile.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.lightSystemOverlay(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              BackTitleAppBar(
                title: 'Notifications',
                onBack: controller.onBack,
                trailing: _clearButton(),
              ),
              Expanded(
                child: Obx(
                  () =>
                      controller.isEmpty
                          ? const _EmptyState()
                          : ListView(
                            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                            children: [
                              for (final section in controller.sections) ...[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 12,
                                    bottom: 4,
                                  ),
                                  child: Text(
                                    section.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.blackText,
                                    ),
                                  ),
                                ),
                                for (final item in section.items)
                                  NotificationTile(item: item),
                              ],
                            ],
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _clearButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: controller.clearAll,
      child: SizedBox(
        width: 40,
        height: 40,
        child: Center(
          child: SvgPicture.asset(
            'assets/icons/notifcation_delete.svg',
            height: 22,
            colorFilter: const ColorFilter.mode(
              AppColors.blackText,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No notifications yet',
        style: TextStyle(fontSize: 15, color: AppColors.textHint),
      ),
    );
  }
}
