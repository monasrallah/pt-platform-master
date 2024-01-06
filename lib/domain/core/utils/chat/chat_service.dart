import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../entities/coach_entities/message_entity.dart';

class ChatService {
  // final databaseReference = FirebaseDatabase.instance.ref();

  // final FirebaseApp firebaseApp = Firebase.app();
  // final rtdb = FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL: 'https://pt-platform-686d1-default-rtdb.asia-southeast1.firebasedatabase.app/');
  // final db = FirebaseFirestore.instance;

  final databaseReference = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL:
              'https://pt-platform-686d1-default-rtdb.asia-southeast1.firebasedatabase.app/')
      .ref();

// Function to send a message
  void sendMessage(
      {required int receiverId,
      required int senderId,
      required int coachId,
      required int traineeId,
      required String text}) {
    var time = DateTime.now().millisecondsSinceEpoch;
    final chatReference =
        databaseReference.child('chat/$coachId/$traineeId/messages');

    final Map<String, Object> message = {
      'message': text,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'time': time,
    };
    //
    // db.collection("users").add(message).then((DocumentReference doc) =>
    //     print('DocumentSnapshot added with ID: ${doc.id}'));
    chatReference.push().set(message);
  }

  // Function to listen for new messages
  // Future<dynamic> listenForMessages(
  //     String coachId, String traineeId) {
  //   Completer<dynamic> completer = Completer<dynamic>();
  //
  //   MessageEntity messageEntity = MessageEntity.init();
  //   databaseReference
  //       .child('chat/$coachId/$traineeId/messages')
  //       .onChildAdded
  //       .listen((event) {
  //     // (event.snapshot.value as Map).forEach((key, value) {
  //     //   print("ghina baba");
  //     //   print('$key: $value');
  //     // });
  //     messageEntity = MessageEntity.fromJson( event.snapshot.value as Map);
  //
  //     completer.complete(messageEntity);
  //
  //     print("l2no ${messageEntity.message}");
  //     print('New Message: ${event.snapshot.value as Map}');
  //   });
  //   // messages.add(messageEntity);
  //   return completer.future;
  // }

  // Future<dynamic> listenForMessages( String coachId, String traineeId) async {
  //   Completer<dynamic> completer = Completer<dynamic>();
  //
  //   databaseReference.child('chat/$coachId/$traineeId/messages').onValue.listen((event) {
  //     // Handle the incoming data
  //     print('Receiveddd data: ${event.snapshot.value}');
  //
  //     // Resolve the completer with the received data
  //     completer.complete(event.snapshot.value);
  //   });
  //
  //   // Return the Future from the Completer
  //   return completer.future;
  // }

  Stream<DatabaseEvent> getMessages(int coachId, int traineeId) {
    print('chat/$coachId/$traineeId/messages');
    final chatReference =
        databaseReference.child('chat/$coachId/$traineeId/messages');
    return chatReference.onValue;
  }

// List<Map<String, dynamic>> getMessages(String coachId, String traineeId) {
//   List<Map<String, dynamic>> messages = [];
//   print("ghina0");
//   databaseReference
//       .child('chat/$coachId/$traineeId/messages')
//       .onChildAdded
//       .listen((DatabaseEvent event) {
//     print("ghina1");
//     if (event.snapshot.value != null) {
//       print("ghina2");
//       try {
//         Map<dynamic, dynamic> messageMap = event.snapshot.value as Map;
//
//         // Add each message to the list
//         messages.add(Map<String, dynamic>.from(messageMap));
//
//         // Sort messages by time
//         messages.sort((a, b) => a['time'].compareTo(b['time']));
//
//         // Update the UI or perform any other actions with messages
//         // setState(() {});
//       } catch (e) {
//         print('Error casting snapshot value to Map: $e');
//       }
//     }
//     print("ghina3");
//   });
//   print("ghina4");
//   return messages;
// }
}
