class CrashError {
  CrashError({
    this.exception,
    this.reason,
    this.stackTrace,
    required this.crashType,
    this.data,
  });

  factory CrashError.fromNonFatalStackTrace(
    Object e,
    StackTrace s, {
    String? reason,
    Object? data,
  }) {
    return CrashError(
      crashType: CrashType.CAUGHT,
      reason: reason,
      exception: e,
      stackTrace: s,
      data: data,
    );
  }

  final dynamic exception, reason;
  final StackTrace? stackTrace;
  final CrashType crashType;
  final dynamic data;
}

enum CrashType { FATAL, CAUGHT, UNKNOWN }
