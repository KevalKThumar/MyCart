import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../consts/consts.dart';
import '../consts/firebase_const.dart';
import 'Home_controller.dart';

class ChatsController extends GetxController {
  @override
  void onInit() {
    getchatId();
    // TODO: implement onInit
    super.onInit();
  }

  var chats = firestore.collection(chatsCollection);

  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];
  var senderName = Get.find<HomeController>().userName;
  var currentId = currentUser!.uid;
  var msgController = TextEditingController();
  var isLoading = false.obs;
  dynamic chatDocId;

  getchatId() async {
    isLoading(true);

    await chats
        .where('users', isEqualTo: {
          friendId: null,
          currentId: null,
        })
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocId = snapshot.docs.single.id;
          } else {
            chats.add({
              'last_msg': '',
              'users': {friendId: null, currentId: null},
              'toId': '',
              'fromId': '',
              'friend_name': friendName,
              'sender_name': senderName,
            }).then((value) {
              chatDocId = value.id;
            });
          }
        });
    isLoading(false);
  }

  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId': currentId,
      });

      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      });
    }
  }
}
