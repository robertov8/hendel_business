// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HistoryController on HistoryControllerBase, Store {
  final _$historyAtom = Atom(name: 'HistoryControllerBase.history');

  @override
  Future<List<dynamic>> get history {
    _$historyAtom.context.enforceReadPolicy(_$historyAtom);
    _$historyAtom.reportObserved();
    return super.history;
  }

  @override
  set history(Future<List<dynamic>> value) {
    _$historyAtom.context.conditionallyRunInAction(() {
      super.history = value;
      _$historyAtom.reportChanged();
    }, _$historyAtom, name: '${_$historyAtom.name}_set');
  }

  final _$saveRequestSearchAsyncAction = AsyncAction('saveRequestSearch');

  @override
  Future saveRequestSearch(String text) {
    return _$saveRequestSearchAsyncAction
        .run(() => super.saveRequestSearch(text));
  }

  final _$removeRequestSearchAsyncAction = AsyncAction('removeRequestSearch');

  @override
  Future removeRequestSearch(String text) {
    return _$removeRequestSearchAsyncAction
        .run(() => super.removeRequestSearch(text));
  }

  final _$HistoryControllerBaseActionController =
      ActionController(name: 'HistoryControllerBase');

  @override
  dynamic getHistory() {
    final _$actionInfo = _$HistoryControllerBaseActionController.startAction();
    try {
      return super.getHistory();
    } finally {
      _$HistoryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'history: ${history.toString()}';
    return '{$string}';
  }
}
