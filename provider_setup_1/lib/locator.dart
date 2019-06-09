import 'package:get_it/get_it.dart';
import 'package:provider_setup_1/core/services/api.dart';
import 'package:provider_setup_1/core/services/auth_svc.dart';
import 'core/viewmodels/comments_model.dart';
import 'core/viewmodels/home_model.dart';
import 'core/viewmodels/login_model.dart';

GetIt locator = GetIt();

///
void setupLocator() {
  //

  // registering singletons for models and services
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => LoginModel());
  locator.registerLazySingleton(() => HomeModel());

  // registering factories
  locator.registerFactory(() => CommentsModel());

  //
}
