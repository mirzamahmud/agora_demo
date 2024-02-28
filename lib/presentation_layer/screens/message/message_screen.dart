import 'package:agora_demo/application_layer/controllers/message/message_controller.dart';
import 'package:agora_demo/core/utils/color/app_colors.dart';
import 'package:agora_demo/core/utils/image/app_images.dart';
import 'package:agora_demo/presentation_layer/ui/font_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    getMessages();
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
                            (index) => Container(
                                  margin: EdgeInsetsDirectional.only(
                                      bottom: index == messageList.length - 1
                                          ? 0
                                          : 8),
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          vertical: 12, horizontal: 12),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      color: AppColors.colorGreen,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Text(
                                    messageList[index]['message'],
                                    style: FontStyle.bodyMedium
                                        .copyWith(color: Colors.white),
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
                        onPressed: () async {
                          await sendMessage(
                              controller.messageController.text.trim());

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

  Future<void> sendMessage(String messageContent) async {
    final currentUserId = getCurrentUserID();
    final partnerId = chatPartnerId;
    final chatId = generateUniqueChatId(currentUserId, partnerId);

    final firestore = FirebaseFirestore.instance;

    try {
      await firestore
          .collection("chats")
          .doc(chatId)
          .collection("messages")
          .add({
        "messageFrom": currentUserId,
        "messageTo": partnerId,
        "message": messageContent,
        "dateTime": DateTime.now()
            .toIso8601String(), // Use Timestamp for consistent representation
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: AppColors.colorRed,
          textColor: AppColors.colorWhite,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG);
    }
  }

  List<Map<String, dynamic>> messageList = [];
  bool isLoading = false;

  void getMessages() async {
    setState(() {
      isLoading = true;
    });

    final currentUserID = getCurrentUserID();
    final partnerID = chatPartnerId;
    final chatId = generateUniqueChatId(currentUserID, partnerID);

    final firestore = FirebaseFirestore.instance;

    try {
      final querySnapshot = await firestore
          .collection("chats")
          .doc(chatId)
          .collection("messages")
          .orderBy("dateTime")
          .get();

      final messages = querySnapshot.docs.map((doc) => doc.data()).toList();
      if (messages.isNotEmpty) {
        messageList.addAll(messages);
      }
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    }

    setState(() {
      isLoading = false;
    });
  }
}
