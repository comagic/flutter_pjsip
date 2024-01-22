import 'dart:ffi' as ffi;

/// Timer entry, corresponds to pj_timer_entry.
typedef TimerEntry = ffi.Pointer<ffi.Void>;
