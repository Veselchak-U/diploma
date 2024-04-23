import 'package:get_it/get_it.dart';
import 'package:get_pet/app/service/info/info_service.dart';
import 'package:get_pet/app/service/lifecycle/lifecycle_controller.dart';
import 'package:get_pet/app/service/storage/local_storage.dart';
import 'package:get_pet/app/service/storage/remote_storage.dart';
import 'package:get_pet/features/initial/domain/logic/initial_controller.dart';
import 'package:get_pet/features/login/data/datasource/login_datasource.dart';
import 'package:get_pet/features/login/data/repository/login_repository.dart';
import 'package:get_pet/features/login/domain/logic/login_controller.dart';

class DI {
  static final _sl = GetIt.instance;

  static T get<T extends Object>() => _sl<T>();

  Future<void> init() async {
    await _services();
    _dataSources();
    _repositories();
    _businessLogic();
  }

  Future<void> _services() async {
    final localStorage = await LocalStorageImpl().init();
    _sl.registerSingleton<LocalStorage>(localStorage);
    _sl.registerSingleton<RemoteStorage>(RemoteStorageImpl());
    _sl.registerSingleton<InfoService>(InfoServiceImpl());
  }

  void _dataSources() {
    _sl.registerLazySingleton<LoginDatasource>(
        () => LoginDatasourceImpl(_sl<RemoteStorage>()));
  }

  void _repositories() {
    _sl.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImpl(_sl<LoginDatasource>()));
  }

  void _businessLogic() {
    _sl.registerLazySingleton(() => LifecycleController());
    _sl.registerFactory(() => InitialController(
          _sl<LocalStorage>(),
        ));
    _sl.registerFactory(() => LoginController(
          _sl<LoginRepository>(),
          _sl<LocalStorage>(),
        ));
  }
}
