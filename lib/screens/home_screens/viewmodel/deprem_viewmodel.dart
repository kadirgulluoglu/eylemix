import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_solution_challenge/screens/home_screens/model/deprem_model.dart';

class DepremViewModel with ChangeNotifier {
  DepremViewModel() {
    getDeprem();
  }

  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  DepremModel? depremModel;
  Future getDeprem() async {
    setState(ViewState.busy);
    Dio dio = Dio();
    var response =
        await dio.get('https://api.orhanaydogdu.com.tr/deprem/kandilli/live');
    depremModel = depremModelFromJson(response.toString());
    setState(ViewState.idle);
  }
}

enum ViewState {
  idle,
  busy,
  error,
  noData,
}
