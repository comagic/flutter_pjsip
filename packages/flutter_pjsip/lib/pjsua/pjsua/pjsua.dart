import 'package:flutter_pjsip/bindings/bindings.dart';
import 'package:flutter_pjsip/pjsua/pjsua/lib_loader.dart';
import 'package:logging/logging.dart';

/// This class provides access to the PJSUA API for managing SIP calls and
/// sessions. It loads the native library and provides access to the native
/// functions.
class Pjsua {
  /// This is a static class, it cannot be instantiated.
  Pjsua._();

  static final _log = Logger('Pjsua');

  /// Returns the FlutterPjsipBindings object.
  ///
  /// The FlutterPjsipBindings object provides access to the bindings for the
  /// PJSUA library.
  ///
  /// Returns:
  ///   The [FlutterPjsipBindings] object.
  static FlutterPjsipBindings get bindings => LibLoader.bindings;

  // ============================================================
  // ========= All code below only for testing purposes =========
  // ============================================================

  /// A very short-lived native function.
  static int sum(int a, int b) => bindings.sum(a, b);

  // ignore: public_member_api_docs
  static void pjStart() {
    _log.fine('pjStart:');
    final a = bindings.pjsua_create();
    _log.fine('pjsua_create returns $a');
  }
}
