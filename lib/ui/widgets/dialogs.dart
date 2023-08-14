import 'package:flutter/material.dart';
import 'package:movie_search/modules/account/viewModel/account_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:provider/provider.dart';

class MyDialogs {
  static Future showError(BuildContext context, {required String error, VoidCallback? onTapDismiss}) async {
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
}

class MyGoogleButton extends StatelessWidget {
  const MyGoogleButton({Key? key, this.makePop = false}) : super(key: key);

  final bool makePop;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.black,
      ),
      onPressed: () {
        context.read<AccountViewModel>().loginGoogle();
        if (makePop) Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage("assets/images/google_logo.png"),
              height: 18.0,
              width: 24,
            ),
            Padding(
              padding: EdgeInsets.only(left: 24, right: 8),
              child: Text(
                'Sign in with Google',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
