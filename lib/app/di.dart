import 'package:get_it/get_it.dart';
import 'package:get_pet/app/service/info/info_service.dart';
import 'package:get_pet/app/service/lifecycle/lifecycle_controller.dart';
import 'package:get_pet/app/service/storage/local_storage.dart';
import 'package:get_pet/app/service/storage/remote_file_storage.dart';
import 'package:get_pet/app/service/storage/remote_storage.dart';
import 'package:get_pet/features/home/data/datasource/pet_datasource.dart';
import 'package:get_pet/features/home/data/datasource/questions_datasource.dart';
import 'package:get_pet/features/home/data/repository/pet_repository.dart';
import 'package:get_pet/features/home/data/repository/question_repository.dart';
import 'package:get_pet/features/home/domain/logic/pet_common/pet_common_controller.dart';
import 'package:get_pet/features/home/domain/logic/pet_details/pet_details_controller.dart';
import 'package:get_pet/features/home/domain/logic/pet_profile/pet_profile_controller.dart';
import 'package:get_pet/features/home/domain/logic/support/support_controller.dart';
import 'package:get_pet/features/initial/domain/logic/initial_controller.dart';
import 'package:get_pet/features/login/data/datasource/login_datasource.dart';
import 'package:get_pet/features/login/data/datasource/user_datasource.dart';
import 'package:get_pet/features/login/data/repository/login_repository.dart';
import 'package:get_pet/features/login/data/repository/user_repository.dart';
import 'package:get_pet/features/login/domain/logic/user_controller.dart';
import 'package:get_pet/features/search/domain/logic/pet_search_controller.dart';

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
    _sl.registerSingleton<RemoteFileStorage>(RemoteFileStorageImpl(
      _sl<LocalStorage>(),
    ));
    _sl.registerSingleton<InfoService>(InfoServiceImpl());
  }

  void _dataSources() {
    _sl.registerLazySingleton<UserDatasource>(
        () => UserDatasourceImpl(_sl<RemoteStorage>()));
    _sl.registerLazySingleton<LoginDatasource>(() => LoginDatasourceImpl());
    _sl.registerLazySingleton<PetDatasource>(
        () => PetDatasourceImpl(_sl<RemoteStorage>()));
    _sl.registerLazySingleton<QuestionDatasource>(
        () => QuestionDatasourceImpl(_sl<RemoteStorage>()));
  }

  void _repositories() {
    _sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
          _sl<UserDatasource>(),
          _sl<LoginDatasource>(),
          _sl<LocalStorage>(),
          _sl<PetDatasource>(),
          _sl<QuestionDatasource>(),
        ));
    _sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
          _sl<UserDatasource>(),
          _sl<LocalStorage>(),
        ));
    _sl.registerLazySingleton<PetRepository>(() => PetRepositoryImpl(
          _sl<PetDatasource>(),
          _sl<LocalStorage>(),
        ));
    _sl.registerLazySingleton<QuestionRepository>(() => QuestionRepositoryImpl(
          _sl<QuestionDatasource>(),
          _sl<LocalStorage>(),
        ));
  }

  void _businessLogic() {
    _sl.registerLazySingleton(() => LifecycleController());
    _sl.registerFactory(() => InitialController(
          _sl<LocalStorage>(),
          _sl<UserRepository>(),
        ));
    _sl.registerFactory(() => UserController(
          _sl<LoginRepository>(),
          _sl<UserRepository>(),
          _sl<RemoteFileStorage>(),
        ));
    _sl.registerLazySingleton(() => PetCommonController(
          _sl<PetRepository>(),
        ));
    _sl.registerLazySingleton(() => PetProfileController(
          _sl<PetRepository>(),
          _sl<RemoteFileStorage>(),
        ));
    _sl.registerFactory(() => PetDetailsController(
          _sl<UserRepository>(),
          _sl<PetRepository>(),
        ));
    _sl.registerLazySingleton(() => SupportController(
          _sl<QuestionRepository>(),
          _sl<RemoteFileStorage>(),
          _sl<LocalStorage>(),
        ));
    _sl.registerLazySingleton(() => PetSearchController(
          _sl<PetRepository>(),
        ));
  }
}
