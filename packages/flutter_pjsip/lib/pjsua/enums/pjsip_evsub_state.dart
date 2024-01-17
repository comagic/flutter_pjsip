import 'package:flutter_pjsip/bindings/bindings.dart';

/// This enumeration describes basic subscription state as described in the
/// RFC 3265. The standard specifies that extensions may define additional
/// states. In the case where the state is not known, the subscription state
/// will be set to PJSIP_EVSUB_STATE_UNKNOWN, and the token will be kept
/// in state_str member of the susbcription structure.
enum PjsipEvsubState {
  /// State is NULL.
  isNull,

  /// Client has sent SUBSCRIBE request.
  sent,

  /// 2xx response to SUBSCRIBE has been
  /// sent/received.
  accepted,

  /// Subscription is pending.
  pending,

  /// Subscription is active.
  active,

  /// Subscription is terminated.
  terminated,

  /// Subscription state can not be determined.
  /// Application can query the state by
  /// calling #pjsip_evsub_get_state_name().
  unknown;

  /// Convert from a native pjsip_evsub_state to a PjsipEvsubState
  static PjsipEvsubState fromInt(int cls) {
    switch (cls) {
      case pjsip_evsub_state.PJSIP_EVSUB_STATE_NULL:
        return isNull;
      case pjsip_evsub_state.PJSIP_EVSUB_STATE_SENT:
        return sent;
      case pjsip_evsub_state.PJSIP_EVSUB_STATE_ACCEPTED:
        return accepted;
      case pjsip_evsub_state.PJSIP_EVSUB_STATE_PENDING:
        return pending;
      case pjsip_evsub_state.PJSIP_EVSUB_STATE_ACTIVE:
        return active;
      case pjsip_evsub_state.PJSIP_EVSUB_STATE_TERMINATED:
        return terminated;
      case pjsip_evsub_state.PJSIP_EVSUB_STATE_UNKNOWN:
        return unknown;
      default:
        throw Exception('Unknown pjsip_evsub_state: $cls');
    }
  }

  /// Convert from a PjsipEvsubState to a native pjsip_evsub_state
  int toInt() {
    switch (this) {
      case isNull:
        return pjsip_evsub_state.PJSIP_EVSUB_STATE_NULL;
      case sent:
        return pjsip_evsub_state.PJSIP_EVSUB_STATE_SENT;
      case accepted:
        return pjsip_evsub_state.PJSIP_EVSUB_STATE_ACCEPTED;
      case pending:
        return pjsip_evsub_state.PJSIP_EVSUB_STATE_PENDING;
      case active:
        return pjsip_evsub_state.PJSIP_EVSUB_STATE_ACTIVE;
      case terminated:
        return pjsip_evsub_state.PJSIP_EVSUB_STATE_TERMINATED;
      case unknown:
        return pjsip_evsub_state.PJSIP_EVSUB_STATE_UNKNOWN;
    }
  }
}
