import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController();

  bool isLoading = false;

  initalState() {
    isLoading = true;
    update();

    fetchData();

    isLoading = false;
    update();
  }

  Future<void> fetchData() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  }
}
