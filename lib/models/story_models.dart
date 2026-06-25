/// A single piece of story media (image).
///
/// [path] is either an asset path ('assets/...') or a device file path
/// returned by image_picker.
class StoryMedia {
  const StoryMedia(this.path);

  final String path;

  /// True if [path] points to a bundled asset (vs a captured/picked file).
  bool get isAsset => path.startsWith('assets/');
}

/// A user's story "group": one row item in the stories list that holds all of
/// that user's media. The first group belongs to the current user.
class StoryGroup {
  StoryGroup({
    required this.username,
    required this.avatar,
    required this.media,
    this.isCurrentUser = false,
    this.isLive = false,
    this.watching = 0,
  });

  final String username;
  final String avatar;
  final bool isCurrentUser;
  final bool isLive;
  final int watching;

  /// All media for this user (mutable so new uploads append here).
  final List<StoryMedia> media;

  bool get hasMedia => media.isNotEmpty;

  /// The thumbnail shown in the row — the latest media.
  StoryMedia? get cover => media.isEmpty ? null : media.last;
}

/// Arguments passed to the Story Viewer: which group and where to start.
class StoryViewerArgs {
  const StoryViewerArgs({required this.group, this.startIndex = 0});

  final StoryGroup group;
  final int startIndex;
}
