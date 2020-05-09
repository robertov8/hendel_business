import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'history_controller.g.dart';

class HistoryController = HistoryControllerBase with _$HistoryController;

abstract class HistoryControllerBase with Store {
  @observable
  Future<List> history;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @action
  getHistory() {
    history = _prefs.then((SharedPreferences prefs) {
      return prefs.getStringList('history') ?? [];
    });
  }

  @action
  saveRequestSearch(String text) async {
    final SharedPreferences prefs = await _prefs;
    final historyPrefs = prefs.getStringList('history') ?? [];

    historyPrefs.add(text);

    history = prefs.setStringList('history', historyPrefs).then((bool success) {
      return historyPrefs.reversed.toList();
    });
  }

  @action
  removeRequestSearch(String text) async {
    final SharedPreferences prefs = await _prefs;
    final historyPrefs = prefs.getStringList('history') ?? [];

    historyPrefs.remove(text);

    history = prefs.setStringList('history', historyPrefs).then((bool success) {
      return historyPrefs.reversed.toList();
    });
  }
}
