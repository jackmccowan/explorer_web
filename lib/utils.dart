  import 'package:provider/provider.dart';  
  import 'package:explorer_web/services/auth/auth_service.dart';
  import 'package:flutter/material.dart';

  void signOut(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  const String explorerLogo = 'assets/images/explorerLogoBlue.png';
  const String explorerLogoWhite = 'assets/images/explorerLogoWhite.png';
  const String homeLogo = 'assets/images/home.png';

