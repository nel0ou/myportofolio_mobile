import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';

class AuthGuard extends StatelessWidget {
  const AuthGuard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthState>();

    if (authState.isLoggedIn) {
      return child;
    }

    return LoginScreen();
  }
}
