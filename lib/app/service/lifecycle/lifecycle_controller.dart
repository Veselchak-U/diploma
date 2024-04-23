import 'dart:async';
import 'dart:ui';

import 'package:control/control.dart';
import 'package:get_pet/app/service/logger/logger_service.dart';

part 'lifecycle_controller_state.dart';

final class LifecycleController
    extends StateController<LifecycleControllerState>
    with DroppableControllerHandler {
  LifecycleController({
    super.initialState = const LifecycleController$Idle(),
  });

  bool _wasInBackground = false;

  void onStateChanged(AppLifecycleState state) {
    return handle(
      () async {
        LoggerService().d('LifecycleController: $state');
        setState(LifecycleController$Changed(state));

        switch (state) {
          case AppLifecycleState.hidden:
          case AppLifecycleState.paused:
            _wasInBackground = true;
          case AppLifecycleState.resumed:
            if (!_wasInBackground) break;

            _wasInBackground = false;
          default:
            break;
        }
      },
      _errorHandler,
      _doneHandler,
    );
  }

  FutureOr<void> _errorHandler(Object e, StackTrace st) {
    setState(LifecycleController$Error(e));
  }

  FutureOr<void> _doneHandler() {
    setState(const LifecycleController$Idle());
  }
}
