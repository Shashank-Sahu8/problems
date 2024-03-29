import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:project_power/Utils/comm_post.dart';
import 'package:project_power/Utils/my_texfield.dart';
import 'package:project_power/helper/helper_merthods.dart';

import '../../Chats/chat_inbox_page.dart';

class community extends StatefulWidget {
  const community({super.key});

  @override
  State<community> createState() => _communityState();
}

final postController = TextEditingController();
void postMessage() async {
  await FirebaseFirestore.instance.collection('Threads').add({
    'userEmail': FirebaseAuth.instance.currentUser!.email,
    'question': postController.text.toString(),
    'Timestamp': Timestamp.now(),
    'likes': [],
    'isBookmarked': false,
  });
}

class _communityState extends State<community> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  getConnectivity() async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    if (!isDeviceConnected && isAlertSet == false) {
      showDialogBox();
      setState(() => isAlertSet = true);
    }
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      },
    );
  }

  void initState() {
    // TODO: implement initState
    getConnectivity();
    super.initState();
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          centerTitle: false,
          title: Text(
            'Community',
            style: TextStyle(fontSize: 24, color: Colors.teal),
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ChatInboxPage()));
                },
                icon: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  child: Icon(
                    Icons.message_outlined,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: myTextField(
                      icon: Icon(Icons.arrow_downward),
                      controller: postController,
                      onTap: () {
                        postMessage();
                        postController.clear();
                      },
                      hintText: 'Add new Thread',
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Threads')
                        .orderBy('Timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final thread = snapshot.data!.docs[index];
                            return newCommunityPost(
                              message: thread['question'],
                              user: thread['userEmail'],
                              time: formatDate(thread['Timestamp']),
                              postId: thread.id,
                              likes: List<String>.from(thread['likes'] ?? []),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error'),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
