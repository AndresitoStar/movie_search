import 'package:flutter/material.dart';
import 'package:movie_search/modules/account/viewModel/account_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyDialogs {
  static Future showError(BuildContext context,
      {required String error, VoidCallback? onTapDismiss}) async {
    if (!context.mounted) return;
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

  static Future showLoginDialog(BuildContext context) async {
    if (!context.mounted) return;
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Bienvenido'),
        contentPadding: const EdgeInsets.all(20),
        children: [
          MyGoogleButton(makePop: true),
        ],
      ),
    );
  }

  static showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
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

  static Future showLoginModalBottomSheet(BuildContext context) async {
    if (!context.mounted) return;
    return showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 45.w),
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          ListTile(
            title: Text('Tus Favoritos',
                style: Theme.of(context).textTheme.headlineSmall),
            subtitle: Text(
              'Autenticate con Google para guardar tus listas de favoritos',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: MyGoogleButton(makePop: true),
          ),
        ],
      ),
    );
  }
}

class MyGoogleButton extends StatelessWidget {
  const MyGoogleButton({Key? key, this.makePop = false}) : super(key: key);

  final bool makePop;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
            width: 1, color: Theme.of(context).colorScheme.onSurface),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: () {
        context.read<AccountViewModel>().loginGoogle();
        if (makePop) Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Image(
              image: AssetImage("assets/images/google_logo.png"),
              height: 18.0,
              width: 24,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                'Sign in with Google',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
