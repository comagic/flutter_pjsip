import 'package:flutter_pjsip/pjsua/pjsua.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsx_state_event.freezed.dart';

/// This structure describes transaction state changed event.
@freezed
sealed class TsxStateEvent with _$TsxStateEvent {
  const factory TsxStateEvent({
    /// Event source.
    required TsxStateEventSrc? src,

    /// The transaction.
    required SipTransaction tsx,

    /// Previous state.
    required PjsipTsxStateE prevState,

    /// Type of event source:
    /// - PJSIP_EVENT_TX_MSG
    /// - PJSIP_EVENT_RX_MSG,
    /// - PJSIP_EVENT_TRANSPORT_ERROR
    /// - PJSIP_EVENT_TIMER
    /// - PJSIP_EVENT_USER
    required PjsipEventIdE type,
  }) = _TsxStateEvent;
}
