import 'package:logger/logger.dart';

class LogHelper {
  static Logger logger = Logger(printer: PrettyPrinter());

  static void trace(String message, {Object? error, StackTrace? stackTrace, String? name}) {
    logger.t(message, error: error, stackTrace: stackTrace, time: DateTime.now());
  }

  static void debug(String message, {Object? error, StackTrace? stackTrace}) {
    logger.d(message, error: error, stackTrace: stackTrace, time: DateTime.now());
  }

  static void info(String message, {Object? error, StackTrace? stackTrace}) {
    logger.i(message, error: error, stackTrace: stackTrace, time: DateTime.now());
  }

  static void warning(String message, {Object? error, StackTrace? stackTrace}) {
    logger.w(message, error: error, stackTrace: stackTrace, time: DateTime.now());
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    logger.e(message, error: error, stackTrace: stackTrace, time: DateTime.now());
  }

  static void fatalLog(String message, {Object? error, StackTrace? stackTrace}) {
    logger.f(message, error: error, stackTrace: stackTrace, time: DateTime.now());
  }
}
