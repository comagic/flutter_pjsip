/// Extension methods for the `pj_bool_t` (actually, it's int) type.
extension PjBoolTExtension on int {
  /// Converts the `pj_bool_t` (int) instance to a Dart [bool].
  bool toDartBool() {
    return this != 0;
  }

  /// Creates a `pj_bool_t` (int) instance from a Dart [bool].
  // ignore: avoid_positional_boolean_parameters
  static int fromDartBool(bool inputBool) {
    return inputBool ? 1 : 0;
  }
}
