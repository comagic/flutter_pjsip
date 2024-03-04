import 'dart:ffi';
import 'dart:io';

import 'package:assemblyai_flutter_sdk/assemblyai_flutter_sdk.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter_pjsip/bindings/bindings.dart';
import 'package:flutter_pjsip/pjsua/pjsua/lib_loader.dart';
import 'package:logging/logging.dart';

import '../utils/converters/pj_str_t.dart';

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

  static void log(int level, String msg) {
    _log.fine('log: $level $msg');
  }

  static void callback(int i, Pointer<Char> ptr, int i2) {
    _log.fine('Level $i: ${ptr.cast<Utf8>().toDartString()} $i2');
  }

  static final id = calloc<Int>();

  static void onCallState(int callId, Pointer<pjsip_event> e) {
    final ci = calloc<pjsua_call_info>();
    bindings.pjsua_call_get_info(callId, ci);
    final callState = ci.ref.state_text.toDartString();
    _log.fine('onCallState: ${callId} ${callState}');
    if (callState == 'DISCONNECTED' || callState == '') {
      final status = bindings.pjsua_recorder_destroy(id.value);
      if (status == pj_constants_.PJ_SUCCESS) {
        _log.fine('Recorder destroy success: $status');
      } else {
        _log.fine('Recorder destroy failed: $status');
      }
      File file = File("test_file.wav");
      print("Stopped recording, file size: ${file.lengthSync()}");
    }
  }

  static void onCallMediaState(int callId) {
    final ci = calloc<pjsua_call_info>();
    bindings.pjsua_call_get_info(callId, ci);
    if (ci.ref.media_status ==
        pjsua_call_media_status.PJSUA_CALL_MEDIA_ACTIVE) {
      bindings.pjsua_conf_connect(ci.ref.conf_slot, 0);
      bindings.pjsua_conf_connect(0, ci.ref.conf_slot);
      final file_name = PjStrTExtension.fromDartString("test_file.wav");
      bindings.pjsua_recorder_create(file_name, 0, nullptr, -1, 0, id);
      final recordPort = bindings.pjsua_recorder_get_conf_port(id.value);
      bindings.pjsua_conf_connect(ci.ref.conf_slot, recordPort);
      bindings.pjsua_conf_connect(0, recordPort);
      File file = File("test_file.wav");
      final api = AssemblyAI('2114e8770c0b462c920b593cb943774d');
      final channel = api.getRealtimeChannel(16000);
      file.openRead().listen((data) {
        print('Recording data: $data');
        channel.sink.add(data);
      });
      channel.stream.listen((event) {
        print(event.toString());
      });
      _log.fine('Recording started');
    }
  }

  // ignore: public_member_api_docs
  static void pjCreate() {
    _log.fine('pjCreate:');
    final a = bindings.pjsua_create();
    _log.fine('pjsua_create returns $a');

    // pjInit
    final pjsuaConfig = calloc<pjsua_config>();
    bindings.pjsua_config_default(pjsuaConfig);
    pjsuaConfig.ref.user_agent =
        PjStrTExtension.fromDartString('FlutterPjsip').ref;
    pjsuaConfig.ref.cb.on_call_media_state =
        NativeCallable<Void Function(Int)>.listener(onCallMediaState)
            .nativeFunction;
    pjsuaConfig.ref.cb.on_call_state =
        NativeCallable<Void Function(Int, Pointer<pjsip_event>)>.listener(
                onCallState)
            .nativeFunction;
    final pjsuaLoggingConfig = calloc<pjsua_logging_config>();
    bindings.pjsua_logging_config_default(pjsuaLoggingConfig);
    pjsuaLoggingConfig.ref.console_level = 4;
    const cb = callback;
    //pjsuaLoggingConfig.ref.cb = Pointer.fromFunction(cb);
    _log.fine('pjInit:');
    final a2 = bindings.pjsua_init(pjsuaConfig, pjsuaLoggingConfig, nullptr);
    _log.fine('pjsua_init returns $a2');
    final pjsuaTransportConfig = calloc<pjsua_transport_config>();
    bindings.pjsua_transport_config_default(pjsuaTransportConfig);
    pjsuaTransportConfig.ref.port = 6000;
    final status = bindings.pjsua_transport_create(
        pjsip_transport_type_e.PJSIP_TRANSPORT_UDP,
        pjsuaTransportConfig,
        nullptr);
    if (status != pj_constants_.PJ_SUCCESS) {
      _log.fine("Error creating transport: $status");
    }
    _log.fine('pjsua_transport_create returns $status');

    // pjStart
    _log.fine('pjStart:');
    final a3 = bindings.pjsua_start();
    _log.fine('pjsua_start returns $a3');

    // pjRegister
    final accId = calloc<pjsua_acc_id>();
    final pjsuaAccConfig = calloc<pjsua_acc_config>();
    bindings.pjsua_acc_config_default(pjsuaAccConfig);
    String sipUser = "777z3igqba";
    String sipDomain = "fpbx.de";
    String sipPasswd = "bmFVbMMbPapJ";
    // Setting account ID
    pjsuaAccConfig.ref.id =
        PjStrTExtension.fromDartString("Leon <sip:$sipUser@$sipDomain>").ref;

    //final proxy = PjStrTExtension.fromDartString("fpbx.de").ref;
    //pjsuaAccConfig.ref.proxy[0] = proxy.ptr.value;

    // Setting registrar URI
    pjsuaAccConfig.ref.reg_uri =
        PjStrTExtension.fromDartString("sip:$sipDomain").ref;

    //pjsuaAccConfig.ref.srtp_secure_signaling = 0;
    //pjsuaAccConfig.ref.use_srtp = pjmedia_srtp_use.PJMEDIA_SRTP_DISABLED;
    pjsuaAccConfig.ref.cred_count = 1;
    pjsuaAccConfig.ref.cred_info[0].realm =
        PjStrTExtension.fromDartString(sipDomain).ref;
    pjsuaAccConfig.ref.cred_info[0].scheme =
        PjStrTExtension.fromDartString("digest").ref;
    pjsuaAccConfig.ref.cred_info[0].username =
        PjStrTExtension.fromDartString(sipUser).ref;
    pjsuaAccConfig.ref.cred_info[0].data_type = 0;
    pjsuaAccConfig.ref.cred_info[0].data =
        PjStrTExtension.fromDartString(sipPasswd).ref;

    // Registering SIP account
    final status2 =
        bindings.pjsua_acc_add(pjsuaAccConfig, pj_constants_.PJ_TRUE, accId);
    // Handle the status check similarly
    if (status2 != pj_constants_.PJ_SUCCESS) {
      _log.fine("Error adding SIP account");
    }
    _log.fine("Success adding SIP account ${accId.value}");

    final uri = PjStrTExtension.fromDartString("sip:017650855882@fpbx.de");

    final status3 = bindings.pjsua_call_make_call(
        accId.value, uri, nullptr, nullptr, nullptr, nullptr);
    if (status3 != pj_constants_.PJ_SUCCESS) {
      bindings.pjsua_perror('APP'.toNativeUtf8().cast<Char>(),
          'Error during call'.toNativeUtf8().cast<Char>(), status);
    }
  }
}
