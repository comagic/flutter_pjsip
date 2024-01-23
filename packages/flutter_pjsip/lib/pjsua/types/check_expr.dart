import 'package:flutter_pjsip/bindings/bindings.dart';
import 'package:flutter_pjsip/pjsua/pjsua.dart';

/// Raise Error exception if the expression fails
void checkExpr(Dartpj_status_t status) {
  if (status != pjSuccess) {
    throw Exception(
      'Error: status $status',
    );
  }
}
