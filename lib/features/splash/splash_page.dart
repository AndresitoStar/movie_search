import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends HookWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future<void> loadData() async {
        await Future.delayed(const Duration(seconds: 1));

        if (context.mounted) {
          context.pushReplacement('/home');
        }
      }

      loadData();

      return null; // cleanup no necesario
    }, const []); // solo se ejecuta una vez

    return const Material(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
