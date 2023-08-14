import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_search/main.dart';
import 'package:movie_search/modules/favourite/viewmodel/favourite_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class AccountViewModel extends BaseViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String? userUuid;
  String? displayName;
  String? photoUrl;

  bool get isLogged => userUuid != null;

  checkUserLogged() async {
    setBusy(true);
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        displayName = user.displayName;
        photoUrl = user.photoURL;
        userUuid = user.uid;
        globalNavigatorKey.currentContext?.read<FavouritesViewModel>().initialize(userUuid);
      }
    } catch (e) {}
    setBusy(false);
  }

  Future loginGoogle() async {
    setBusy(true);
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        print('akiii');
        GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        UserCredential authResult = await _auth.signInWithCredential(credential);
        print('akiii');
        if (authResult.user != null) {
          assert(!authResult.user!.isAnonymous);
          assert(await authResult.user!.getIdToken() != null);
          User? currentUser = await _auth.currentUser;
          assert(authResult.user!.uid == currentUser?.uid);
          checkUserLogged();
        }
      }
    } catch (e) {
      print(e);
    }
    setBusy(false);
  }

  logout() async {
    setBusy(true);
    try {
      await _googleSignIn.signOut();
      displayName = null;
      photoUrl = null;
      userUuid = null;
      globalNavigatorKey.currentContext?.read<FavouritesViewModel>().logout();
    } catch (e) {}
    setBusy(false);
  }
}
