import 'package:stacked/stacked.dart';

class DialogImageViewModel extends BaseViewModel {
  int index;
  final int length;

  DialogImageViewModel({this.index, this.length});

  updateIndex(int index) {
    this.index = index;
    notifyListeners();
  }

  bool get canGoBack => index > 0;
  bool get canGoForward => index < length - 1;


}