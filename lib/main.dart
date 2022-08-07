import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ruta_al_sur_v2/screens/tabs_screen.dart';
import 'package:ruta_al_sur_v2/utils/utils.dart';
import 'firebase_options.dart';
import 'screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: Utils.messengerKey,
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: const MainPage(),
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSwatch().copyWith(primary: Utils.lightGreen)));
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late StreamSubscription subscription;
  @override
  void initState() {
    super.initState();
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
          }
          if (snapshot.hasData) {
            return const TabsScreen();
          } else {
            return const AuthScreen();
          }
        },
      ));

  void showConnectivitySnackBar(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    final message = hasInternet ? 'En línea' : 'Sin conexión a internet';

    final color = hasInternet ? Colors.green : Colors.red;

    Utils.showSnackBar(message, color);
  }
}
