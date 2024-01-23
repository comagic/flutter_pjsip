import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart' as ffipkg;

/// Extension methods for the `Pointer<Char>` type.
extension PCExtension on ffi.Pointer<ffi.Char> {
  /// Converts the `Pointer<Char>` instance to a Dart [String].
  String toDartString() {
    return cast<ffipkg.Utf8>().toDartString();
  }

  /// Converts a Dart string to a pointer to a C-style string.
  ///
  /// WARNING: this method allocates memory for the pointer to a character.
  /// You must call the [free] method to free the allocated memory.
  static ffi.Pointer<ffi.Char> fromDartString(String inputString) {
    return inputString.toNativeUtf8().cast();
  }

  /// Returns the length of the specified UTF-8 string.
  static int nativeUtf8Length(String inputString) {
    return inputString.toNativeUtf8().length;
  }

  /// Allocates a pointer to a character with the specified length.
  ///
  /// WARNING: this method allocates memory for the pointer to a character.
  /// You must call the [free] method to free the allocated memory.
  /// The [length] parameter specifies the number of characters to allocate.
  /// Returns a pointer to the allocated character.
  static ffi.Pointer<ffi.Char> allocate(int length) {
    return ffipkg.calloc<ffi.Char>(length + 1);
  }

  /// Frees the memory allocated for the pointer to a character.
  void free() {
    ffipkg.calloc.free(this);
  }
}
