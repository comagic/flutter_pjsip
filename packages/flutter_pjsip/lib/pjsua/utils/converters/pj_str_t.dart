import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

import 'package:flutter_pjsip/bindings/bindings.dart';

/// Extension methods for the `pj_str_t` structure.
extension PjStrTExtension on pj_str_t {
  /// Converts the `pj_str_t` instance to a Dart [String].
  ///
  /// If the length of the string (`slen`) is greater than 0, it converts
  /// the string from UTF-8 to a Dart [String] and returns it.
  /// If the length of the string is 0 or less, it returns an empty [String].
  String toDartString() {
    if (slen > 0) {
      return ptr.cast<Utf8>().toDartString();
    }

    return '';
  }

  /// Creates a `pj_str_t` instance from a Dart [String].
  ///
  /// WARNING: this method allocates memory for the `pj_str_t` instance and its
  /// `ptr` field. You must call the [free] method to free the allocated memory.
  /// This method first converts the input [String] to a native UTF-8 string.
  /// Then, it allocates memory for a `pj_str_t` instance and sets its `ptr`
  /// field to point to the UTF-8 string and its `slen` field to the length
  /// of the UTF-8 string.
  /// Finally, it returns the `pj_str_t` instance.
  static pj_str_t fromDartString(String inputString) {
    final utf8prt = inputString.toNativeUtf8();

    final str = malloc.allocate<pj_str_t>(ffi.sizeOf<pj_str_t>());
    str.ref.ptr = utf8prt.cast();
    str.ref.slen = utf8prt.length;
    return str.ref;
  }

  /// Frees the memory allocated for the `pj_str_t` instance and its `ptr`
  /// field.
  void free() {
    malloc.free(ptr);
    // TODO(nesquikm): I have no idea how to free the memory allocated for the
    // `pj_str_t` instance itself. As long as we don't have a way to store the
    // allocated Pointer<> in the pj_str_t instance (only str.ref), we can't
    // free it.
    // ..free(this);
  }
}
