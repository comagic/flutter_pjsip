import 'dart:async';
import 'dart:isolate';

import 'package:flutter_pjsip/flutter_pjsip.dart' as flutter_pjsip;

class SumWorker {
  final SendPort _commands;
  final ReceivePort _responses;
  final Map<int, Completer<int?>> _activeRequests = {};
  int _idCounter = 0;
  bool _closed = false;

  SumWorker._(this._responses, this._commands) {
    _responses.listen(_handleResponsesFromIsolate);
  }

  Future<int?> getSum(int firstArg, int secondArg) async {
    if (_closed) throw StateError('Closed');

    final completer = Completer<int?>.sync();
    final id = _idCounter++;
    _activeRequests[id] = completer;
    _commands.send((id, [firstArg, secondArg]));

    return completer.future;
  }

  static Future<SumWorker> spawn() async {
    final initPort = RawReceivePort();
    final connection = Completer<(ReceivePort, SendPort)>.sync();

    initPort.handler = (SendPort initialMessage) {
      final commandPort = initialMessage;
      connection.complete(
        (
          ReceivePort.fromRawReceivePort(initPort),
          commandPort,
        ),
      );
    };

    // Spawn the isolate.
    try {
      await Isolate.spawn(_startRemoteIsolate, initPort.sendPort);
    } on Object {
      initPort.close();
      rethrow;
    }

    final (ReceivePort receivePort, SendPort sendPort) =
        await connection.future;

    return SumWorker._(receivePort, sendPort);
  }

  void _handleResponsesFromIsolate(dynamic message) {
    final (int id, int? response) = message as (int, int?);
    final completer = _activeRequests.remove(id)!;

    if (response is RemoteError) {
      completer.completeError({'response': response});
    } else {
      completer.complete(response);
    }

    if (_closed && _activeRequests.isEmpty) _responses.close();
  }

  static void _handleCommandsToIsolate(
    ReceivePort receivePort,
    SendPort sendPort,
  ) {
    receivePort.listen((message) {
      if (message == 'shutdown') {
        receivePort.close();
        return;
      }

      final (int id, List<int> values) = message as (int, List<int>);

      try {
        final sum = flutter_pjsip.sum(values[0], values[1]);
        sendPort.send((id, sum));
      } catch (e) {
        sendPort.send((id, RemoteError(e.toString(), '')));
      }
    });
  }

  static void _startRemoteIsolate(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    _handleCommandsToIsolate(receivePort, sendPort);
  }

  void close() {
    if (!_closed) {
      _closed = true;
      _commands.send('shutdown');
      if (_activeRequests.isEmpty) _responses.close();
      print('--- port closed --- ');
    }
  }
}
