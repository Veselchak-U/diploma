import 'app_localizations.dart';

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get pageNotFound => 'Страница не найдена';

  @override
  String get toInitialScreen => 'На начальный экран';

  @override
  String get enterActivationCode => 'Введите полученный код активациии устройства';

  @override
  String get activationCode => 'Код активации';

  @override
  String get enterOnlyNumbers => 'вводите только цифры';

  @override
  String get activateDevice => 'Активировать устройство';

  @override
  String get version => 'Версия';

  @override
  String get authorization => 'Авторизация';

  @override
  String get invalidCode => 'Неверный код';

  @override
  String get settings => 'Настройки';

  @override
  String get androidSettings => 'Android-настройки';

  @override
  String get shareLogs => 'Отправить логи приложения';

  @override
  String get noInternetConnection => 'Отсутствует интернет-соединение.';

  @override
  String get serverTimeout => 'Сервер не ответил на запрос вовремя. Повторите попытку позже.';

  @override
  String get updatingPlaylist => 'Обновление плейлиста...';

  @override
  String get initializingBuffer => 'Инициализация буфера...';

  @override
  String get updatingBuffer => 'Обновление буфера...';

  @override
  String get waitingForBuffer => 'Ожидание буфера, проигрывание начнётся автоматически...';

  @override
  String get currentTrackNotFound => 'Не найден текущий трек в плейлисте.';

  @override
  String get inactiveOrExpired => 'Договор неактивен или истёк срок действия';

  @override
  String get update => 'Обновить';

  @override
  String get userWasDeleted => 'Пользователь был удалён, требуется повторная активация.';

  @override
  String get contractDeactivated => 'Договор был деактивирован, свяжитесь с администратором.';

  @override
  String get contractExpired => 'Истёк срок действия договора, свяжитесь с администратором.';

  @override
  String get codeChanged => 'Код доступа был изменён, необходима повторная авторизация.';

  @override
  String get initError => 'Ошибка инициализации';

  @override
  String get noData => 'Нет данных в ответе сервера';

  @override
  String get codeWasChanged => 'Код активации был изменён';

  @override
  String get playlistNotFound => 'Плейлист на сегодня не найден';

  @override
  String get batteryOptimization => 'Оптимизация батареи';

  @override
  String get batteryOptimizationText => 'Для бесперебойной работы приложения при выключенном экране необходимо отключить оптимизацию батареи.';

  @override
  String get openSettings => 'Перейти в настройки';

  @override
  String get later => 'Позже';

  @override
  String get cancel => 'Отмена';

  @override
  String get enableAutoStart => 'Включить автоматический запуск';

  @override
  String get enableAutoStartText => 'Следуйте инструкциям и включите автозапуск этого приложения';

  @override
  String get additionalOptimization => 'В вашем устройстве предусмотрена дополнительная оптимизация заряда батареи';

  @override
  String get additionalOptimizationText => 'Следуйте инструкциям и отключите оптимизацию, чтобы обеспечить бесперебойную работу этого приложения';
}
