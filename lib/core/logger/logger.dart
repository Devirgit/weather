import 'package:flutter/foundation.dart';

enum _LevelLog { error, warning, info, config, none }

extension _LevelLogColor on _LevelLog {
  int get color {
    switch (this) {
      case _LevelLog.error:
        return 31;
      case _LevelLog.warning:
        return 32;
      case _LevelLog.info:
        return 33;
      case _LevelLog.config:
        return 35;
      case _LevelLog.none:
        return 0;
    }
  }

  String get name {
    switch (this) {
      case _LevelLog.error:
        return 'ERROR';
      case _LevelLog.warning:
        return 'WARNING';
      case _LevelLog.info:
        return 'INFO';
      case _LevelLog.config:
        return 'CONFIG';
      case _LevelLog.none:
        return 'MSG';
    }
  }
}

class Log {
  static void error(String message, [String? className]) {
    _writeLog(message, _LevelLog.error, className);
  }

  static void warning(String message, [String? className]) {
    _writeLog(message, _LevelLog.warning, className);
  }

  static void info(String message, [String? className]) {
    _writeLog(message, _LevelLog.info, className);
  }

  static void config(String message, [String? className]) {
    _writeLog(message, _LevelLog.config, className);
  }

  static void msg(String message, [String? className]) {
    _writeLog(message, _LevelLog.none, className);
  }

  static void _writeLog(String message, _LevelLog level, [String? className]) {
    if (kDebugMode) {
      print('\x1B[${level.color}m[${level.name}] ${DateTime.now()}: '
          '$message ${className == null ? '' : '[module] $className'}\x1B[0m');
    }
  }
}
