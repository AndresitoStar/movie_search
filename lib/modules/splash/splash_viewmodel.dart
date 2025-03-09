import 'package:movie_search/modules/splash/config_singleton.dart';
import 'package:movie_search/modules/splash/splash_service.dart';
import 'package:movie_search/providers/util.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends FutureViewModel {
  final SplashService _splashService;

  FormGroup form;

  bool wasHereBefore = false;

  String? get email =>
      (this.form.controls['email'] as FormControl<String>).value;

  SplashViewModel()
      : _splashService = SplashService.getInstance(),
        this.form = fb.group({
          'email': FormControl<String>(
            validators: [
              Validators.required,
              Validators.email,
            ],
            // touched: true,
          ),
        });

  @override
  Future futureToRun() async {
    setBusy(true);
    try {
      await ConfigSingleton.instance.syncGenres();
      await ConfigSingleton.instance.syncCountries();
    } catch (e) {
      print(e);
      rethrow;
    }
    checkWasHereBefore();
  }

  Future checkWasHereBefore() async {
    wasHereBefore = await SharedPreferencesHelper.wasHereBefore();
    setInitialised(true);
    setBusy(false);
  }
}
