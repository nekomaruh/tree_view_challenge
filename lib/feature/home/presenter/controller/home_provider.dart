import 'package:flutter/foundation.dart';
import 'package:tree_view_challenge/core/use_case/no_params.dart';

import '../../../../core/state/ui_state.dart';
import '../../domain/entity/company.dart';
import '../../domain/use_case/get_companies_use_case.dart';

class HomeProvider with ChangeNotifier {
  final GetCompaniesUseCase getCompanies;

  UiState<List<Company>> _uiState = UiState.init();

  UiState<List<Company>> get uiState => _uiState;

  HomeProvider(this.getCompanies){
    fetchCompanies();
  }

  fetchCompanies() async {
    _uiState = _uiState.copyWith(isLoading: true);
    notifyListeners();
    try {
      final companies = await getCompanies(NoParams());
      _uiState = _uiState.copyWith(
        isLoading: false,
        data: companies,
      );
    } catch (e) {
      _uiState = _uiState.copyWith(
        isLoading: false,
        error: 'Error al cargar los datos',
      );
    }

    notifyListeners();
  }
}

