// Can't be imported as ffi because of generated code
import 'dart:ffi';

import 'package:flutter_pjsip/bindings/bindings.dart';
import 'package:flutter_pjsip/pjsua/pjsua.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sip_event.freezed.dart';

/// This structure describe event descriptor to fully identify a SIP event. It
/// corresponds to the pjsip_event structure in PJSIP library.
@freezed
sealed class SipEvent with _$SipEvent {
  const factory SipEvent({
    /// The event type, can be any value of \b pjsip_event_id_e.
    required PjsipEventIdE type,

    /// The event body, which fields depends on the event type.
    required SipEventBody body,
  }) = _SipEvent;

  const factory SipEvent.type({
    /// The event type, can be any value of pjsip_event_id_e.
    required PjsipEventIdE type,
  }) = _SipEventType;

  /// Import from pjsip structure
  factory SipEvent.fromPj(pjsip_event ev) {
    final type = PjsipEventIdE.fromInt(ev.type);

    final body = switch (type) {
      PjsipEventIdE.timer => SipEventBody.timer(
          timer: TimerEvent(
            entry: ev.body.timer.entry.cast<Void>(),
          ),
        ),
      PjsipEventIdE.tsxState => SipEventBody.tsxState(
          tsxState: TsxStateEvent(
            prevState: PjsipTsxStateE.fromInt(ev.body.tsx_state.prev_state),
            tsx: SipTransaction.fromPj(ev.body.tsx_state.tsx),
            type: PjsipEventIdE.fromInt(ev.body.tsx_state.type),
            src: switch (PjsipEventIdE.fromInt(ev.body.tsx_state.type)) {
              PjsipEventIdE.txMsg => ev.body.tsx_state.src.tdata != nullptr
                  ? TsxStateEventSrc.tdata(
                      tdata: SipTxData.fromPj(
                        ev.body.tsx_state.src.tdata,
                      ),
                    )
                  : null,
              PjsipEventIdE.rxMsg => ev.body.tsx_state.src.rdata != nullptr
                  ? TsxStateEventSrc.rdata(
                      rdata: SipRxData.fromPj(
                        ev.body.tsx_state.src.rdata,
                      ),
                    )
                  : null,
              PjsipEventIdE.transportError => TsxStateEventSrc.status(
                  status: ev.body.tsx_state.src.status,
                ),
              PjsipEventIdE.timer => TsxStateEventSrc.timer(
                  timer: ev.body.tsx_state.src.timer.cast<Void>(),
                ),
              PjsipEventIdE.user => TsxStateEventSrc.user(
                  data: ev.body.tsx_state.src.data,
                ),
              PjsipEventIdE.unknown => null,
              PjsipEventIdE.tsxState => null,
            },
          ),
        ),
      PjsipEventIdE.txMsg => ev.body.tx_msg.tdata != nullptr
          ? SipEventBody.txMsg(
              txMsg: TxMsgEvent(
                tdata: SipTxData.fromPj(ev.body.tx_msg.tdata),
              ),
            )
          : null,
      PjsipEventIdE.rxMsg => ev.body.rx_msg.rdata != nullptr
          ? SipEventBody.rxMsg(
              rxMsg: RxMsgEvent(
                rdata: SipRxData.fromPj(ev.body.rx_msg.rdata),
              ),
            )
          : null,
      PjsipEventIdE.transportError => SipEventBody.txError(
          txError: TxErrorEvent(
            tdata: ev.body.tx_error.tdata != nullptr
                ? SipTxData.fromPj(ev.body.tx_error.tdata)
                : null,
            tsx: ev.body.tx_error.tsx != nullptr
                ? SipTransaction.fromPj(ev.body.tx_error.tsx)
                : null,
          ),
        ),
      PjsipEventIdE.user => SipEventBody.user(
          user: UserEvent(
            user1: ev.body.user.user1,
            user2: ev.body.user.user2,
            user3: ev.body.user.user3,
            user4: ev.body.user.user4,
          ),
        ),
      PjsipEventIdE.unknown => null,
    };

    return body != null
        ? SipEvent(
            type: type,
            body: body,
          )
        : SipEvent.type(
            type: type,
          );
  }
}
