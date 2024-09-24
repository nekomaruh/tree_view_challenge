import 'package:tree_view_challenge/core/use_case/no_params.dart';
import 'package:tree_view_challenge/core/use_case/use_case.dart';
import 'package:tree_view_challenge/feature/home/domain/repository/company_repository.dart';

import '../entity/company.dart';

class GetCompaniesUseCase implements UseCase<NoParams, List<Company>>{
  final CompanyRepository repository;

  GetCompaniesUseCase(this.repository);

  @override
  Future<List<Company>> call(NoParams params) async {
    return await repository.getCompanies();
  }

}