import 'package:get_it/get_it.dart';

import '../services/todos.svc.dart';

final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => TodosService());
}
