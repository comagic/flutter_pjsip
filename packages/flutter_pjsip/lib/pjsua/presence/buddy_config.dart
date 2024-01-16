import 'package:freezed_annotation/freezed_annotation.dart';

part 'buddy_config.freezed.dart';
part 'buddy_config.g.dart';

/// This structure describes buddy configuration when adding a buddy to
/// the buddy list with Buddy::create().
@freezed
sealed class BuddyConfig with _$BuddyConfig {
  const factory BuddyConfig({
    /// Buddy URL or name address.
    required String uri,

    /// Specify whether presence subscription should start immediately.
    required bool subscribe,
  }) = _BuddyConfig;

  factory BuddyConfig.fromJson(Map<String, Object?> json) =>
      _$BuddyConfigFromJson(json);
}
