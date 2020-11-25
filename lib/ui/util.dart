import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

class UtilView {
  static String getMessage(Exception e) {
    if (e is SocketException) return 'Parece que no tienes internet.';
    return e.toString();
  }

  static Future<T> runLongTaskFromServer<T>(
      BuildContext context, Future<T> Function() function) async {
    return function().catchError((v) => CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: getMessage(v),
          confirmBtnText: 'Reintentar',
          onConfirmBtnTap: () => Navigator.of(context).pop(true),
        ).then((v) {
          if (v != null && v) {
            runLongTaskFromServer(context, function);
            Navigator.of(context);
          }
        }));
  }

  static Future<T> runLongTaskFromServerAlter<T>(
      BuildContext context, Future<T> Function() function) async {
    return function().catchError((v) => showDialog(
          context: context,
          builder: (context) => Stack(
            alignment: Alignment.topCenter,
            fit: StackFit.loose,
            children: [
              AlertDialog(
                content: Text(getMessage(v)),
                actions: [
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Reintentar'))
                ],
              ),
              CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),
        ).then((v) {
          if (v != null && v) {
            runLongTaskFromServer(context, function);
          }
        }));
  }
}
