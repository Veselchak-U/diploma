import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ru.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ru')
  ];

  /// No description provided for @pageNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Страница не найдена'**
  String get pageNotFound;

  /// No description provided for @toInitialScreen.
  ///
  /// In ru, this message translates to:
  /// **'На начальный экран'**
  String get toInitialScreen;

  /// No description provided for @enterActivationCode.
  ///
  /// In ru, this message translates to:
  /// **'Введите полученный код активациии устройства'**
  String get enterActivationCode;

  /// No description provided for @activationCode.
  ///
  /// In ru, this message translates to:
  /// **'Код активации'**
  String get activationCode;

  /// No description provided for @enterOnlyNumbers.
  ///
  /// In ru, this message translates to:
  /// **'вводите только цифры'**
  String get enterOnlyNumbers;

  /// No description provided for @activateDevice.
  ///
  /// In ru, this message translates to:
  /// **'Активировать устройство'**
  String get activateDevice;

  /// No description provided for @version.
  ///
  /// In ru, this message translates to:
  /// **'Версия'**
  String get version;

  /// No description provided for @authorization.
  ///
  /// In ru, this message translates to:
  /// **'Авторизация'**
  String get authorization;

  /// No description provided for @invalidCode.
  ///
  /// In ru, this message translates to:
  /// **'Неверный код'**
  String get invalidCode;

  /// No description provided for @settings.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settings;

  /// No description provided for @androidSettings.
  ///
  /// In ru, this message translates to:
  /// **'Android-настройки'**
  String get androidSettings;

  /// No description provided for @shareLogs.
  ///
  /// In ru, this message translates to:
  /// **'Отправить логи приложения'**
  String get shareLogs;

  /// No description provided for @noInternetConnection.
  ///
  /// In ru, this message translates to:
  /// **'Отсутствует интернет-соединение.'**
  String get noInternetConnection;

  /// No description provided for @serverTimeout.
  ///
  /// In ru, this message translates to:
  /// **'Сервер не ответил на запрос вовремя. Повторите попытку позже.'**
  String get serverTimeout;

  /// No description provided for @updatingPlaylist.
  ///
  /// In ru, this message translates to:
  /// **'Обновление плейлиста...'**
  String get updatingPlaylist;

  /// No description provided for @initializingBuffer.
  ///
  /// In ru, this message translates to:
  /// **'Инициализация буфера...'**
  String get initializingBuffer;

  /// No description provided for @updatingBuffer.
  ///
  /// In ru, this message translates to:
  /// **'Обновление буфера...'**
  String get updatingBuffer;

  /// No description provided for @waitingForBuffer.
  ///
  /// In ru, this message translates to:
  /// **'Ожидание буфера, проигрывание начнётся автоматически...'**
  String get waitingForBuffer;

  /// No description provided for @currentTrackNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Не найден текущий трек в плейлисте.'**
  String get currentTrackNotFound;

  /// No description provided for @inactiveOrExpired.
  ///
  /// In ru, this message translates to:
  /// **'Договор неактивен или истёк срок действия'**
  String get inactiveOrExpired;

  /// No description provided for @update.
  ///
  /// In ru, this message translates to:
  /// **'Обновить'**
  String get update;

  /// No description provided for @userWasDeleted.
  ///
  /// In ru, this message translates to:
  /// **'Пользователь был удалён, требуется повторная активация.'**
  String get userWasDeleted;

  /// No description provided for @contractDeactivated.
  ///
  /// In ru, this message translates to:
  /// **'Договор был деактивирован, свяжитесь с администратором.'**
  String get contractDeactivated;

  /// No description provided for @contractExpired.
  ///
  /// In ru, this message translates to:
  /// **'Истёк срок действия договора, свяжитесь с администратором.'**
  String get contractExpired;

  /// No description provided for @codeChanged.
  ///
  /// In ru, this message translates to:
  /// **'Код доступа был изменён, необходима повторная авторизация.'**
  String get codeChanged;

  /// No description provided for @initError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка инициализации'**
  String get initError;

  /// No description provided for @noData.
  ///
  /// In ru, this message translates to:
  /// **'Нет данных в ответе сервера'**
  String get noData;

  /// No description provided for @codeWasChanged.
  ///
  /// In ru, this message translates to:
  /// **'Код активации был изменён'**
  String get codeWasChanged;

  /// No description provided for @playlistNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Плейлист на сегодня не найден'**
  String get playlistNotFound;

  /// No description provided for @batteryOptimization.
  ///
  /// In ru, this message translates to:
  /// **'Оптимизация батареи'**
  String get batteryOptimization;

  /// No description provided for @batteryOptimizationText.
  ///
  /// In ru, this message translates to:
  /// **'Для бесперебойной работы приложения при выключенном экране необходимо отключить оптимизацию батареи.'**
  String get batteryOptimizationText;

  /// No description provided for @openSettings.
  ///
  /// In ru, this message translates to:
  /// **'Перейти в настройки'**
  String get openSettings;

  /// No description provided for @later.
  ///
  /// In ru, this message translates to:
  /// **'Позже'**
  String get later;

  /// No description provided for @cancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancel;

  /// No description provided for @enableAutoStart.
  ///
  /// In ru, this message translates to:
  /// **'Включить автоматический запуск'**
  String get enableAutoStart;

  /// No description provided for @enableAutoStartText.
  ///
  /// In ru, this message translates to:
  /// **'Следуйте инструкциям и включите автозапуск этого приложения'**
  String get enableAutoStartText;

  /// No description provided for @additionalOptimization.
  ///
  /// In ru, this message translates to:
  /// **'В вашем устройстве предусмотрена дополнительная оптимизация заряда батареи'**
  String get additionalOptimization;

  /// No description provided for @additionalOptimizationText.
  ///
  /// In ru, this message translates to:
  /// **'Следуйте инструкциям и отключите оптимизацию, чтобы обеспечить бесперебойную работу этого приложения'**
  String get additionalOptimizationText;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
