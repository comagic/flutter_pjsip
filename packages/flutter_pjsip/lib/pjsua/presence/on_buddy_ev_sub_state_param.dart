import 'package:flutter_pjsip/pjsua/pjsua.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'on_buddy_ev_sub_state_param.freezed.dart';

/// This structure contains parameters for Buddy::onBuddyEvSubState() callback.
@freezed
sealed class OnBuddyEvSubStateParam with _$OnBuddyEvSubStateParam {
  const factory OnBuddyEvSubStateParam({
    /// The event which triggers state change event.
    required SipEvent e,
  }) = _OnBuddyEvSubStateParam;
}
