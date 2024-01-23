import 'package:flutter_pjsip/pjsua/pjsua.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sip_event_body.freezed.dart';

/// The event body.
@freezed
sealed class SipEventBody with _$SipEventBody {
  const factory SipEventBody({
    /// Timer event.
    required TimerEvent timer,

    /// Transaction state has changed event.
    required TsxStateEvent tsxState,

    /// Message transmission event.
    required TxMsgEvent txMsg,

    /// Transmission error event.
    required TxErrorEvent txError,

    /// Message arrival event.
    required RxMsgEvent rxMsg,

    /// User event.
    required UserEvent user,
  }) = _SipEventBody;

  const factory SipEventBody.timer({
    /// Timer event.
    required TimerEvent timer,
  }) = _SipEventBodyTimer;

  const factory SipEventBody.tsxState({
    /// Transaction state has changed event.
    required TsxStateEvent tsxState,
  }) = _SipEventBodyTsxState;

  const factory SipEventBody.txMsg({
    /// Message transmission event.
    required TxMsgEvent txMsg,
  }) = _SipEventBodyTxMsg;

  const factory SipEventBody.rxMsg({
    /// Message arrival event.
    required RxMsgEvent rxMsg,
  }) = _SipEventBodyRxMsg;

  const factory SipEventBody.txError({
    /// Transmission error event.
    required TxErrorEvent txError,
  }) = _SipEventBodyTxError;

  const factory SipEventBody.user({
    /// User event.
    required UserEvent user,
  }) = _SipEventBodyUser;
}
