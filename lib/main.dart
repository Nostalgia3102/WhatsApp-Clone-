import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:whatsapp_clone/services/auth_service.dart';
import 'package:whatsapp_clone/services/database_services.dart';
import 'package:whatsapp_clone/services/navigation_services.dart';
import 'package:whatsapp_clone/utils.dart';

final GetIt _getIt = GetIt.instance;
void  main() async{
  await setup();
  print("main --> ${_getIt.hashCode}");
  await Future.delayed(const Duration(seconds: 1));
  print('GetIt instance hash code: ${GetIt.instance.hashCode}');
  runApp(const MyApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpFireBase();
  await registerServices();
}

// Future<void> registerServices() async{
//
//   _getIt.registerSingleton<AuthService>(AuthService());
//   _getIt.registerSingleton<NavigationService>(NavigationService());
//   _getIt.registerSingleton<DatabaseServices>(DatabaseServices());
// }

class MyApp extends StatefulWidget {



  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthService _authService;
late NavigationService _navigationService;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
    _authService = _getIt.get<AuthService>();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigationService.navigatorKey,
        theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,),
        useMaterial3: true),
      initialRoute: _authService.user != null ? "/home" : "/login",
      routes: _navigationService.routes,
    );
  }
}