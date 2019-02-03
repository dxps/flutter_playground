import './base_smc.dart';
export './base_smc.dart';

/// Main SMC.
class MainSmc extends BaseSmc {
  //
  final String stateId = "MainState";

  int _counter = 0;
  String _errorMsg = "";

  void doIncrementCounter() {
    _counter++;
    _errorMsg = (_counter < 0) ? "You should be positive." : "";
    rebuildStates(ids: [stateId]);
  }

  void doDecrementCounter() {
    _counter--;
    _errorMsg = (_counter < 0) ? "You should be positive." : "";
    rebuildStates(ids: [stateId]);
  }

  int get getCounter => _counter;
  String get getErrorMsg => _errorMsg;

  //
}

MainSmc mainSmc; // declared here, instantiated in runApp(_)
