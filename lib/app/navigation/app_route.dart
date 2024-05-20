class AppRoute {
  static const initial = AppRoute('initial', '/');
  static const login = AppRoute('login', '/login');
  static const registration = AppRoute('registration', '/registration');
  static const home = AppRoute('home', '/home');
  static const petProfile = AppRoute('petProfile', 'pet-profile');
  static const petDetails = AppRoute('petDetails', 'pet-details');
  static const questionAdd = AppRoute('questionAdd', 'question-add');
  static const questionDetails =
      AppRoute('questionDetails', 'question-details');
  static const settings = AppRoute('settings', '/settings');

  final String name;
  final String path;

  const AppRoute(this.name, this.path);
}
