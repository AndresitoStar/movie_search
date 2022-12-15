import 'package:flutter/material.dart';
import 'package:movie_search/providers/util.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class MyDialogs {
  static Future showError(BuildContext context, {required String error, VoidCallback? onTapDismiss}) async {
    PanaraInfoDialog.show(
      context,
      title: "Error",
      message: error,
      buttonText: "Ok",
      onTapDismiss: onTapDismiss ?? () => null,
      panaraDialogType: PanaraDialogType.error,
      textColor: context.theme.primaryColorDark,
    );
  }
}
