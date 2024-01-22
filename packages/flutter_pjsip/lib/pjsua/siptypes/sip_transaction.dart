import 'dart:ffi' as ffi;

import 'package:flutter_pjsip/bindings/bindings.dart';
import 'package:flutter_pjsip/pjsua/pjsua.dart';
import 'package:flutter_pjsip/pjsua/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sip_transaction.freezed.dart';

/// This structure describes SIP transaction object. It corresponds to the
/// [pjsip_transaction] structure in PJSIP library.
@freezed
sealed class SipTransaction with _$SipTransaction {
  const factory SipTransaction({
    /// Transaction identification.
    /// Role (UAS or UAC).
    required PjsipRoleE role,

    /// Transaction identification.
    /// The method.
    required String method,

    /// State and status.
    /// Last status code seen.
    required int statusCode,

    /// State and status.
    /// Last reason phrase.
    required String statusText,

    /// State and status.
    /// State.
    required PjsipTsxStateE state,

    /// Messages and timer.
    required SipTxData? lastTx,
  }) = _SipTransaction;

  /// Import from pjsip structure
  factory SipTransaction.fromPj(ffi.Pointer<pjsip_transaction> tsx) {
    final role = PjsipRoleE.fromInt(tsx.ref.role);
    final method = tsx.ref.method.name.toDartString();
    final statusCode = tsx.ref.status_code;
    final statusText = tsx.ref.status_text.toDartString();
    final state = PjsipTsxStateE.fromInt(tsx.ref.state);
    final lastTx = tsx.ref.last_tx != ffi.nullptr
        ? SipTxData.fromPj(tsx.ref.last_tx)
        : null;

    return SipTransaction(
      role: role,
      method: method,
      statusCode: statusCode,
      statusText: statusText,
      state: state,
      lastTx: lastTx,
    );
  }
}
