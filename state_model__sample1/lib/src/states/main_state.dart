import './state_model.dart';
export './state_model.dart';

/// Main SMC.
class MainState extends StateModel {
  //
  final String stateId = "MainState";

  int _counter = 0;
  String _errorMsg = "";

  void doIncrementCounter() {
    _counter++;
    _errorMsg = (_counter < 0) ? "You should be positive." : "";
    updateStates(ids: [stateId]);
  }

  void doDecrementCounter() {
    _counter--;
    _errorMsg = (_counter < 0) ? "You should be positive." : "";
    updateStates(ids: [stateId]);
  }

  int get getCounter => _counter;
  String get getErrorMsg => _errorMsg;

  //
}

MainState mainState; // declared here, instantiated in runApp(_)
