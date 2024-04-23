import 'package:get_pet/app/service/logger/logger_service.dart';

class SettingsScreenVm {
  SettingsScreenVm() {
    _init();
  }

  void _init() {}

  void dispose() {}

  void shareLogs() {
    LoggerService.shareLogFiles();
  }
}
