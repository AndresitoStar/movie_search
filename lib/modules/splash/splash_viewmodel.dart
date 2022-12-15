import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/splash/splash_service.dart';
import 'package:movie_search/providers/util.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends FutureViewModel {
  final MyDatabase _db;
  final SplashService _splashService;

  FormGroup form;

  bool wasHereBefore = false;

  String? get email => (this.form.controls['email'] as FormControl<String>).value;

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
    setBusy(true);
    await syncGenres('movie');
    await syncGenres('tv');
    checkWasHereBefore();
  }

  Future checkWasHereBefore() async {
    wasHereBefore = await SharedPreferencesHelper.wasHereBefore();
    setInitialised(true);
    setBusy(false);
  }

  Future validate() async {
    setBusy(true);
    if (kIsWeb || Platform.isWindows) {
      setInitialised(true);
      setBusy(false);
      return;
    }
    AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    String phoneModel = '${androidInfo.brand} ${androidInfo.model}';
    await _splashService.updateMyDevice(androidInfo.androidId!, phoneModel: phoneModel);
    final isEnabled = await _splashService.checkIsDeviceEnable(androidInfo.androidId!);
    setInitialised(isEnabled);
    setBusy(false);
  }

  Future sendData() async {
    setBusy(true);
    AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    String phoneModel = '${androidInfo.brand} ${androidInfo.model}';
    await _splashService.updateMyDevice(androidInfo.androidId!, email: email, phoneModel: phoneModel);
    setBusy(false);
    form.reset();
  }

  Future syncGenres(String type) async {
    try {
      var bool = await _db.existGenres(type);
      if (bool) return;
      var genres = await _splashService.getGenres(type);
      final dbGenres = genres.entries
          .map((entry) => GenreTableData(id: entry.key.toString(), name: entry.value, type: type))
          .toList();
      await _db.insertGenres(dbGenres);
    } catch (e) {
      print(e);
    }
  }
}
