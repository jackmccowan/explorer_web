import 'package:explorer_web/services/auth/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:explorer_web/services/auth/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC2dNPN7-5C7Af4wcmJGM63rOWTX_H5Jns",
      projectId: "explorer-c3f3d",
      storageBucket: "explorer-c3f3d.firebasestorage.app",
      messagingSenderId: "491129824433",
      appId: "1:491129824433:web:15e9c96017bb3685236e90"
    ));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: const ExplorerWeb(),
    ),
  );
}

class ExplorerWeb extends StatelessWidget {
  const ExplorerWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
