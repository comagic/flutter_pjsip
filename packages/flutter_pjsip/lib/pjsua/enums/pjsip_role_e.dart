import 'package:flutter_pjsip/bindings/bindings.dart';

/// Transaction role.
enum PjsipRoleE {
  /// Role is UAC.
  uac,

  /// Role is UAS.
  uas;

  /// Convert from a native pjsip_role_e to a PjsipRoleE
  static PjsipRoleE fromInt(int cls) {
    switch (cls) {
      case pjsip_role_e.PJSIP_ROLE_UAC:
        return uac;
      case pjsip_role_e.PJSIP_ROLE_UAS:
        return uas;
      default:
        throw Exception('Unknown pjsip_role_e: $cls');
    }
  }

  /// Convert from a PjsipRoleE to a native pjsip_role_e
  int toInt() {
    switch (this) {
      case uac:
        return pjsip_role_e.PJSIP_ROLE_UAC;
      case uas:
        return pjsip_role_e.PJSIP_ROLE_UAS;
    }
  }
}
