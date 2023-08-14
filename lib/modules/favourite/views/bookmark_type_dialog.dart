import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movie_search/data/firebase_database.dart';
import 'package:movie_search/modules/account/viewModel/account_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SelectBookmarkTypeDialog extends StatelessWidget {
  SelectBookmarkTypeDialog({Key? key}) : super(key: key);

  static Future<String?> show(BuildContext context) {
    return showDialog<String?>(
      context: context,
      builder: (_) => SelectBookmarkTypeDialog(),
    );
  }

  final FormControl<String> _newTypeControl = FormControl<String>(
    validators: [Validators.maxLength(50)],
  );

  final FormControl<bool> _inserting = FormControl<bool>(value: false);

  @override
  Widget build(BuildContext context) {
    try {
      final userUuid = context.read<AccountViewModel>().userUuid;
      DatabaseReference ref = FirebaseDatabase.instance.ref('${MyFirebaseService.instance.bookmarksPath}/$userUuid');

      return StreamBuilder<DatabaseEvent>(
          stream: ref.onValue,
          builder: (context, snapshot) {
            return SimpleDialog(
              title: Text('Guardar en mi lista'),
              children: snapshot.data != null
                  ? ListTile.divideTiles(
                      context: context,
                      tiles: [
                        if (snapshot.data!.snapshot.value != null)
                          ...(snapshot.data!.snapshot.value as Map).keys.map(
                                (key) => ListTile(
                                  onTap: () => _onSelected(context: context, value: key),
                                  title: Text(key, style: context.theme.textTheme.bodyLarge),
                                  tileColor: context.theme.colorScheme.background.withOpacity(0.5),
                                ),
                              ),
                        ReactiveValueListenableBuilder<bool>(
                          formControl: _inserting,
                          builder: (context, control, child) {
                            if (control.value ?? false) {
                              return Container(
                                color: context.theme.colorScheme.background.withOpacity(0.5),
                                padding: const EdgeInsets.all(8),
                                child: Card(
                                  clipBehavior: Clip.hardEdge,
                                  elevation: 0,
                                  child: ReactiveTextField(
                                    formControl: _newTypeControl,
                                    decoration: InputDecoration(
                                      filled: true,
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: () => _onSelected(context: context, value: _newTypeControl.value),
                                            borderRadius: BorderRadius.circular(20), // Radio de borde circular
                                            child: Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                color: context.theme.colorScheme.primary,
                                              ),
                                              child: Center(
                                                child: Text('OK'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      hintText: 'Ingrese su texto',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10), // Bordes redondeados
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Container(
                              color: context.theme.colorScheme.background.withOpacity(0.5),
                              padding: const EdgeInsets.all(8),
                              child: InkWell(
                                onTap: () {
                                  control.updateValue(true);
                                  SchedulerBinding.instance.addPostFrameCallback((_) {
                                    _newTypeControl.focus();
                                  });
                                },
                                child: ListTile(
                                  title: Text('Nueva Lista'),
                                  leading: Icon(Icons.add),
                                  tileColor: context.theme.colorScheme.tertiary.withOpacity(0.4),
                                ),
                              ),
                            );
                          },
                        ),
                        // ButtonBar(children: [
                        //   ElevatedButton(
                        //     onPressed: () => Navigator.of(context).pop(),
                        //     child: Text('Cancelar'),
                        //   ),
                        // ]),
                      ],
                      color: context.theme.dividerColor,
                    ).toList()
                  : [],
            );
          });
    } catch (e) {
      return PanaraInfoDialogWidget(
        title: "Error",
        message: "Ha ocurrido un error, intentelo más tarde",
        buttonText: "Ok",
        onTapDismiss: () => null,
        panaraDialogType: PanaraDialogType.error,
        textColor: context.theme.primaryColorDark,
        noImage: true,
      );
    }
  }

  _onSelected({required BuildContext context, String? value}) => Navigator.of(context).pop(value);
}
