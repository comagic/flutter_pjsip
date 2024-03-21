import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:flutter_pjsip/bindings/bindings.dart';
import 'package:flutter_pjsip/bindings/flutter_pjsip_bindings_generated.dart';
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

  static final recordId = malloc<Int>()..value = -1;
  static final accId = calloc<pjsua_acc_id>();

  static final _callStreamController = StreamController<Call>.broadcast();
  static Stream<Call> get callStream => _callStreamController.stream;

  static StreamController<List<int>> _callMediaDataStreamController =
      StreamController<List<int>>.broadcast();
  static Stream<List<int>> get callMediaDataStream =>
      _callMediaDataStreamController.stream;
  static StreamSubscription<List<int>>? _callMediaSubscription;

  static final _transportStreamController =
      StreamController<TransportStateEnum>.broadcast();
  static Stream<TransportStateEnum> get transportStream =>
      _transportStreamController.stream;

  static final _registrationStreamController =
      StreamController<RegistrationStateEnum>.broadcast();
  static Stream<RegistrationStateEnum> get registrationStream =>
      _registrationStreamController.stream;

  static final _callMediaStateStreamController =
      StreamController<CallMediaStateEnum>.broadcast();
  static Stream<CallMediaStateEnum> get callStateStream =>
      _callMediaStateStreamController.stream;

  static void _onCallState(int callId, Pointer<pjsip_event> e) {
    final ci = calloc<pjsua_call_info>();
    bindings.pjsua_call_get_info(callId, ci);
    final callState = ci.ref.state_text.toDartString();
    _log.fine('onCallState: ${callId} ${callState}');
    if (callState == 'DISCONNECTED' || callState == '') {
      if (recordId.value >= 0) {
        final status = bindings.pjsua_recorder_destroy(recordId.value);
        recordId.value = -1;
        if (status == pj_constants_.PJ_SUCCESS) {
          _log.fine('Recorder destroy success: $status');
        } else {
          _log.fine('Recorder destroy failed: $status');
        }
        _callMediaSubscription?.cancel();
      }
    }
    final call = Call(
        state: CallStateEnum.values[ci.ref.state],
        id: ci.ref.id.toString(),
        localContact: ci.ref.local_contact.toDartString(),
        remContact: ci.ref.remote_contact.toDartString(),
        direction: CallDirectionEnum.OUTGOING);
    _callStreamController.add(call);
  }

  static void _onCallMediaState(int callId) {
    final ci = calloc<pjsua_call_info>();
    bindings.pjsua_call_get_info(callId, ci);
    final mediaState = CallMediaStateEnum.values[ci.ref.media_status];
    if (mediaState == CallMediaStateEnum.ACTIVE) {
      bindings.pjsua_conf_connect(ci.ref.conf_slot, 0);
      bindings.pjsua_conf_connect(0, ci.ref.conf_slot);
      final file_name = PjStrTExtension.fromDartString("test_file.wav");
      bindings.pjsua_recorder_create(file_name, 0, nullptr, -1, 0, recordId);
      final recordPort = bindings.pjsua_recorder_get_conf_port(recordId.value);
      bindings.pjsua_conf_connect(ci.ref.conf_slot, recordPort);
      bindings.pjsua_conf_connect(0, recordPort);
      File file = File("test_file.wav");
      _callMediaSubscription = _tail(file).listen((data) {
        _callMediaDataStreamController.sink.add(data);
      });
    }
    _callMediaStateStreamController.add(mediaState);
  }

  static void _onTransportState(Pointer<pjsip_transport> transport, int status,
      Pointer<pjsip_transport_state_info> info) {
    _transportStreamController.add(TransportStateEnum.values[status]);
  }

  static void _onRegistrationState(int acc_id, Pointer<pjsua_reg_info> info) {
    _registrationStreamController
        .add(RegistrationStateEnum.values[info.ref.renew]);
  }

  static void start(String userAgent, int port, {int logLevel = 4}) {
    if (bindings.pjsua_get_state() != 0) {
      _log.fine('Already started');
      return;
    }
    _log.fine('pjCreate:');
    final a = bindings.pjsua_create();
    _log.fine('pjsua_create returns $a');
    final pjsuaConfig = calloc<pjsua_config>();
    bindings.pjsua_config_default(pjsuaConfig);
    pjsuaConfig.ref.user_agent = PjStrTExtension.fromDartString(userAgent).ref;
    pjsuaConfig.ref.cb.on_call_media_state =
        NativeCallable<Void Function(Int)>.listener(_onCallMediaState)
            .nativeFunction;
    pjsuaConfig.ref.cb.on_call_state =
        NativeCallable<Void Function(Int, Pointer<pjsip_event>)>.listener(
                _onCallState)
            .nativeFunction;
    pjsuaConfig.ref.cb.on_transport_state = NativeCallable<
                Void Function(Pointer<pjsip_transport>, Int32,
                    Pointer<pjsip_transport_state_info>)>.listener(
            _onTransportState)
        .nativeFunction;
    pjsuaConfig.ref.cb.on_reg_state2 =
        NativeCallable<Void Function(Int, Pointer<pjsua_reg_info>)>.listener(
                _onRegistrationState)
            .nativeFunction;
    final pjsuaLoggingConfig = calloc<pjsua_logging_config>();
    bindings.pjsua_logging_config_default(pjsuaLoggingConfig);
    pjsuaLoggingConfig.ref.console_level = logLevel;
    _log.fine('pjInit:');
    final a2 = bindings.pjsua_init(pjsuaConfig, pjsuaLoggingConfig, nullptr);
    _log.fine('pjsua_init returns $a2');
    final pjsuaTransportConfig = calloc<pjsua_transport_config>();
    bindings.pjsua_transport_config_default(pjsuaTransportConfig);
    pjsuaTransportConfig.ref.port = port;
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
  }

  static void register(String user, String domain, String password) {
    // pjRegister
    final pjsuaAccConfig = calloc<pjsua_acc_config>();
    bindings.pjsua_acc_config_default(pjsuaAccConfig);
    // Setting account ID
    pjsuaAccConfig.ref.id =
        PjStrTExtension.fromDartString("Leon <sip:$user@$domain>").ref;

    //final proxy = PjStrTExtension.fromDartString("fpbx.de").ref;
    //pjsuaAccConfig.ref.proxy[0] = proxy.ptr.value;

    // Setting registrar URI
    pjsuaAccConfig.ref.reg_uri =
        PjStrTExtension.fromDartString("sip:$domain").ref;

    //pjsuaAccConfig.ref.srtp_secure_signaling = 0;
    //pjsuaAccConfig.ref.use_srtp = pjmedia_srtp_use.PJMEDIA_SRTP_DISABLED;
    pjsuaAccConfig.ref.cred_count = 1;
    pjsuaAccConfig.ref.cred_info[0].realm =
        PjStrTExtension.fromDartString(domain).ref;
    pjsuaAccConfig.ref.cred_info[0].scheme =
        PjStrTExtension.fromDartString("digest").ref;
    pjsuaAccConfig.ref.cred_info[0].username =
        PjStrTExtension.fromDartString(user).ref;
    pjsuaAccConfig.ref.cred_info[0].data_type = 0;
    pjsuaAccConfig.ref.cred_info[0].data =
        PjStrTExtension.fromDartString(password).ref;

    // Registering SIP account
    final status =
        bindings.pjsua_acc_add(pjsuaAccConfig, pj_constants_.PJ_TRUE, accId);
    // Handle the status check similarly
    if (status != pj_constants_.PJ_SUCCESS) {
      _log.fine("Error adding SIP account");
    }
    _log.fine("Success adding SIP account ${accId.value}");
  }

  static void call(String target) {
    final uri = PjStrTExtension.fromDartString("sip:$target");

    final status = bindings.pjsua_call_make_call(
        accId.value, uri, nullptr, nullptr, nullptr, nullptr);

    if (status != pj_constants_.PJ_SUCCESS) {
      bindings.pjsua_perror('APP'.toNativeUtf8().cast<Char>(),
          'Error during call'.toNativeUtf8().cast<Char>(), status);
    }
  }

  static void hangUp() {
    bindings.pjsua_call_hangup_all();
  }
}

Stream<List<int>> _tail(final File file,
    {int pollingIntervalMillis = 1000}) async* {
  final randomAccess = await file.open(mode: FileMode.read);
  var pos = await randomAccess.position();
  var len = await randomAccess.length();
  // Increase/decrease buffer size as needed.
  var buf = Uint8List(16 * 1024);

  Stream<Uint8List> _read() async* {
    while (pos < len) {
      final bytesRead = await randomAccess.readInto(buf);
      pos += bytesRead;

      yield buf.sublist(0, bytesRead);
    }
  }

  // Initial read of the whole file.
  yield* _read();

  // Poll for changes and read more bytes from file every x milliseconds.
  while (true) {
    await Future.delayed(Duration(milliseconds: pollingIntervalMillis));

    len = await randomAccess.length();
    if (pos < len) {
      // New data is available
      yield* _read();
    }
  }
}

enum RegistrationStateEnum { UNREGISTERED, REGISTERED }

enum CallStateEnum {
  NONE,
  CALLING,
  INCOMING,
  EARLY,
  CONNECTING,
  CONFIRMED,
  DISCONNECTED,
}

enum CallMediaStateEnum { NONE, ACTIVE, LOCAL_HOLD, REMOTE_HOLD, ERROR }

enum TransportStateEnum { CONNECTED, DISCONNECTED, SHUTDOWN, DESTROY }

enum CallDirectionEnum { INCOMING, OUTGOING }

class Call {
  CallStateEnum state;
  CallDirectionEnum? direction;
  String? id;
  String? localContact;
  String? remContact;
  Call(
      {required this.state,
      this.direction,
      this.id,
      this.localContact,
      this.remContact});
}
