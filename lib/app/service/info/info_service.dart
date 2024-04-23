import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_pet/app/l10n/l10n.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract interface class InfoService {
  Future<String> getPackageInfo();

  Future<String> getDeviceInfo();

  Future<String> getAppInfo();
}

class InfoServiceImpl implements InfoService {
  @override
  Future<String> getPackageInfo({bool localized = true}) async {
    final info = await PackageInfo.fromPlatform();

    return '${localized ? l10n.version : "Version"}: ${info.version}+${info.buildNumber}';
  }

  @override
  Future<String> getDeviceInfo() async {
    final info = await DeviceInfoPlugin().deviceInfo;
    final result = switch (info) {
      final AndroidDeviceInfo info =>
        '${info.brand} ${info.model}, Android ${info.version.release}',
      final IosDeviceInfo info =>
        '${info.name}, ${info.systemName} ${info.systemVersion}',
      final WindowsDeviceInfo info =>
        '${info.productName}, ${info.displayVersion}',
      _ => '$info',
    };

    return result;
  }

  @override
  Future<String> getAppInfo() async {
    final package = await getPackageInfo(localized: false);
    final device = await getDeviceInfo();

    return '\nApp info:\n'
        'Package = $package\n'
        'Device = $device';
  }
}
