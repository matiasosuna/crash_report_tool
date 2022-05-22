import 'package:crash_report_tool/crash_report_tool.dart';
import 'package:dartz/dartz.dart';

abstract class CrashReportTool {
  Future<Option<CrashReportFailure>> report(CrashError error);

  Future<void> init();

  void runZoneGuarded(
    Function function, {
    Object? crashInformation,
    String? context,
  });
}
