import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/validators.dart';
import '../../widgets/custom_snackbar.dart';

/// Business logic + state for the Create Lounge bottom sheet (GetX, no setState).
///
/// Dummy/local data only — no backend.
class CreateLoungeController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  /// True once both required fields are valid (drives the Create button).
  final RxBool canCreate = false.obs;

  /// Re-evaluate the required fields. Wired to each field's onChange.
  void onFieldChanged([String? _]) {
    canCreate.value = Validators.required(nameController.text.trim()) == null &&
        Validators.required(descriptionController.text.trim()) == null;
  }

  /// Create the lounge (dummy) and dismiss the sheet.
  void create() {
    if (!canCreate.value) return;
    // TODO: persist the new lounge once a backend/list insert is defined.
    Get.back();
    CustomSnackbar.success(
      title: 'Lounge created',
      message: 'Your Ofofo is ready to go.',
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
