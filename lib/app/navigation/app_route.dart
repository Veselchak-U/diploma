class AppRoute {
  static const initial = AppRoute('initial', '/');
  static const login = AppRoute('login', '/login');
  static const home = AppRoute('home', '/home');
  static const settings = AppRoute('settings', '/settings');

  final String name;
  final String path;

  const AppRoute(this.name, this.path);
}
