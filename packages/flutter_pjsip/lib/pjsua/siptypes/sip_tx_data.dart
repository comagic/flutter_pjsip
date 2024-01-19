import 'dart:ffi' as ffi;

import 'package:flutter_pjsip/bindings/bindings.dart';
import 'package:flutter_pjsip/pjsua/pjsua.dart';
import 'package:flutter_pjsip/pjsua/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sip_tx_data.freezed.dart';

/// This describes presence status.
@freezed
sealed class SipTxData with _$SipTxData {
  const factory SipTxData({
    /// A short info string describing the request, which normally contains
    /// the request method and its CSeq.
    required String info,

    /// The whole message data as a string, containing both the header section
    /// and message body section.
    required String wholeMsg,

    /// Destination address of the message.
    required SocketAddress dstAddress,
  }) = _SipTxData;

  /// Import from pjsip structure
  factory SipTxData.fromPj(ffi.Pointer<pjsip_tx_data> tdata) {
    const straddrBufLength = PJ_INET6_ADDRSTRLEN + 10;
    final straddr = PCExtension.allocate(straddrBufLength);

    final info = Pjsua.bindings.pjsip_tx_data_get_info(tdata).toDartString();

    Pjsua.bindings.pjsip_tx_data_encode(tdata);

    final wholeMsg = tdata.ref.buf.start
        .toDartString()
        .substring(0, tdata.ref.buf.cur.address - tdata.ref.buf.start.address);

    String dstAddress() {
      if (Pjsua.bindings
          .pj_sockaddr_has_addr(
            tdata.ref.tp_info.dst_addr as ffi.Pointer<pj_sockaddr_t>,
          )
          .toDartBool()) {
        Pjsua.bindings.pj_sockaddr_print(
          tdata.ref.tp_info.dst_addr as ffi.Pointer<pj_sockaddr_t>,
          straddr,
          straddrBufLength,
          3,
        );

        return straddr.toDartString();
      }

      return '';
    }

    return SipTxData(
      info: info,
      wholeMsg: wholeMsg,
      dstAddress: dstAddress(),
    );
  }
}
