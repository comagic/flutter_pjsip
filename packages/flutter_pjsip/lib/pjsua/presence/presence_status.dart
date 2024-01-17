import 'package:flutter_pjsip/pjsua/enums/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'presence_status.freezed.dart';

/// This describes presence status.
@freezed
sealed class PresenceStatus with _$PresenceStatus {
  const factory PresenceStatus({
    /// Buddy's online status.
    required PjsuaBuddyStatus status,

    /// Text to describe buddy's online status.
    required String statusText,

    /// Activity type.
    required PjrpidActivity activity,

    /// Optional text describing the person/element.
    required String note,

    /// Optional RPID ID string.
    required String rpidId,
  }) = _PresenceStatus;
}
