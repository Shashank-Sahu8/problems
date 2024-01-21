import 'package:cloud_firestore/cloud_firestore.dart';

class Mess {
  final String senderId;
  final String senderEmail;
  final String recieverId;
  final String message;
  final Timestamp timestamp;

  Mess(
      {required this.senderId,
      required this.senderEmail,
      required this.recieverId,
      required this.message,
      required this.timestamp});

  //convert to map
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'recieverId': recieverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
