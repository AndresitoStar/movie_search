import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movie_search/modules/home/home_screen.dart';
import 'package:movie_search/modules/splash/splash_viewmodel.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  static String route = "/splash";

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: model.hasError
            ? _buildError(context, model)
            : model.isBusy
                ? _buildBusyIndicator()
                : model.initialised
                    ? Builder(builder: (context) {
                        _navigateHome(context);
                        return _buildBusyIndicator();
                      })
                    : _buildEmailRequestData(model, context),
      ),
      viewModelBuilder: () => SplashViewModel(context.read()),
    );
  }

  _buildError(BuildContext context, SplashViewModel model) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.network_locked, size: 160),
            SizedBox(height: 20),
            Text(
                'Parece que ocurrio un error, verifica que tengas conexión a Internet.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 20),
            _buildUpdateBtn(model)
          ],
        ),
      );

  _buildBusyIndicator() => Center(child: CircularProgressIndicator());

  _buildEmailRequestData(SplashViewModel model, BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ReactiveForm(
        formGroup: model.form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Esta es una Version Beta de la Aplicación. Si quieres probarla introduce un correo electronico y el equipo de desarrollo te notificara cuando puedas probarla. Gracias y disculpe las molestias ocacionadas.',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            ReactiveTextField(
              formControlName: 'email',
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Color(0xfffeca4b),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Color(0xFFEEEEEE),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Color(0xFFEEEEEE),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 8.0,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
              ),
              validationMessages: (control) => {
                ValidationMessage.required:
                    'Debe introducir una dirección de correo',
                ValidationMessage.email: 'Dirección de correo inválida',
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildUpdateBtn(model),
                ReactiveFormConsumer(
                  builder: (context, formGroup, child) => ElevatedButton(
                    onPressed: formGroup.valid ? () => model.sendData() : null,
                    child: Text('Solicitar acceso'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildUpdateBtn(SplashViewModel model) => ElevatedButton(
      onPressed: () => model.validate(), child: Text('Actualizar'));

  _navigateHome(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
    });
  }
}
