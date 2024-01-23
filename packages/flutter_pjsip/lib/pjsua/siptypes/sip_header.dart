import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart' as ffipkg;

import 'package:flutter_pjsip/bindings/bindings.dart';
import 'package:flutter_pjsip/pjsua/pjsua/pjsua.dart';
import 'package:flutter_pjsip/pjsua/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sip_header.freezed.dart';

/// Simple SIP header.
@freezed
sealed class SipHeader with _$SipHeader {
  const factory SipHeader({
    /// The header name.
    required String name,

    /// The header value.
    required String value,
  }) = _SipHeader;

  const SipHeader._();

  /// Import from pjsip structure
  factory SipHeader.fromPj(ffi.Pointer<pjsip_hdr> hdr) {
    var len = 0;
    ffi.Pointer<ffi.Char> buf = ffi.nullptr;

    for (var bufSize = 256;
        (bufSize < PJSIP_MAX_PKT_LEN) && (len < 0);
        bufSize *= 2) {
      buf = PCExtension.allocate(bufSize);

      if (buf == ffi.nullptr) {
        throw Exception('Cannot allocate memory');
      }

      len = Pjsua.bindings.pjsip_hdr_print_on(
        hdr as ffi.Pointer<ffi.Void>,
        buf,
        bufSize - 1,
      );

      if (len < 0) {
        buf.free();
      }
    }

    if (len < 0) {
      throw Exception(
        'Cannot print header because PJSIP_MAX_PKT_LEN is too small',
      );
    }

    final originalBuf = buf.toDartString();
    buf.free();

    final pos = originalBuf.indexOf(':');
    if (pos < 0) {
      throw Exception('Cannot find ":" in header');
    }

    final name = originalBuf.substring(0, pos).trim();
    final value = originalBuf.substring(pos + 1).trim();

    return SipHeader(
      name: name,
      value: value,
    );
  }

  /// Export to pjsip structure
  /// WARNING: The returned pointer and its content will be freed manually
  ffi.Pointer<pjsip_generic_string_hdr> toPj() {
    final pjHdr = ffipkg.calloc.allocate<pjsip_generic_string_hdr>(
      ffi.sizeOf<pjsip_generic_string_hdr>(),
    );

    final hname = PjStrTExtension.fromDartString(name);
    final hvalue = PjStrTExtension.fromDartString(value);

    Pjsua.bindings.pjsip_generic_string_hdr_init2(pjHdr, hname, hvalue);

    return pjHdr;
  }
}
