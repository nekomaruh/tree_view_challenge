import 'package:tree_view_challenge/feature/home/domain/repository/company_repository.dart';

import '../../../../core/usecase/no_params.dart';
import '../../../../core/usecase/use_case.dart';
import '../entity/company.dart';

class GetCompaniesUseCase implements UseCase<NoParams, List<Company>>{
  final CompanyRepository repository;

  GetCompaniesUseCase(this.repository);

  @override
  Future<List<Company>> call(NoParams params) async {
    return await repository.getCompanies();
  }

}