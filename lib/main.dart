import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

const Color explorerBlue = Color.fromARGB(255, 90, 190, 210);

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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: explorerBlue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explorer", style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.w500)),
        backgroundColor: explorerBlue,
        toolbarHeight: 80,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(child: Container(color: Colors.white)),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Welcome to Explorer",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Get Started"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
