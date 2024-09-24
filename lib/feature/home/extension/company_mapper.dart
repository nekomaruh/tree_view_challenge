import 'package:tree_view_challenge/feature/home/data/model/company_model_response.dart';

import '../domain/entity/company.dart';

extension CompanyMapper on CompanyResponseModel {
  Company toDomain() {
    return Company(id: id, name: name);
  }
}

extension CompanyModelListMapper on List<CompanyResponseModel> {
  List<Company> toDomainList() {
    return map((model) => model.toDomain()).toList();
  }
}