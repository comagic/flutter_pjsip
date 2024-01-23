import 'package:flutter_pjsip/bindings/bindings.dart';

/// Event IDs.
enum PjsipEventIdE {
  /// Unidentified event.
  unknown,

  /// Timer event, normally only used internally in transaction.
  timer,

  /// Message transmission event.
  txMsg,

  /// Message received event.
  rxMsg,

  /// Transport error event.
  transportError,

  /// Transaction state changed event.
  tsxState,

  /// Indicates that the event was triggered by user action.
  user;

  /// Convert from a native pjsip_event_id_e to a PjsipEventIdE
  static PjsipEventIdE fromInt(int cls) {
    switch (cls) {
      case pjsip_event_id_e.PJSIP_EVENT_UNKNOWN:
        return unknown;
      case pjsip_event_id_e.PJSIP_EVENT_TIMER:
        return timer;
      case pjsip_event_id_e.PJSIP_EVENT_TX_MSG:
        return txMsg;
      case pjsip_event_id_e.PJSIP_EVENT_RX_MSG:
        return rxMsg;
      case pjsip_event_id_e.PJSIP_EVENT_TRANSPORT_ERROR:
        return transportError;
      case pjsip_event_id_e.PJSIP_EVENT_TSX_STATE:
        return tsxState;
      case pjsip_event_id_e.PJSIP_EVENT_USER:
        return user;
      default:
        throw Exception('Unknown pjsip_event_id_e: $cls');
    }
  }

  /// Convert from a PjsipEventIdE to a native pjsip_event_id_e
  int toInt() {
    switch (this) {
      case unknown:
        return pjsip_event_id_e.PJSIP_EVENT_UNKNOWN;
      case timer:
        return pjsip_event_id_e.PJSIP_EVENT_TIMER;
      case txMsg:
        return pjsip_event_id_e.PJSIP_EVENT_TX_MSG;
      case rxMsg:
        return pjsip_event_id_e.PJSIP_EVENT_RX_MSG;
      case transportError:
        return pjsip_event_id_e.PJSIP_EVENT_TRANSPORT_ERROR;
      case tsxState:
        return pjsip_event_id_e.PJSIP_EVENT_TSX_STATE;
      case user:
        return pjsip_event_id_e.PJSIP_EVENT_USER;
    }
  }
}
