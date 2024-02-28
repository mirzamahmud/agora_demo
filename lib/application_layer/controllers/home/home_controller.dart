import 'package:agora_demo/core/route/app_route.dart';
import 'package:agora_demo/domain_layer/channel/channel_model.dart';
import 'package:agora_demo/domain_layer/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController();

  bool isLoading = false;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  UserModel userModel = UserModel();
  User? user = FirebaseAuth.instance.currentUser;

  /// initial state
  initalState() async {
    isLoading = true;
    update();

    setGreetings();
    await fetchData();
    await getRoomInfo();
    await getOtherUsers();

    isLoading = false;
    update();
  }

  /// fetch data from firebase
  String username = "";
  Future<void> fetchData() async {
    DocumentSnapshot result =
        await firebaseFirestore.collection("users").doc(user!.uid).get();

    if (result.data() != null) {
      userModel = UserModel.fromMap(result.data());

      username = userModel.username ?? "";
    }
  }

  /// get all channel
  List<ChannelModel> allChannel = [];

  getRoomInfo() async {
    final result = await firebaseFirestore.collection("room").get();
    final channelData =
        result.docs.map((e) => ChannelModel.fromMap(e)).toList();

    if (channelData.isNotEmpty) {
      allChannel.addAll(channelData);
    } else {}
  }

  /// for showing greetings
  String greetings = "";
  void setGreetings() {
    int hour = DateTime.now().hour;

    if (hour < 12) {
      greetings = "Good Morning";
    } else if (hour < 15) {
      greetings = "Good Noon";
    } else if (hour < 18) {
      greetings = "Good Afternoon";
    } else if (hour < 21) {
      greetings = "Good Evening";
    } else {
      greetings = "Good Night";
    }
  }

  void createChannel(int index) async {
    Get.toNamed(AppRoute.callScreen,
        arguments: allChannel[index].channelID.toString());
    update();
  }

  List<String> tabList = ["Chat", "Call"];
  int selectedTab = 0;
  PageController pageController = PageController();

  void changeSelectedTab(int index) {
    selectedTab = index;
    pageController.jumpToPage(selectedTab);
    update();
  }

  void changePage(int pageIndex) {
    selectedTab = pageIndex;
    update();
  }

  List<UserModel> userData = [];

  getOtherUsers() async {
    final result = await firebaseFirestore.collection("users").get();
    final tempList = result.docs
        .map((e) => UserModel.fromMap(e))
        .where((element) => element.userID != user!.uid)
        .toList();

    if (tempList.isNotEmpty) {
      userData.addAll(tempList);
    }
  }
}
