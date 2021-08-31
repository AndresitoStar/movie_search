import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

class BottomBarViewModel extends BaseViewModel {
  String data = '-';

  updateData(String data) {
    this.data = data;
    notifyListeners();
  }

  static void changePageData(BuildContext context, String data) {
    final BottomBarViewModel model = context.read();
    model.updateData(data);
  }
}