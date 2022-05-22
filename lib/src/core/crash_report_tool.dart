import 'package:dartz/dartz.dart';

import 'domain/entities/crash_error.dart';
import 'domain/failures/crash_report_failure.dart';

abstract class CrashReportTool {
  Future<Option<CrashReportFailure>> report(CrashError error);

  Future<void> init();
}
