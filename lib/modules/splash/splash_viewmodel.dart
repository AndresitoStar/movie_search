import 'package:device_info/device_info.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/splash/splash_service.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends FutureViewModel {
  final MyDatabase _db;
  final SplashService _splashService;

  FormGroup form;

  String get email => this.form.controls['email'].value;

  SplashViewModel(this._db)
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
    return Future.wait([
      validate(),
      syncCountries(),
      syncLanguages(),
      syncGenres('movie'),
      syncGenres('tv'),
    ]);
  }

  Future validate() async {
    AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    final isEnabled =
        await _splashService.checkIsDeviceEnable(androidInfo.androidId);
    setInitialised(isEnabled);
  }

  Future sendData() async {
    setBusy(true);
    AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    await _splashService.updateMyDevice(androidInfo.androidId, email);
    setBusy(false);
    form.reset();
  }

  Future syncCountries() async {
    try {
      final bool = await _db.existCountries();
      if (bool) return;
      var countries = await _splashService.getCountries();
      final dbCountries = countries.entries
          .map((entry) => CountryTableData(iso: entry.key, name: entry.value))
          .toList();
      await _db.insertCountries(dbCountries);
    } catch (e) {
      print(e);
    }
  }

  Future syncLanguages() async {
    try {
      var bool = await _db.existLanguages();
      if (bool) return;
      var countries = await _splashService.getLanguages();
      final dbLanguages = countries.entries
          .map((entry) => LanguageTableData(iso: entry.key, name: entry.value))
          .toList();
      await _db.insertLanguages(dbLanguages);
    } catch (e) {
      print(e);
    }
  }

  Future syncGenres(String type) async {
    try {
      var bool = await _db.existGenres(type);
      if (bool) return;
      var genres = await _splashService.getGenres(type);
      final dbGenres = genres.entries
          .map((entry) => GenreTableData(
              id: entry.key?.toString(), name: entry.value, type: type))
          .toList();
      await _db.insertGenres(dbGenres);
    } catch (e) {
      print(e);
    }
  }
}
