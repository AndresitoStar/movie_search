import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user.g.dart';

enum AuthProvider { google, apple, emailPassword, none }

enum AuthMode { signIn, signUp }

class UserState {
  final String? uuid;
  final AuthProvider authProvider;
  final bool isAuthenticated;
  final bool isLoading;

  UserState({this.uuid, this.authProvider = AuthProvider.none, this.isLoading = false})
    : isAuthenticated = uuid != null;

  UserState copyWith({String? uuid, AuthProvider? authProvider, bool? isLoading}) {
    return UserState(
      uuid: uuid ?? this.uuid,
      authProvider: authProvider ?? this.authProvider,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn get _googleSignIn => GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;

  @override
  UserState build() {
    // Initialize with current Firebase user if exists
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      // Determine auth provider from user's provider data
      AuthProvider provider = AuthProvider.none;
      for (var userInfo in currentUser.providerData) {
        if (userInfo.providerId == 'google.com') {
          provider = AuthProvider.google;
          break;
        } else if (userInfo.providerId == 'apple.com') {
          provider = AuthProvider.apple;
          break;
        } else if (userInfo.providerId == 'password') {
          provider = AuthProvider.emailPassword;
          break;
        }
      }

      return UserState(uuid: currentUser.uid, authProvider: provider);
    }

    return UserState();
  }

  /// Initialize Google Sign-In (required for version 7.x)
  Future<void> _initializeGoogleSignIn() async {
    if (!_isGoogleSignInInitialized) {
      await _googleSignIn.initialize();
      _isGoogleSignInInitialized = true;
    }
  }

  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      // Set loading state
      state = state.copyWith(isLoading: true);

      // Initialize Google Sign-In if not already done
      await _initializeGoogleSignIn();

      // Trigger the authentication flow (replaces signIn() in v7.x)
      final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();

      if (googleUser == null) {
        // User canceled the sign-in
        state = state.copyWith(isLoading: false);
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // In google_sign_in 7.x, GoogleSignInAuthentication only has idToken
      // For Firebase, we can use just the idToken
      final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);

      // Sign in to Firebase with the Google credential
      final userCredential = await _auth.signInWithCredential(credential);

      state = UserState(uuid: userCredential.user?.uid, authProvider: AuthProvider.google, isLoading: false);
    } catch (e) {
      // Clear loading state on error
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  /// Sign in with Apple
  Future<void> signInWithApple() async {
    try {
      // Set loading state
      state = state.copyWith(isLoading: true);

      // Create an OAuthProvider for Apple
      final appleProvider = OAuthProvider('apple.com');

      // Configure the request
      appleProvider.addScope('email');
      appleProvider.addScope('name');

      // Sign in with Apple
      final userCredential = await _auth.signInWithProvider(appleProvider);

      state = UserState(uuid: userCredential.user?.uid, authProvider: AuthProvider.apple, isLoading: false);
    } catch (e) {
      // Clear loading state on error
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  /// Sign in with email and password
  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      // Set loading state
      state = state.copyWith(isLoading: true);

      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      state = UserState(uuid: userCredential.user?.uid, authProvider: AuthProvider.emailPassword, isLoading: false);
    } catch (e) {
      // Clear loading state on error
      state = state.copyWith(isLoading: false);
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          throw UserNotFoundException();
        } else if (e.code == 'wrong-password') {
          throw InvalidCredentialsException();
        }
      }
      rethrow;
    }
  }

  /// Sign up with email and password
  Future<void> signUpWithEmailPassword(String email, String password) async {
    try {
      // Set loading state
      state = state.copyWith(isLoading: true);

      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      state = UserState(uuid: userCredential.user?.uid, authProvider: AuthProvider.emailPassword, isLoading: false);
    } catch (e) {
      // Clear loading state on error
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      // Handle errors
      rethrow;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      // Sign out from Google if needed
      if (state.authProvider == AuthProvider.google) {
        await _googleSignIn.signOut();
      }

      // Sign out from Firebase
      await _auth.signOut();

      state = UserState();
    } catch (e) {
      // Handle errors
      rethrow;
    }
  }
}

/// Provider to get the current user UUID
@riverpod
String? userUuid(ref) {
  final userState = ref.watch(userProvider);
  return userState.uuid;
}

/// Provider to check if user is authenticated
@riverpod
bool isAuthenticated(ref) {
  final userState = ref.watch(userProvider);
  return userState.isAuthenticated;
}

/// Provider to get the authentication provider used
@riverpod
AuthProvider authProviderType(ref) {
  final userState = ref.watch(userProvider);
  return userState.authProvider;
}

/// Provider to check if an auth operation is in progress
@riverpod
bool isAuthLoading(ref) {
  final userState = ref.watch(userProvider);
  return userState.isLoading;
}

class UserNotFoundException implements Exception {
  final String message;
  UserNotFoundException([this.message = 'User not found']);

  @override
  String toString() => 'UserNotFoundException: $message';
}

class InvalidCredentialsException implements Exception {
  final String message;
  InvalidCredentialsException([this.message = 'Invalid credentials']);

  @override
  String toString() => 'InvalidCredentialsException: $message';
}

/// Provider to manage auth mode (sign in vs sign up)
@Riverpod(keepAlive: false)
class AuthModeNotifier extends _$AuthModeNotifier {
  @override
  AuthMode build() {
    return AuthMode.signIn; // Default to sign in
  }

  /// Switch to sign in mode
  void showSignIn() {
    state = AuthMode.signIn;
  }

  /// Switch to sign up mode
  void showSignUp() {
    state = AuthMode.signUp;
  }

  /// Toggle between sign in and sign up
  void toggle() {
    state = state == AuthMode.signIn ? AuthMode.signUp : AuthMode.signIn;
  }
}

/// Provider to check if currently showing sign in
@riverpod
bool isSignInMode(ref) {
  final mode = ref.watch(authModeProvider);
  return mode == AuthMode.signIn;
}

/// Provider to check if currently showing sign up
@riverpod
bool isSignUpMode(ref) {
  final mode = ref.watch(authModeProvider);
  return mode == AuthMode.signUp;
}
