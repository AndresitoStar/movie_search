import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/features/user/provider/user.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignUpView extends ConsumerWidget {
  SignUpView({super.key});

  final form = FormGroup(
    {
      'email': FormControl<String>(validators: [Validators.required, Validators.email]),
      'password': FormControl<String>(validators: [Validators.required, Validators.minLength(6)]),
      'confirmPassword': FormControl<String>(validators: [Validators.required, Validators.minLength(6)]),
      'showPassword': FormControl<bool>(value: false),
      'showConfirmPassword': FormControl<bool>(value: false),
    },
    validators: [Validators.mustMatch('password', 'confirmPassword')],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(isAuthLoadingProvider);

    return ReactiveForm(
      formGroup: form,
      child: Center(
        child: Hero(
          tag: 'auth_card',
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            constraints: context.isMobile ? null : BoxConstraints(maxWidth: Adaptive.px(500)),
            decoration: BoxDecoration(
              color: context.theme.cardColor,
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  color: context.theme.shadowColor.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            margin: const EdgeInsets.all(16.0),
            padding: .symmetric(vertical: 16, horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: .min,
                crossAxisAlignment: .stretch,
                children: [
                  const SizedBox(height: 20),
                  Text('Create an Account', style: context.textTheme.headlineMedium, textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  Text(
                    'Sign up to access all features including favourites and watchlist.',
                    style: context.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text('Email', style: context.textTheme.bodyLarge),
                  ),
                  const SizedBox(height: 5),
                  ReactiveTextField(
                    formControlName: 'email',
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                      hintText: 'Enter your email',
                    ),
                    validationMessages: {
                      ValidationMessage.required: (_) => 'Email is required',
                      ValidationMessage.email: (_) => 'Invalid email format',
                    },
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text('Password', style: context.textTheme.bodyLarge),
                  ),
                  const SizedBox(height: 5),
                  ReactiveValueListenableBuilder<bool>(
                    formControlName: 'showPassword',
                    builder: (context, controlShowPassword, child) {
                      return ReactiveTextField(
                        formControlName: 'password',
                        obscureText: controlShowPassword.value != true,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                          suffixIcon: IconButton(
                            icon: Icon(controlShowPassword.value != true ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              controlShowPassword.updateValue(!(controlShowPassword.value ?? false));
                              form.control('password').markAsDirty();
                            },
                          ),
                        ),
                        validationMessages: {
                          ValidationMessage.required: (_) => 'Password is required',
                          ValidationMessage.minLength: (_) => 'Password must be at least 6 characters',
                          ValidationMessage.mustMatch: (_) => 'Passwords do not match',
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text('Confirm Password', style: context.textTheme.bodyLarge),
                  ),
                  const SizedBox(height: 10),
                  ReactiveValueListenableBuilder<bool>(
                    formControlName: 'showConfirmPassword',
                    builder: (context, controlShowPassword, child) {
                      return ReactiveTextField(
                        formControlName: 'confirmPassword',
                        obscureText: controlShowPassword.value != true,
                        decoration: InputDecoration(
                          hintText: 'Confirm your password',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                          suffixIcon: IconButton(
                            icon: Icon(controlShowPassword.value != true ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              controlShowPassword.updateValue(!(controlShowPassword.value ?? false));
                              form.control('confirmPassword').markAsDirty();
                            },
                          ),
                        ),
                        validationMessages: {
                          ValidationMessage.required: (_) => 'Password is required',
                          ValidationMessage.minLength: (_) => 'Password must be at least 6 characters',
                          ValidationMessage.mustMatch: (_) => 'Passwords do not match',
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                  ReactiveFormConsumer(
                    builder: (context, formGroup, child) {
                      return ElevatedButton(
                        onPressed: formGroup.valid
                            ? () async {
                          try {
                            final email = form.control('email').value as String;
                            final password = form.control('password').value as String;
                            await ref.read(userProvider.notifier).signUpWithEmailPassword(email, password);
                          } on Exception catch (e) {
                            String message;
                            if (e is UserNotFoundException) {
                              message = e.message;
                            } else if (e is InvalidCredentialsException) {
                              message = e.message;
                            } else if (e is FirebaseAuthException) {
                              message = e.message ?? e.code;
                            } else {
                              message = 'Ocurrió un error inesperado. Intenta nuevamente.';
                            }

                            if (!context.mounted) return;
                            await context.showErrorDialog(error: message);
                          }
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.blueAccent,
                        ),
                        child: isLoading
                            ? CircularProgressIndicator.adaptive()
                            : Text('Sign Up', style: context.textTheme.bodyLarge),
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  OutlinedButton.icon(
                    onPressed: () => ref.read(userProvider.notifier).signInWithGoogle(),
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(20)),
                    icon: Image.asset('assets/images/google_logo.png', height: 24),
                    label: Text('Sign in with Google', style: context.textTheme.bodyLarge),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(child: Divider(color: context.colors.onBackground.withOpacity(0.2))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('OR', style: context.textTheme.bodySmall),
                      ),
                      Expanded(child: Divider(color: context.colors.onBackground.withOpacity(0.2))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?', style: context.textTheme.bodyMedium),
                      TextButton(
                        onPressed: () {
                          form.reset();
                          ref.read(authModeProvider.notifier).showSignIn();
                        },
                        child: Text(
                          'Sign In',
                          style: context.textTheme.bodyMedium?.copyWith(color: context.colors.secondary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
