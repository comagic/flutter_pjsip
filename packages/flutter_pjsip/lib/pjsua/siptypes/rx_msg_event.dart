import 'package:flutter_pjsip/pjsua/pjsua.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rx_msg_event.freezed.dart';

/// This structure describes message arrival event.
@freezed
sealed class RxMsgEvent with _$RxMsgEvent {
  const factory RxMsgEvent({
    /// The receive data buffer.
    required SipRxData rdata,
  }) = _RxMsgEvent;
}
