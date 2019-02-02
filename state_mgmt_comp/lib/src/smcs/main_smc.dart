import './base_smc.dart';
export './base_smc.dart';

/// Main SMC.
class MainSmc extends BaseSmc {
  //

  int _counter = 0;

  void doIncrementCounter() {
    _counter++;
    rebuildStates(ids: ["CounterText"]);
  }

  int get counter => _counter;

  //
}

MainSmc mainSmc; // declared here, instantiated in runApp(_)
