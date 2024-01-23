// Can't be imported as ffi because of generated code
import 'dart:ffi';

import 'package:flutter_pjsip/pjsua/pjsua.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_event.freezed.dart';

/// This structure describes timer event.
@freezed
sealed class TimerEvent with _$TimerEvent {
  const factory TimerEvent({
    /// The timer entry.
    required TimerEntry entry,
  }) = _TimerEvent;
}
