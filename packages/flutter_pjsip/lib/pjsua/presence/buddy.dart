import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart' as ffipkg;

import 'package:flutter_pjsip/bindings/bindings.dart';
import 'package:flutter_pjsip/pjsua/pjsua.dart';
import 'package:flutter_pjsip/pjsua/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'buddy.freezed.dart';

/// Buddy. This is a lite wrapper class for PJSUA-LIB buddy, i.e: this class
/// only maintains one data member, PJSUA-LIB buddy ID, and the methods are
/// simply proxies for PJSUA-LIB buddy operations.
///
/// Application can use create() to register a buddy to PJSUA-LIB, and
/// the destructor of the original instance (i.e: the instance that calls
/// create()) will unregister and delete the buddy from PJSUA-LIB. Application
/// must delete all Buddy instances belong to an account before shutting down
/// the account (via Account::shutdown()).
///
/// The library will not keep a list of Buddy instances, so any Buddy (or
/// descendant) instances instantiated by application must be maintained
/// and destroyed by the application itself. Any PJSUA2 APIs that return Buddy
/// instance(s) such as Account::enumBuddies2() or Account::findBuddy2() will
/// just return generated copy. All Buddy methods should work normally on this
/// generated copy instance.
@freezed
sealed class Buddy with _$Buddy {
  const factory Buddy({
    @Default(pjsuaInvalidId) Dartpjsua_buddy_id id,
  }) = _Buddy;

  const Buddy._();

  // TODO(nesquikm): should implement BuddyUserData first
  // Buddy getOriginalInstance() {
  //   BuddyUserData *bud = (BuddyUserData*)pjsua_buddy_get_user_data(id);
  //   return (bud? bud->self : NULL);
  // }

  // TODO(nesquikm): should implement other things first
  /// Destructor.
// Buddy::~Buddy()
// {
//     if (isValid() && getOriginalInstance()==this) {
//         Account *acc = NULL;
//         BuddyUserData *bud = (BuddyUserData*)pjsua_buddy_get_user_data(id);
//         if (bud) {
//             acc = bud->acc;
//             delete bud;
//         }

//         pjsua_buddy_set_user_data(id, NULL);
//         pjsua_buddy_del(id);

//         /* Remove from account buddy list */
//         if (acc)
//             acc->removeBuddy(this);
//     }
// }

  // TODO(nesquikm): should implement other things first
  /// Create buddy and register the buddy to PJSUA-LIB.
// void create(Account &account, const BuddyConfig &cfg)
//                    PJSUA2_THROW(Error)
// {
//     pjsua_buddy_config pj_cfg;
//     pjsua_buddy_config_default(&pj_cfg);

//     if (!account.isValid())
//         PJSUA2_RAISE_ERROR3(PJ_EINVAL, "Buddy::create()", "Invalid account");

//     BuddyUserData *bud = new BuddyUserData();
//     bud->self = this;
//     bud->acc  = &account;

//     pj_cfg.uri = str2Pj(cfg.uri);
//     pj_cfg.subscribe = cfg.subscribe;
//     pj_cfg.user_data = (void*)bud;
//     PJSUA2_CHECK_EXPR( pjsua_buddy_add(&pj_cfg, &id) );

//     account.addBuddy(this);
// }

  /// Get buddy ID.
  int getId() {
    return id;
  }

  /// Check if this buddy is valid.
  bool isValid() {
    return Pjsua.bindings.pjsua_buddy_is_valid(id).toDartBool();
  }

  /// Get detailed buddy info.
  BuddyInfo getInfo() {
    final pjBi = ffipkg.malloc
        .allocate<pjsua_buddy_info>(ffi.sizeOf<pjsua_buddy_info>());

    checkExpr(
      Pjsua.bindings.pjsua_buddy_get_info(
        id,
        pjBi,
      ),
    );

    final ret = BuddyInfo.fromPj(pjBi.ref);

    ffipkg.malloc.free(pjBi);

    return ret;
  }

  /// Enable/disable buddy's presence monitoring.
  // ignore: avoid_positional_boolean_parameters
  void subscribePresence(bool subscribe) {
    checkExpr(
      Pjsua.bindings.pjsua_buddy_subscribe_pres(
        id,
        PjBoolTExtension.fromDartBool(subscribe),
      ),
    );
  }

  /// Update the presence information for the buddy.
  void updatePresence() {
    checkExpr(Pjsua.bindings.pjsua_buddy_update_pres(id));
  }

// TODO(nesquikm): should implement other things first (SendInstantMessageParam)
  /// Send instant messaging outside dialog.
// void Buddy::sendInstantMessage(const SendInstantMessageParam &prm)
//                                PJSUA2_THROW(Error)
// {
//     BuddyInfo bi = getInfo();
//     BuddyUserData *bud = (BuddyUserData*)pjsua_buddy_get_user_data(id);
//     Account *acc = bud? bud->acc : NULL;

//     if (!bud || !acc || !acc->isValid()) {
//         PJSUA2_RAISE_ERROR3(PJ_EINVAL, "sendInstantMessage()",
//                             "Invalid Buddy");
//     }

//     pj_str_t to = str2Pj(bi.contact.empty()? bi.uri : bi.contact);
//     pj_str_t mime_type = str2Pj(prm.contentType);
//     pj_str_t content = str2Pj(prm.content);
//     void *user_data = (void*)prm.userData;
//     pjsua_msg_data msg_data;
//     prm.txOption.toPj(msg_data);

//     PJSUA2_CHECK_EXPR( pjsua_im_send(acc->getId(), &to, &mime_type, &content,
//                                      &msg_data, user_data) );
// }

// TODO(nesquikm): should implement SendTypingIndicationParam first
  /// Send typing indication outside dialog.
// void Buddy::sendTypingIndication(const SendTypingIndicationParam &prm)
//      PJSUA2_THROW(Error)
// {
//     BuddyInfo bi = getInfo();
//     BuddyUserData *bud = (BuddyUserData*)pjsua_buddy_get_user_data(id);
//     Account *acc = bud? bud->acc : NULL;

//     if (!bud || !acc || !acc->isValid()) {
//         PJSUA2_RAISE_ERROR3(PJ_EINVAL, "sendInstantMessage()",
//                             "Invalid Buddy");
//     }

//     pj_str_t to = str2Pj(bi.contact.empty()? bi.uri : bi.contact);
//     pjsua_msg_data msg_data;
//     prm.txOption.toPj(msg_data);

//     PJSUA2_CHECK_EXPR( pjsua_im_typing(acc->getId(), &to, prm.isTyping,
//                                        &msg_data) );
// }

  /// Callback: notify application when the buddy state has changed.
  /// Application may then query the buddy info to get the details.
  void onBuddyState() {
    // TODO(nesquikm): use something like streams here
  }

  /// Callback: notify application when the state of client subscription session
  /// associated with a buddy has changed. Application may use this
  /// callback to retrieve more detailed information about the state
  /// changed event.
  ///
  /// [prm]       Callback parameter.
  void onBuddyEvSubState(OnBuddyEvSubStateParam prm) {
    // TODO(nesquikm): use something like streams here
  }
}
