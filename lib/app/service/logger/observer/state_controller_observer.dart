import 'package:control/control.dart';
import 'package:get_pet/app/service/logger/logger_service.dart';

final class StateControllerObserver implements IControllerObserver {
  @override
  void onCreate(Controller controller) {
    LoggerService().i('${controller.runtimeType} created');
  }

  @override
  void onStateChanged<S extends Object>(
      StateController<S> controller, S prevState, S nextState) {
    LoggerService()
        .i('${controller.runtimeType} has change: $prevState -> $nextState');
  }

  @override
  void onError(Controller controller, Object error, StackTrace stackTrace) {
    LoggerService().e('${controller.runtimeType} has error:',
        error: error, stackTrace: stackTrace);
  }

  @override
  void onDispose(Controller controller) {
    LoggerService().i('${controller.runtimeType} closed');
  }
}
