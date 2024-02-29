import 'package:agora_demo/application_layer/controllers/message/message_controller.dart';
import 'package:agora_demo/core/utils/color/app_colors.dart';
import 'package:agora_demo/core/utils/image/app_images.dart';
import 'package:agora_demo/domain_layer/message/message.dart';
import 'package:agora_demo/presentation_layer/ui/font_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late String chatPartnerName;
  late String chatPartnerId;

  @override
  void initState() {
    chatPartnerName = Get.arguments[0];
    chatPartnerId = Get.arguments[1];
    getMessages(chatPartnerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetBuilder<MessageController>(builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.colorWhite,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Get.back(),
                iconSize: 20,
                icon:
                    const Icon(Icons.arrow_back, color: AppColors.colorBlack)),
            titleSpacing: 0,
            title: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          alignment: Alignment.center,
                          image: AssetImage(AppImages.demoProfileImage),
                          fit: BoxFit.fill)),
                ),
                const Gap(12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatPartnerName,
                      style: FontStyle.titleSmall,
                    ),
                    const Gap(4),
                    Text(
                      "Active Now",
                      style: FontStyle.bodySmall.copyWith(
                          color: AppColors.colorBlack.withOpacity(0.3)),
                    )
                  ],
                )
              ],
            ),
          ),
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.colorGreen,
                    strokeWidth: 2,
                  ),
                )
              : messageList.isEmpty
                  ? const Center(
                      child: Text("No Available Message"),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 24, vertical: 20),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: List.generate(
                            messageList.length,
                            (index) => Align(
                                  alignment: messageList[index].senderId ==
                                          FirebaseAuth.instance.currentUser?.uid
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  child: Container(
                                    margin: const EdgeInsetsDirectional.only(
                                        bottom: 12),
                                    padding:
                                        const EdgeInsetsDirectional.symmetric(
                                            vertical: 16, horizontal: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: messageList[index]
                                                    .senderId ==
                                                FirebaseAuth
                                                    .instance.currentUser?.uid
                                            ? const BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                                bottomLeft: Radius.circular(12))
                                            : const BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                                bottomRight:
                                                    Radius.circular(12)),
                                        color: messageList[index].senderId ==
                                                FirebaseAuth
                                                    .instance.currentUser?.uid
                                            ? AppColors.colorGreen
                                            : AppColors.colorGrey
                                                .withOpacity(0.2)),
                                    child: Text(
                                      messageList[index].content,
                                      style: FontStyle.bodyMedium.copyWith(
                                          color: messageList[index].senderId ==
                                                  FirebaseAuth
                                                      .instance.currentUser?.uid
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                )),
                      ),
                    ),
          bottomNavigationBar: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 12, vertical: 12),
                color: AppColors.colorWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 2,
                        child: TextField(
                          cursorColor: AppColors.colorBlack,
                          style: FontStyle.bodyMedium,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          controller: controller.messageController,
                          decoration: InputDecoration(
                              fillColor: AppColors.colorTransparent,
                              filled: true,
                              hintText: "Type message...",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        )),
                    const Gap(16),
                    IconButton(
                        alignment: Alignment.center,
                        onPressed: () {
                          sendMessge(controller.messageController.text.trim(),
                              chatPartnerId);

                          controller.messageController.text = "";
                        },
                        iconSize: 24,
                        icon:
                            const Icon(Icons.send, color: AppColors.colorGreen))
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  String getCurrentUserID() {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    return user!.uid;
  }

  String generateUniqueChatId(String currentUserID, String chatPartnerID) {
    return "${currentUserID}_$chatPartnerId";
  }

  sendMessge(String content, String receiverID) async {
    final message = Message(
      content: content,
      sentTime: DateTime.now(),
      receiverId: receiverID,
      messageType: MessageType.text,
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );
    await addMessageToChat(receiverID, message);
  }

  Future<void> addMessageToChat(
    String receiverId,
    Message message,
  ) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .add(message.toJson());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .add(message.toJson());
  }

  List<Message> messageList = [];
  bool isLoading = false;

  List<Message> getMessages(String receiverID) {
    setState(() {
      isLoading = true;
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverID)
        .collection('messages')
        .orderBy('sentTime', descending: false)
        .snapshots(includeMetadataChanges: true)
        .listen((messages) {
      messageList =
          messages.docs.map((doc) => Message.fromJson(doc.data())).toList();

      setState(() {});
    });

    setState(() {
      isLoading = false;
    });

    return messageList;
  }
}
