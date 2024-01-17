import 'package:flutter_pjsip/bindings/bindings.dart';
import 'package:flutter_pjsip/pjsua/enums/enums.dart';
import 'package:flutter_pjsip/pjsua/presence/presence_status.dart';
import 'package:flutter_pjsip/pjsua/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'buddy_info.freezed.dart';

/// This structure describes buddy info, which can be retrieved by via
/// Buddy::getInfo().
@freezed
sealed class BuddyInfo with _$BuddyInfo {
  const factory BuddyInfo({
    ///The full URI of the buddy, as specified in the configuration.

    required String uri,

    /// Buddy's Contact, only available when presence subscription has
    /// been established to the buddy.
    required String contact,

    /// Flag to indicate that we should monitor the presence information for
    /// this buddy (normally yes, unless explicitly disabled).
    required bool presMonitorEnabled,

    /// If \a presMonitorEnabled is true, this specifies the last state of
    /// the presence subscription. If presence subscription session is currently
    /// active, the value will be PJSIP_EVSUB_STATE_ACTIVE. If presence
    /// subscription request has been rejected, the value will be
    /// PJSIP_EVSUB_STATE_TERMINATED, and the termination reason will be
    /// specified in \a subTermReason.
    required PjsipEvsubState subState,

    /// String representation of subscription state.
    required String subStateName,

    /// Specifies the last presence subscription termination code. This would
    /// return the last status of the SUBSCRIBE request. If the subscription
    /// is terminated with NOTIFY by the server, this value will be set to
    /// 200, and subscription termination reason will be given in the
    /// subTermReason field.
    required PjsipStatusCode subTermCode,

    /// Specifies the last presence subscription termination reason. If
    /// presence subscription is currently active, the value will be empty.
    required String subTermReason,

    /// Presence status.
    required PresenceStatus presStatus,
  }) = _BuddyInfo;

  /// Import from pjsip structure
  factory BuddyInfo.fromPj(pjsua_buddy_info pbi) {
    return BuddyInfo(
      uri: pbi.uri.toDartString(),
      contact: pbi.contact.toDartString(),
      presMonitorEnabled: pbi.monitor_pres.toDartBool(),
      subState: PjsipEvsubState.fromInt(pbi.sub_state),
      subStateName: pbi.sub_state_name.toDartString(),
      subTermCode: PjsipStatusCode.fromInt(pbi.sub_term_code),
      subTermReason: pbi.sub_term_reason.toDartString(),
      presStatus: PresenceStatus(
        status: PjsuaBuddyStatus.fromInt(pbi.status),
        statusText: pbi.status_text.toDartString(),
        activity: PjrpidActivity.fromInt(pbi.rpid.activity),
        note: pbi.rpid.note.toDartString(),
        rpidId: pbi.rpid.id.toDartString(),
      ),
    );
  }
}
