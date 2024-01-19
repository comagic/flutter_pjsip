import 'package:flutter_pjsip/bindings/bindings.dart';

/// This enumeration represents transaction state.
enum PjsipTsxStateE {
  /// For UAC, before any message is sent.
  isNull,

  /// For UAC, just after request is sent.
  calling,

  /// For UAS, just after request is received.
  trying,

  /// For UAS/UAC, after provisional response.
  proceeding,

  /// For UAS/UAC, after final response.
  completed,

  /// For UAS, after ACK is received.
  confirmed,

  /// For UAS/UAC, before it's destroyed.
  terminated,

  /// For UAS/UAC, will be destroyed now.
  destroyed,

  /// Number of states.
  max;

  /// Convert from a native pjsip_tsx_state_e to a PjsipTsxStateE
  static PjsipTsxStateE fromInt(int cls) {
    switch (cls) {
      case pjsip_tsx_state_e.PJSIP_TSX_STATE_NULL:
        return isNull;
      case pjsip_tsx_state_e.PJSIP_TSX_STATE_CALLING:
        return calling;
      case pjsip_tsx_state_e.PJSIP_TSX_STATE_TRYING:
        return trying;
      case pjsip_tsx_state_e.PJSIP_TSX_STATE_PROCEEDING:
        return proceeding;
      case pjsip_tsx_state_e.PJSIP_TSX_STATE_COMPLETED:
        return completed;
      case pjsip_tsx_state_e.PJSIP_TSX_STATE_CONFIRMED:
        return confirmed;
      case pjsip_tsx_state_e.PJSIP_TSX_STATE_TERMINATED:
        return terminated;
      case pjsip_tsx_state_e.PJSIP_TSX_STATE_DESTROYED:
        return destroyed;
      case pjsip_tsx_state_e.PJSIP_TSX_STATE_MAX:
        return max;
      default:
        throw Exception('Unknown pjsip_tsx_state_e: $cls');
    }
  }

  /// Convert from a PjsipTsxStateE to a native pjsip_tsx_state_e
  int toInt() {
    switch (this) {
      case isNull:
        return pjsip_tsx_state_e.PJSIP_TSX_STATE_NULL;
      case calling:
        return pjsip_tsx_state_e.PJSIP_TSX_STATE_CALLING;
      case trying:
        return pjsip_tsx_state_e.PJSIP_TSX_STATE_TRYING;
      case proceeding:
        return pjsip_tsx_state_e.PJSIP_TSX_STATE_PROCEEDING;
      case completed:
        return pjsip_tsx_state_e.PJSIP_TSX_STATE_COMPLETED;
      case confirmed:
        return pjsip_tsx_state_e.PJSIP_TSX_STATE_CONFIRMED;
      case terminated:
        return pjsip_tsx_state_e.PJSIP_TSX_STATE_TERMINATED;
      case destroyed:
        return pjsip_tsx_state_e.PJSIP_TSX_STATE_DESTROYED;
      case max:
        return pjsip_tsx_state_e.PJSIP_TSX_STATE_MAX;
    }
  }
}
