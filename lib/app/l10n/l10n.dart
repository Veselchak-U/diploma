import 'package:flutter/widgets.dart';
import 'package:get_pet/app/l10n/app_localizations.dart';

late AppLocalizations _l10n;

AppLocalizations get l10n => _l10n;

class L10n {
  static init(BuildContext context) {
    _l10n = AppLocalizations.of(context)!;
  }
}
