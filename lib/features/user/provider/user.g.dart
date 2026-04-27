// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserNotifier)
final userProvider = UserNotifierProvider._();

final class UserNotifierProvider
    extends $NotifierProvider<UserNotifier, UserState> {
  UserNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userNotifierHash();

  @$internal
  @override
  UserNotifier create() => UserNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserState>(value),
    );
  }
}

String _$userNotifierHash() => r'875d4da7833f01e59b5fe673d1c620e06f28bc16';

abstract class _$UserNotifier extends $Notifier<UserState> {
  UserState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<UserState, UserState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserState, UserState>,
              UserState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Provider to get the current user UUID

@ProviderFor(userUuid)
final userUuidProvider = UserUuidProvider._();

/// Provider to get the current user UUID

final class UserUuidProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  /// Provider to get the current user UUID
  UserUuidProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userUuidProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userUuidHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return userUuid(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$userUuidHash() => r'4117fe2ffef3143c91e87541741fad29aeb7bd56';

/// Provider to check if user is authenticated

@ProviderFor(isAuthenticated)
final isAuthenticatedProvider = IsAuthenticatedProvider._();

/// Provider to check if user is authenticated

final class IsAuthenticatedProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider to check if user is authenticated
  IsAuthenticatedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isAuthenticatedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isAuthenticatedHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isAuthenticated(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isAuthenticatedHash() => r'88f6041d0672c2fc59fd97d55d7c9fe392f1fe1c';

/// Provider to get the authentication provider used

@ProviderFor(authProviderType)
final authProviderTypeProvider = AuthProviderTypeProvider._();

/// Provider to get the authentication provider used

final class AuthProviderTypeProvider
    extends $FunctionalProvider<AuthProvider, AuthProvider, AuthProvider>
    with $Provider<AuthProvider> {
  /// Provider to get the authentication provider used
  AuthProviderTypeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProviderTypeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authProviderTypeHash();

  @$internal
  @override
  $ProviderElement<AuthProvider> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthProvider create(Ref ref) {
    return authProviderType(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthProvider value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthProvider>(value),
    );
  }
}

String _$authProviderTypeHash() => r'9faf4c024a1bcd5c8181ef1add3c7034cb95429c';

/// Provider to check if an auth operation is in progress

@ProviderFor(isAuthLoading)
final isAuthLoadingProvider = IsAuthLoadingProvider._();

/// Provider to check if an auth operation is in progress

final class IsAuthLoadingProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider to check if an auth operation is in progress
  IsAuthLoadingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isAuthLoadingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isAuthLoadingHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isAuthLoading(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isAuthLoadingHash() => r'e4d350797b8b04b7220994579d6cdba49aab9b1a';

/// Provider to manage auth mode (sign in vs sign up)

@ProviderFor(AuthModeNotifier)
final authModeProvider = AuthModeNotifierProvider._();

/// Provider to manage auth mode (sign in vs sign up)
final class AuthModeNotifierProvider
    extends $NotifierProvider<AuthModeNotifier, AuthMode> {
  /// Provider to manage auth mode (sign in vs sign up)
  AuthModeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authModeNotifierHash();

  @$internal
  @override
  AuthModeNotifier create() => AuthModeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthMode>(value),
    );
  }
}

String _$authModeNotifierHash() => r'6820ca8e16009d303b4f37280e2e259ae012042c';

/// Provider to manage auth mode (sign in vs sign up)

abstract class _$AuthModeNotifier extends $Notifier<AuthMode> {
  AuthMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AuthMode, AuthMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthMode, AuthMode>,
              AuthMode,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Provider to check if currently showing sign in

@ProviderFor(isSignInMode)
final isSignInModeProvider = IsSignInModeProvider._();

/// Provider to check if currently showing sign in

final class IsSignInModeProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider to check if currently showing sign in
  IsSignInModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isSignInModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isSignInModeHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isSignInMode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isSignInModeHash() => r'12a29cfe8c2cc81d2fb9838ad5574dfa3aff6028';

/// Provider to check if currently showing sign up

@ProviderFor(isSignUpMode)
final isSignUpModeProvider = IsSignUpModeProvider._();

/// Provider to check if currently showing sign up

final class IsSignUpModeProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Provider to check if currently showing sign up
  IsSignUpModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isSignUpModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isSignUpModeHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isSignUpMode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isSignUpModeHash() => r'eb82a45bcecb51ead2453d4ca9ba019ae6f4a614';
