import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get_pet/app/utils/date_time_ext.dart';
import 'package:get_pet/config.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class LoggerService {
  static bool get isLogging => _saveToFile;

  static Logger? _logger;
  static late bool _saveToFile;
  static late bool _fromBackground;
  static String? _logFilePath;

  static Future<void> init(
    Future<String> getAppInfo, {
    bool? toFile,
    bool? fromBackground,
  }) async {
    // to complete previous record
    await Future.delayed(Duration.zero);

    _saveToFile = toFile ?? false;
    _fromBackground = fromBackground ?? false;
    final logOutput = await _getLogOutput();
    _logger = Logger(
      filter: _MyFilter(),
      printer: SimplePrinter(
        printTime: true,
        colors: false,
      ),
      output: logOutput,
    );

    final appInfo = await getAppInfo;
    _logger?.i(appInfo);

    if (!_fromBackground) _deleteOldLogs();
  }

  void d(Object message, {Object? error, StackTrace? stackTrace}) {
    if (_logger == null) {
      throw "Logger Service isn't initialized";
    }
    _logger?.d(message, error: error, stackTrace: stackTrace);
  }

  void i(Object message, {Object? error, StackTrace? stackTrace}) {
    if (_logger == null) {
      throw "Logger Service isn't initialized";
    }
    _logger?.i(message, error: error, stackTrace: stackTrace);
  }

  void e(Object message, {Object? error, StackTrace? stackTrace}) {
    if (_logger == null) {
      throw "Logger Service isn't initialized";
    }
    _logger?.e(message, error: error, stackTrace: stackTrace);
  }

  static Future<void> shareLogFiles() async {
    final logDir = await _getLogFileDir();

    if (Platform.isWindows) {
      _openDirectory(logDir.path);
      return;
    }

    final forShare = await logDir
        .list()
        .where((e) => e.isLogFile(forShare: true))
        .map((e) => XFile(e.path))
        .toList();

    final result = await Share.shareXFiles(forShare);
    _logger?.d('LoggerService.shareLogFiles(): ${result.status}');
  }

  static void _openDirectory(String path) {
    Process.run(
      "explorer",
      [path],
      workingDirectory: path,
    );
  }

  static Future<LogOutput> _getLogOutput() async {
    if (_saveToFile) {
      if (_logFilePath == null) {
        _logFilePath = await _getLogFilePath(_fromBackground);
        debugPrint('logFilePath = $_logFilePath');
      }
      return MultiOutput([
        ConsoleOutput(),
        FileOutput(
          file: File(_logFilePath!),
          overrideExisting: _fromBackground ? false : true,
        ),
      ]);
    } else {
      _logFilePath = null;
      return ConsoleOutput();
    }
  }

  static Future<void> _deleteOldLogs() async {
    final logDir = await _getLogFileDir();
    final forDelete =
        await logDir.list().where((e) => e.isLogFile(forDelete: true)).toList();

    for (var file in forDelete) {
      try {
        await file.delete();
        _logger?.d('LoggerService Deleted old log: ${file.path}');
      } catch (error) {
        _logger?.e('LoggerService Deleted old log: ${file.path}: $error');
      }
    }
  }

  static Future<String?> _getLogFilePath(bool isBackground) async {
    final appName = Config.appName.toLowerCase();
    final fileDateTime =
        DateFormat('yyyy.MM.dd_HH-mm-ss').format(DateTime.now());
    final fileSuffix = isBackground ? '_bg' : '';
    final fileName = '${appName}_$fileDateTime$fileSuffix.log';
    final logDir = await _getLogFileDir();

    return p.join(logDir.path, fileName);
  }

  static Future<Directory> _getLogFileDir() async {
    Directory? logDir;
    try {
      logDir = await getExternalStorageDirectory();
    } catch (err) {
      debugPrint('getExternalStorageDirectory() error: $err');
    }
    logDir ??= await getTemporaryDirectory();

    final logDirPath = switch (Platform.operatingSystem) {
      "windows" => p.join(logDir.path, Config.appName),
      _ => logDir.path,
    };

    final dir = Directory(logDirPath);
    if (!await dir.exists()) await dir.create(recursive: true);

    return dir;
  }
}

class _MyFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}

extension FileSystemEntityExt on FileSystemEntity {
  bool isLogFile({
    bool forShare = false,
    bool forDelete = false,
  }) {
    assert(forShare != forDelete, 'Exactly one parameter must be true');

    final fileStat = statSync();
    if (fileStat.type != FileSystemEntityType.file) return false;

    final fileName = p.basename(path);
    final fileNameMask = '${Config.appName.toLowerCase()}_';
    const fileExtMask = '.log';
    if (!fileName.startsWith(fileNameMask) || !fileName.endsWith(fileExtMask)) {
      return false;
    }

    final modifiedToday = fileStat.modified.isOnTheSameDay(DateTime.now());

    return forShare
        ? modifiedToday
        : forDelete
            ? !modifiedToday
            : false;
  }
}
