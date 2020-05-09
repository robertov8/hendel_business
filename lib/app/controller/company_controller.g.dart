// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CompanyController on CompanyControllerBase, Store {
  final _$loadingAtom = Atom(name: 'CompanyControllerBase.loading');

  @override
  bool get loading {
    _$loadingAtom.context.enforceReadPolicy(_$loadingAtom);
    _$loadingAtom.reportObserved();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.context.conditionallyRunInAction(() {
      super.loading = value;
      _$loadingAtom.reportChanged();
    }, _$loadingAtom, name: '${_$loadingAtom.name}_set');
  }

  final _$companiesAtom = Atom(name: 'CompanyControllerBase.companies');

  @override
  List<CompanyResponse> get companies {
    _$companiesAtom.context.enforceReadPolicy(_$companiesAtom);
    _$companiesAtom.reportObserved();
    return super.companies;
  }

  @override
  set companies(List<CompanyResponse> value) {
    _$companiesAtom.context.conditionallyRunInAction(() {
      super.companies = value;
      _$companiesAtom.reportChanged();
    }, _$companiesAtom, name: '${_$companiesAtom.name}_set');
  }

  final _$getDataCompaniesAsyncAction = AsyncAction('getDataCompanies');

  @override
  Future<Null> getDataCompanies() {
    return _$getDataCompaniesAsyncAction.run(() => super.getDataCompanies());
  }

  final _$CompanyControllerBaseActionController =
      ActionController(name: 'CompanyControllerBase');

  @override
  List<CompanyResponse> getCompaniesByCategory(int id) {
    final _$actionInfo = _$CompanyControllerBaseActionController.startAction();
    try {
      return super.getCompaniesByCategory(id);
    } finally {
      _$CompanyControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'loading: ${loading.toString()},companies: ${companies.toString()}';
    return '{$string}';
  }
}
