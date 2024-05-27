import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:whatsapp_clone/models/message.dart';
import 'package:whatsapp_clone/services/database_services.dart';
import 'package:whatsapp_clone/models/chat.dart';
import 'package:whatsapp_clone/services/auth_service.dart';
import 'package:whatsapp_clone/models/user_profile.dart';
import 'dart:async';

final GetIt _getIt = GetIt.instance;
late AuthService _authService;
late DatabaseServices _databaseServices;

class MessagePage extends StatefulWidget {
  final UserProfile chatUser;

  const MessagePage({super.key, required this.chatUser});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  @override
  void initState() {
    super.initState();
    debugPrint("before auth service");
    _authService = _getIt.get<AuthService>();
    debugPrint("before database service");
    print("message --> ${_getIt.hashCode}");
    _databaseServices = _getIt.get<DatabaseServices>();
    print("message --> ${_getIt.hashCode}");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Build context started");

    String currentUserId = _authService.user!.uid;
    debugPrint("the current user is $currentUserId");
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              //PlaceHolder for contact's DP
              child: Icon(Icons.person),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(widget.chatUser.name!),
          ],
        ),
        actions: const [
          Icon(Icons.camera_alt_outlined),
          SizedBox(width: 10),
          Icon(Icons.call),
          SizedBox(width: 10),
          Icon(Icons.more_vert),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder<DocumentSnapshot<Chat>>(
              stream: _databaseServices.getChatData(currentUserId,widget.chatUser.uid!) as Stream< DocumentSnapshot<Chat>>,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('No messages found.'));
                }
                Chat chat = snapshot.data!.data()!;
                return ListView.builder(
                    itemCount: chat.messages?.length ?? 0,
                    itemBuilder: (context, index) {
                      Message message = chat.messages![index];
                      bool isMe = message.senderID == currentUserId;
                      return MessageBubble(
                        message: message.content.toString(),
                        isMe: isMe,
                      );
                    });
              },
            ),
          ),
          SendMessageBar(chatUser: widget.chatUser),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const MessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: isMe ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0)),
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            style: TextStyle(color: isMe ? Colors.white : Colors.black),
          ),
        )
      ],
    );
  }
}

class SendMessageBar extends StatefulWidget {
  final UserProfile chatUser;

  const SendMessageBar({
    super.key,
    required this.chatUser,
  });

  @override
  State<SendMessageBar> createState() => _SendMessageBarState();
}

class _SendMessageBarState extends State<SendMessageBar> {
  final messageTextEditingController = TextEditingController();

  // @override
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageTextEditingController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                _sendMessage(messageTextEditingController.text);
              },
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }

  Future<void> _sendMessage(String msg) async {
    Message message = Message(
      senderID: _authService.user!.uid,
      content: msg,
      messageType: MessageType.Text,
      sentAt: Timestamp.now(),
    );
    await _databaseServices.sendChatMessage(
        _authService.user!.uid, widget.chatUser.uid!, message);
    messageTextEditingController.clear();
  }
}
