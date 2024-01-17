import 'package:flutter_pjsip/bindings/bindings.dart';

/// This enumeration describes subset of standard activities as
/// described by RFC 4480, RPID: Rich Presence Extensions to the
/// Presence Information Data Format (PIDF).
enum PjrpidActivity {
  /// Activity is unknown. The activity would then be conceived
  /// in the "note" field.
  unknown,

  /// The person is away
  away,

  /// The person is busy
  busy;

  /// Convert from a native pjrpid_activity to a PjrpidActivity
  static PjrpidActivity fromInt(int cls) {
    switch (cls) {
      case pjrpid_activity.PJRPID_ACTIVITY_UNKNOWN:
        return unknown;
      case pjrpid_activity.PJRPID_ACTIVITY_AWAY:
        return away;
      case pjrpid_activity.PJRPID_ACTIVITY_BUSY:
        return busy;
      default:
        throw Exception('Unknown pjrpid_activity: $cls');
    }
  }

  /// Convert from a PjrpidActivity to a native pjrpid_activity
  int toInt() {
    switch (this) {
      case unknown:
        return pjrpid_activity.PJRPID_ACTIVITY_UNKNOWN;
      case away:
        return pjrpid_activity.PJRPID_ACTIVITY_AWAY;
      case busy:
        return pjrpid_activity.PJRPID_ACTIVITY_BUSY;
    }
  }
}
