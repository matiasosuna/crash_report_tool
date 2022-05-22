import 'package:crash_report_tool/src/core/crash_report_tool.dart';
import 'package:crash_report_tool/src/core/domain/entities/crash_error.dart';
import 'package:crash_report_tool/src/core/domain/failures/crash_report_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class FirebaseCrashlyticsReportTool implements CrashReportTool {
  @override
  Future<Option<CrashReportFailure>> report(CrashError error) async {
    try {
      FirebaseCrashlytics.instance.log(error.data.toString());
      FirebaseCrashlytics.instance.recordError(
        error.exception,
        error.stackTrace,
        reason: error.reason,
        fatal: true,
        information: [_DataInformation('data', error.data)],
      );
      return const None();
    } catch (e) {
      print('$e');
      return Some(CrashReportFailure(message: e.toString()));
    }
  }

  @override
  Future<void> init() async {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }

  @override
  void runZoneGuarded(
    Function function, {
    Object? crashInformation,
    String? context,
  }) {
    try {
      function();
    } catch (e, s) {
      print('$e');
      report(
        CrashError.fromNonFatalStackTrace(e, s,
            data: crashInformation, reason: context),
      );
    }
  }
}

class _DataInformation extends DiagnosticsProperty {
  _DataInformation(String? name, value) : super(name, value);
}
