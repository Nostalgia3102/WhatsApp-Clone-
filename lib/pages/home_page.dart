import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:whatsapp_clone/models/user_profile.dart';
import 'package:whatsapp_clone/pages/message_page.dart';
import 'package:whatsapp_clone/services/auth_service.dart';
import 'package:whatsapp_clone/services/database_services.dart';
import 'package:whatsapp_clone/services/navigation_services.dart';
import 'package:whatsapp_clone/widgets/chat_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  late NavigationService _navigationService;
  late DatabaseServices _databaseServices;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _databaseServices = _getIt.get<DatabaseServices>();
    print("home page --> ${_getIt.hashCode}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "WhatsApp",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            const Icon(Icons.camera_alt_outlined),
            const SizedBox(width: 10),
            const Icon(Icons.more_vert),
            IconButton(
                onPressed: () async {
                  bool result = await _authService.logout();
                  if (result) {
                    _navigationService.pushReplacementNamed("/login");
                  }
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Column(
          children: [
            searchBar(),
            Expanded(child: cardView()),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: 20,
            //     itemBuilder: (context, index) {
            //       return cardView(context, index);
            //     },
            //   ),
            // )
          ],
        ));
  }

  Widget searchBar() {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(
          onChanged: (text) {},
          decoration: InputDecoration(
              hintText: "Search...",
              prefixIcon: const Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        ));
  }

  // Widget cardView(BuildContext context, int index) {
  //   return ListTile(
  //     leading: const CircleAvatar(
  //       //PlaceHolder for contact's DP
  //       child: Icon(Icons.person),
  //     ),
  //     title: Text("Name ${index + 1}"),
  //     subtitle: const Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           "Last message ...",
  //         ),
  //         SizedBox(
  //           height: 5,
  //         ),
  //         Text(
  //           "10:00 AM", // Placeholder for last message time
  //           style: TextStyle(
  //             color: Colors.grey,
  //           ),
  //         ),
  //       ],
  //     ),
  //     trailing:
  //         const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
  //       Text(
  //         "2", // Placeholder for unread message count
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       SizedBox(
  //         height: 5,
  //       ),
  //       Text(
  //         "Online", // Placeholder for online status
  //         style: TextStyle(
  //           color: Colors.green,
  //           fontSize: 12,
  //         ),
  //       ),
  //     ]),
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => MessagePage(
  //             contactName: "Name ${index + 1}",
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget cardView() {
    return StreamBuilder(
        stream: _databaseServices.getUserProfiles(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Unable to load data"),
            );
          }
          if (snapshot.hasData && snapshot.data != null) {
            final users = snapshot.data!.docs;
            print(users.length);
            return ListView.builder(
                itemCount: users.length, itemBuilder: (context, index) {
                  UserProfile user = users[index].data();
                  return ChatTile(userProfile: user, onTap: () async{
                    final chatExists = await _databaseServices.checkChatExists(_authService.user!.uid, user.uid!);
                    debugPrint("the check list is $chatExists");
                    if(!chatExists){
                      await _databaseServices.createNewChat(uid1: _authService.user!.uid, uid2: user.uid!);
                    }
                    _navigationService.push(MaterialPageRoute(builder: (context) {
                      return MessagePage(chatUser: user);
                    })
                    );
                  });
            });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
