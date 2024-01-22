import 'package:flutter_pjsip/pjsua/pjsua.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tx_msg_event.freezed.dart';

/// This structure describes message transmission event.
@freezed
sealed class TxMsgEvent with _$TxMsgEvent {
  const factory TxMsgEvent({
    /// The transmit data buffer.
    required SipTxData rdata,
  }) = _TxMsgEvent;
}
