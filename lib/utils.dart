import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:whatsapp_clone/firebase_options.dart';
import 'package:whatsapp_clone/services/auth_service.dart';
import 'package:whatsapp_clone/services/database_services.dart';
import 'package:whatsapp_clone/services/navigation_services.dart';

final GetIt _getIt = GetIt.instance;


Future<void> setUpFireBase() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> registerServices() async {

  print("utils --> ${_getIt.hashCode}");

  _getIt.registerSingleton<AuthService>(AuthService());
  _getIt.registerSingleton<NavigationService>(NavigationService());
  _getIt.registerSingleton<DatabaseServices>(DatabaseServices());

  print("Services Registered");
}

String generateChatId({required String uid1, required String uid2}){
  List uids = [uid1, uid2];
  uids.sort();
  String chatId = uids.fold("",(id, uid) => "$id$uid");
  // String chatId = uids[0] + uids[1];
  return chatId;
}