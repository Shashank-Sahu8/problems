import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project_power/Chats/model/messages_model.dart';

class ChatService extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  //send msg

  Future<void> sendMessage(String recieverId, String message) async {
    //get cuurent user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currenUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //create a new user
    Mess newMessage = Mess(
        senderId: currentUserId,
        senderEmail: currenUserEmail,
        recieverId: recieverId,
        message: message,
        timestamp: timestamp);

    //construct chat room id for current user
    List<String> ids = [currentUserId, recieverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    //add new msg to database
    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //get messages
  Stream<QuerySnapshot> getMessages(String userId, String OtherUserId) {
    List<String> ids = [userId, OtherUserId];
    ids.sort();
    String chatroomId = ids.join('_');

    return _fireStore
        .collection('chat_rooms') // Corrected collection name
        .doc(chatroomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
