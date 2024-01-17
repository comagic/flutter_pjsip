import 'dart:ffi';
import 'package:ffi/ffi.dart';

/// Extension methods for the `Pointer<Char>` type.
extension PCExtension on Pointer<Char> {
  /// Converts the `Pointer<Char>` instance to a Dart [String].
  String toDartString() {
    return cast<Utf8>().toDartString();
  }
}
