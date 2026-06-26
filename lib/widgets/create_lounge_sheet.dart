import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/lounge/create_lounge_controller.dart';
import '../utils/app_colors.dart';
import 'custom_button.dart';
import 'custom_textfield.dart';
import 'sheet_drag_handle.dart';

/// The Create Lounge modal bottom sheet — Figma page 24.
///
/// Opened via [CreateLoungeSheet.show]; dismisses by swipe-down, tap-outside or
/// back button (the standard modal bottom sheet behaviour).
///
/// It is a [StatefulWidget] purely to own its [CreateLoungeController]'s
/// lifecycle — a FRESH controller is created in [initState] on every open and
/// disposed in [dispose] (after the sheet has fully unmounted). This avoids the
/// "TextEditingController used after being disposed" crash that a shared
/// Get.put/Get.delete instance caused on reopen. No setState is used; the UI
/// stays reactive via [Obx].
class CreateLoungeSheet extends StatefulWidget {
  const CreateLoungeSheet({super.key});

  /// Present the sheet as a standard modal bottom sheet.
  static Future<void> show() {
    return Get.bottomSheet(
      const CreateLoungeSheet(),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      // Defaults already enable swipe-down (enableDrag) and tap-outside
      // (isDismissible) dismissal; the back button pops the sheet route.
    );
  }

  @override
  State<CreateLoungeSheet> createState() => _CreateLoungeSheetState();
}

class _CreateLoungeSheetState extends State<CreateLoungeSheet> {
  late final CreateLoungeController controller;

  @override
  void initState() {
    super.initState();
    controller = CreateLoungeController();
  }

  @override
  void dispose() {
    // Disposes the text controllers — runs only once the sheet is fully gone.
    controller.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          // Pad the scrollable content by the keyboard height so the focused
          // field lifts above the keyboard and the form stays scrollable —
          // without reflowing/disturbing the layout.
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SheetDragHandle(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create a lounge',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackText,
                      ),
                    ),
                    const SizedBox(height: 24),

                    _label('Name'),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      controller: controller.nameController,
                      text: '',
                      onChange: controller.onFieldChanged,
                      borderColor: AppColors.splashCircle,
                      filledColor: Colors.white,
                      borderRadius: 14,
                      contentPadding: 20,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),

                    _label('Description'),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      controller: controller.descriptionController,
                      text: 'What do u want to talk about',
                      onChange: controller.onFieldChanged,
                      filledColor: AppColors.lightGray,
                      borderRadius: 14,
                      contentPadding: 18,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 28),

                    Obx(
                      () => CustomButton(
                        height: 56,
                        margin: 0,
                        borderRadius: 14,
                        title: 'Create',
                        titleFontSize: 18,
                        fontWeight: FontWeight.w700,
                        backgroundColor: AppColors.splashCircle,
                        textColor: Colors.white,
                        disabled: !controller.canCreate.value,
                        onTap: controller.create,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.blackText,
      ),
    );
  }
}
