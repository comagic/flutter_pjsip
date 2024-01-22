import 'dart:ffi';
import 'package:ffi/ffi.dart';

/// Extension methods for the `Pointer<Char>` type.
extension PCExtension on Pointer<Char> {
  /// Converts the `Pointer<Char>` instance to a Dart [String].
  String toDartString() {
    return cast<Utf8>().toDartString();
  }

  /// Converts a Dart string to a pointer to a C-style string.
  ///
  /// WARNING: this method allocates memory for the pointer to a character.
  /// You must call the [free] method to free the allocated memory.
  static Pointer<Char> fromDartString(String inputString) {
    return inputString.toNativeUtf8().cast();
  }

  /// Allocates a pointer to a character with the specified length.
  ///
  /// WARNING: this method allocates memory for the pointer to a character.
  /// You must call the [free] method to free the allocated memory.
  /// The [length] parameter specifies the number of characters to allocate.
  /// Returns a pointer to the allocated character.
  static Pointer<Char> allocate(int length) {
    return calloc<Char>(length + 1);
  }

  /// Frees the memory allocated for the pointer to a character.
  void free() {
    calloc.free(this);
  }
}
