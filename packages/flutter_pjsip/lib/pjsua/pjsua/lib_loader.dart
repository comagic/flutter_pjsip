import 'dart:ffi';
import 'dart:io';
import 'package:flutter_pjsip/bindings/bindings.dart';
import 'package:logging/logging.dart';

/// A class responsible for loading the PJSUA library.
class LibLoader {
  /// This is a static class, it cannot be instantiated.
  LibLoader._();

  static final _log = Logger('LibLoader');

  static const String _libName = 'flutter_pjsip';

  static FlutterPjsipBindings? _bindings;

  /// Returns the FlutterPjsipBindings object.
  ///
  /// The FlutterPjsipBindings object provides access to the bindings for the
  /// PJSUA native library.
  ///
  /// Returns:
  ///   The [FlutterPjsipBindings] object.
  static FlutterPjsipBindings get bindings {
    if (_bindings == null) {
      _log.fine('Loading $_libName library...');

      DynamicLibrary dylib;
      final start = DateTime.now();

      try {
        dylib = () {
          if (Platform.isMacOS || Platform.isIOS) {
            return DynamicLibrary.open('$_libName.framework/$_libName');
          }
          if (Platform.isAndroid || Platform.isLinux) {
            return DynamicLibrary.open('lib$_libName.so');
          }
          if (Platform.isWindows) {
            return DynamicLibrary.open('$_libName.dll');
          }
          throw UnsupportedError(
            'Unknown platform: ${Platform.operatingSystem}',
          );
        }();
      } catch (e) {
        _log.shout('Failed to load $_libName library: $e');
        rethrow;
      }

      final elapsed = DateTime.now().difference(start);

      _log.fine('Library loaded, took ${elapsed.inMilliseconds} ms');
      _bindings = FlutterPjsipBindings(dylib);
    }

    return _bindings!;
  }
}
