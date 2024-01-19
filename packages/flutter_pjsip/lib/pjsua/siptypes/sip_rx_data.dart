import 'dart:ffi' as ffi;

import 'package:flutter_pjsip/bindings/bindings.dart';
import 'package:flutter_pjsip/pjsua/pjsua.dart';
import 'package:flutter_pjsip/pjsua/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sip_rx_data.freezed.dart';

/// This describes presence status.
@freezed
sealed class SipRxData with _$SipRxData {
  const factory SipRxData({
    /// A short info string describing the request, which normally contains
    /// the request method and its CSeq.
    required String info,

    /// The whole message data as a string, containing both the header section
    /// and message body section.
    required String wholeMsg,

    /// Source address of the message.
    required SocketAddress srcAddress,
  }) = _SipRxData;

  /// Import from pjsip structure
  factory SipRxData.fromPj(ffi.Pointer<pjsip_rx_data> rdata) {
    const straddrBufLength = PJ_INET6_ADDRSTRLEN + 10;
    final straddr = PCExtension.allocate(straddrBufLength);

    final info = Pjsua.bindings.pjsip_rx_data_get_info(rdata).toDartString();

    final wholeMsg = rdata.ref.msg_info.msg_buf.toDartString();

    Pjsua.bindings.pj_sockaddr_print(
      rdata.ref.pkt_info.src_addr as ffi.Pointer<pj_sockaddr_t>,
      straddr,
      straddrBufLength,
      3,
    );

    final srcAddress = straddr.toDartString();

    return SipRxData(
      info: info,
      wholeMsg: wholeMsg,
      srcAddress: srcAddress,
    );
  }
}
