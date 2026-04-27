import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/ui/scaffold.dart';
import 'package:movie_search/features/user/provider/user.dart';
import 'package:movie_search/features/user/ui/guest_user_view.dart';
import 'package:movie_search/features/user/ui/logged_user_view.dart';
import 'package:movie_search/features/user/ui/sign_up_view.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(isAuthenticatedProvider);
    final isSignIn = ref.watch(isSignInModeProvider);

    return CustomScaffold(
      bottomBarIndex: 2,
      appBar: CustomScaffoldAppbar(bottomBarIndex: 2, title: !context.isMobile ? null : Text('Profile')),
      body: isLoggedIn
          ? LoggedUserView()
          : isSignIn
          ? SignInView()
          : SignUpView(),
      forceAppbar: true,
    );
  }
}
