// Can't be imported as ffi because of generated code
import 'dart:ffi';

import 'package:flutter_pjsip/pjsua/pjsua.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_event.freezed.dart';

/// This structure describes user event.
@freezed
sealed class UserEvent with _$UserEvent {
  const factory UserEvent({
    /// User data 1.
    required GenericData user1,

    /// User data 2.
    required GenericData user2,

    /// User data 3.
    required GenericData user3,

    /// User data 4.
    required GenericData user4,
  }) = _UserEvent;
}
