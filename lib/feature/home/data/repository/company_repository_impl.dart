import 'package:tree_view_challenge/core/network/api_client.dart';
import 'package:tree_view_challenge/feature/home/data/model/company_model_response.dart';
import 'package:tree_view_challenge/feature/home/domain/entity/company.dart';
import 'package:tree_view_challenge/feature/home/domain/repository/company_repository.dart';
import 'package:tree_view_challenge/feature/home/extension/company_mapper.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final ApiClient client;

  CompanyRepositoryImpl(this.client);

  @override
  Future<List<Company>> getCompanies() async {
    final response = await client.get("/companies") as List<dynamic>;
    final list = response.map((e) => CompanyResponseModel.fromJson(e)).toList();
    return list.toDomainList();
  }
}
