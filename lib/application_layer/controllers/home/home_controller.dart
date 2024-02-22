import 'package:agora_demo/domain_layer/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  /// get all users
  List<dynamic> userData = [];
  getOtherUsers() async {
    final result = await firebaseFirestore.collection("users").get();

    final otherUsers =
        result.docs.where((element) => element.id != user!.uid).toList();

    userData = otherUsers;
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
}
