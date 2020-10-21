import 'package:flutter/material.dart';

class UtilView {
  static Future<bool> showConfirmationDialog(BuildContext context, String title, String question,
      {Widget content, String positiveText, String negativeText}) {
    final noStyle = TextStyle(color: Colors.red);

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title ?? ''),
          titlePadding: title == null ? EdgeInsets.zero : null,
          content: content ?? Text(question ?? ''),
          actions: <Widget>[
            FlatButton(
              child: Text(
                negativeText ?? 'No',
                style: noStyle,
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
            ),
            FlatButton(
              child: Text(
                positiveText ?? 'Si',
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  static Future showLongTaskDialogDynamic(BuildContext context, Future Function() function) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          function().then((v) => Navigator.pop(context, v)).catchError((v) {
            Navigator.pop(context);
            showConfirmationDialog(context, null,
                    'Parece que no tienes conexión con el servidor, intentalo mas tarde',
                    negativeText: 'Cancelar', positiveText: 'Reintentar')
                .then((v) {
              if (v != null && v) {
                showLongTaskDialogDynamic(context, function);
              }
            });
          });
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: CircleBorder(),
            contentPadding: const EdgeInsets.all(10),
            content: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 10,
                )),
          );
        }).catchError((v) {
      showConfirmationDialog(
              context, null, 'Parece que no tienes conexión con el servidor, intentalo mas tarde',
              negativeText: 'Cancelar', positiveText: 'Reintentar')
          .then((v) {
        if (v != null && v) {
          showLongTaskDialogDynamic(context, function);
        }
      });
    });
  }
}
