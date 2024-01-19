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
  factory SipRxData.fromPj(pjsip_rx_data rdata) {
    return SipRxData(
      // TODO(nesquikm): pjsip_rx_data_get_info should be called from native!
      // info        = pjsip_rx_data_get_info(&rdata);
      info: '',
      wholeMsg: rdata.msg_info.msg_buf.toDartString(),
      // TODO(nesquikm): pj_sockaddr_print should be called from native!
      // char straddr[PJ_INET6_ADDRSTRLEN+10];
      // pj_sockaddr_print(&rdata.pkt_info.src_addr, straddr,
      // sizeof(straddr), 3);
      srcAddress: '',
    );
  }
}
