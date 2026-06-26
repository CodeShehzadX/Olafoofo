import 'package:get/get.dart';

import 'lounge_controller.dart';

/// A participant shown in the Live Lounge members grid.
class LoungeMember {
  const LoungeMember({
    required this.name,
    required this.role,
    required this.avatar,
  });

  final String name;

  /// e.g. "Listener" or "Speaking".
  final String role;

  final String avatar;
}

/// State for the Live Lounge bottom sheet (GetX reactive, no setState).
///
/// Dummy/local data only — no backend.
class LiveLoungeController extends GetxController {
  LiveLoungeController(this.lounge);

  /// The lounge that was tapped (provides the host name).
  final Lounge lounge;

  /// Host avatar asset.
  static const String hostImage = 'assets/images/host.png';

  /// Whether the lounge session is running (drives the Stop/Start button).
  final RxBool isRunning = true.obs;

  /// Microphone on/off (starts off — "Mic is off").
  final RxBool micOn = false.obs;

  /// Recording on/off.
  final RxBool recording = false.obs;

  String get hostName => lounge.hostName;

  /// 19 dummy members (member_1..19). One of them is currently speaking.
  final List<LoungeMember> members = List.generate(
    19,
    (i) => LoungeMember(
      name: 'Chris',
      role: i == 5 ? 'Speaking' : 'Listener',
      avatar: 'assets/images/member_${i + 1}.png',
    ),
  );

  /// Count shown in the trailing "+N listeners" cell.
  final int extraListeners = 20;

  /// Stop ↔ Start.
  void toggleRunning() => isRunning.toggle();

  /// Mic on ↔ off.
  void toggleMic() => micOn.toggle();

  /// Record on ↔ off.
  void toggleRecording() => recording.toggle();
}
