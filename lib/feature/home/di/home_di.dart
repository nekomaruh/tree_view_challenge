import 'package:tree_view_challenge/feature/home/data/repository/company_repository_impl.dart';
import 'package:tree_view_challenge/feature/home/domain/repository/company_repository.dart';
import 'package:tree_view_challenge/feature/home/domain/use_case/get_companies_use_case.dart';

import '../../../core/di/get_it.dart';

setupHomeFeature() {
  sl.registerLazySingleton<CompanyRepository>(
    () => CompanyRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<GetCompaniesUseCase>(
        () => GetCompaniesUseCase(sl()),
  );
}
