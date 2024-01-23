import 'package:flutter_pjsip/pjsua/pjsua.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tx_error_event.freezed.dart';

/// This structure describes transmission error event.
@freezed
sealed class TxErrorEvent with _$TxErrorEvent {
  const factory TxErrorEvent({
    /// The transmit data.
    required SipTxData? tdata,

    /// The transaction.
    required SipTransaction? tsx,
  }) = _TxErrorEvent;
}
