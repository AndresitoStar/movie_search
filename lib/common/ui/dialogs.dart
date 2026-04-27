import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class MyDialogs {
  static Future showError(BuildContext context, {required String error, VoidCallback? onTapDismiss}) async {
    if (!context.mounted) return;
    return PanaraInfoDialog.show(
      context,
      title: "Error",
      message: error,
      buttonText: "Ok",
      onTapDismiss: onTapDismiss ?? context.pop,
      panaraDialogType: PanaraDialogType.error,
      textColor: context.theme.primaryColorDark,
    );
  }

  static Future<void> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) async {
    if (!context.mounted) return;
    return PanaraConfirmDialog.show(
      context,
      message: message,
      confirmButtonText: 'Aceptar',
      cancelButtonText: 'Cancelar',
      onTapConfirm: () {
        onConfirm();
        Navigator.of(context).pop();
      },
      onTapCancel: () {
        Navigator.of(context).pop();
      },
      panaraDialogType: PanaraDialogType.normal,
      title: title,
      noImage: true,
      barrierDismissible: true,
    );
  }
}
