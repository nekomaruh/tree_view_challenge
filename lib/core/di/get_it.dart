import 'package:get_it/get_it.dart';
import 'package:tree_view_challenge/feature/home/di/home_di.dart';

import '../network/api_client.dart';

final sl = GetIt.instance;

void setupDI() {
  const String baseUrl = "https://fake-api.tractian.com";
  sl.registerLazySingleton<ApiClient>(() => ApiClient(baseUrl));
  setupHomeFeature();
}
