import 'package:flutter_pjsip/bindings/bindings.dart';

/// This enumeration describes basic buddy's online status.
enum PjsuaBuddyStatus {
  /// Online status is unknown (possibly because no presence subscription
  /// has been established).
  unknown,

  /// Buddy is known to be online.
  online,

  /// Buddy is offline.
  offline;

  /// Convert from a native pjsua_buddy_status to a PjsuaBuddyStatus
  static PjsuaBuddyStatus fromInt(int cls) {
    switch (cls) {
      case pjsua_buddy_status.PJSUA_BUDDY_STATUS_UNKNOWN:
        return unknown;
      case pjsua_buddy_status.PJSUA_BUDDY_STATUS_ONLINE:
        return online;
      case pjsua_buddy_status.PJSUA_BUDDY_STATUS_OFFLINE:
        return offline;
      default:
        throw Exception('Unknown pjsua_buddy_status: $cls');
    }
  }

  /// Convert from a PjsuaBuddyStatus to a native pjsua_buddy_status
  int toInt() {
    switch (this) {
      case unknown:
        return pjsua_buddy_status.PJSUA_BUDDY_STATUS_UNKNOWN;
      case online:
        return pjsua_buddy_status.PJSUA_BUDDY_STATUS_ONLINE;
      case offline:
        return pjsua_buddy_status.PJSUA_BUDDY_STATUS_OFFLINE;
    }
  }
}
