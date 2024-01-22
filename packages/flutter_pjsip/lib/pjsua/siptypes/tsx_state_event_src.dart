// Can't be imported as ffi because of generated code
import 'dart:ffi';

import 'package:flutter_pjsip/bindings/bindings.dart';
import 'package:flutter_pjsip/pjsua/pjsua.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsx_state_event_src.freezed.dart';

/// This structure describes transaction state event source.
@freezed
sealed class TsxStateEventSrc with _$TsxStateEventSrc {
  const factory TsxStateEventSrc({
    /// The incoming message.
    required SipRxData rdata,

    /// The outgoing message.
    required SipTxData tdata,

    /// The timer.
    required TimerEntry timer,

    /// Transport error status.
    required Dartpj_status_t status,

    /// Generic data.
    required GenericData data,
  }) = _TsxStateEventSrc;

  const factory TsxStateEventSrc.tdata({
    /// The outgoing message.
    required SipTxData tdata,
  }) = _TsxStateEventSrcTdata;

  const factory TsxStateEventSrc.rdata({
    /// The incoming message.
    required SipRxData rdata,
  }) = _TsxStateEventSrcRdata;

  const factory TsxStateEventSrc.status({
    /// Transport error status.
    required Dartpj_status_t status,
  }) = _TsxStateEventSrcStatus;

  const factory TsxStateEventSrc.timer({
    /// The timer.
    required TimerEntry timer,
  }) = _TsxStateEventSrcTimer;

  const factory TsxStateEventSrc.user({
    /// Generic data.
    required GenericData data,
  }) = _TsxStateEventSrcUser;
}
