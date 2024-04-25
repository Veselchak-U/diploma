import 'app_localizations.dart';

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get pageNotFound => 'Страница не найдена';

  @override
  String get toInitialScreen => 'На начальный экран';

  @override
  String get enterPhoneNumber => 'Вход по номеру телефона';

  @override
  String get enterOnlyNumbers => 'вводите только цифры';

  @override
  String get login => 'Вход';

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
  String get initError => 'Ошибка инициализации';

  @override
  String get cancel => 'Отмена';

  @override
  String get home => 'Домой';

  @override
  String get search => 'Найти';

  @override
  String get add => 'Добавить';

  @override
  String get profile => 'Профиль';

  @override
  String get findCouple => 'Найди пару';

  @override
  String get forYourPet => 'своему\nпитомцу в любом месте';

  @override
  String get orAdd => 'Или добавь';
}
