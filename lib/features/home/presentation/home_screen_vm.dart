import 'package:get_pet/app/service/logger/logger_service.dart';

class HomeScreenVm {
  HomeScreenVm() {
    _init();
  }

  void _init() {}

  void dispose() {}

  void addPet() {
    LoggerService().d('HomeScreenVm.addPet()');
  }

  void search() {
    LoggerService().d('HomeScreenVm.search()');
  }
}
