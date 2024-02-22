import 'package:agora_demo/core/route/app_route.dart';
import 'package:agora_demo/core/utils/color/app_colors.dart';
import 'package:agora_demo/domain_layer/user/user_model.dart';
import 'package:agora_demo/presentation_layer/screens/login/inner_widgets/otp_dialog_content.dart';
import 'package:agora_demo/presentation_layer/widgets/dialog/custom_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  LoginController();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dialCodeController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  bool isSubmit = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String verificationId = "";

  Future<void> sendOtp(BuildContext context) async {
    isSubmit = true;
    update();

    await auth.verifyPhoneNumber(
        phoneNumber:
            "${dialCodeController.text.toString()}${phoneNumberController.text.toString()}",
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await auth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (FirebaseAuthException error) {
          Fluttertoast.showToast(
              msg: error.toString(),
              backgroundColor: AppColors.colorRed,
              textColor: AppColors.colorWhite,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG);
        },
        codeSent: (String verificationId, int? resendToken) async {
          this.verificationId = verificationId;

          showDialog(
              context: context,
              builder: (context) =>
                  const CustomDialog(dialogChild: OtpDialogContent()));
        },
        timeout: const Duration(seconds: 120),
        codeAutoRetrievalTimeout: (String verificationId) {});

    isSubmit = false;
    update();
  }

  addUserInfo() async {
    User? user = auth.currentUser;
    UserModel userModel = UserModel();

    if (user != null) {
      userModel.userID = user.uid;
      userModel.username = usernameController.text.trim();
      userModel.dialCode = dialCodeController.text.trim();
      userModel.phoneNumber = phoneNumberController.text.trim();

      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(userModel.toMap());

      Get.offAndToNamed(AppRoute.homeScreen);

      Fluttertoast.showToast(
          msg: "Login Successfully",
          backgroundColor: AppColors.colorGreen,
          textColor: AppColors.colorWhite,
          fontSize: 14,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } else {
      Fluttertoast.showToast(
          msg: "Authentication Failed",
          backgroundColor: AppColors.colorRed,
          textColor: AppColors.colorWhite,
          fontSize: 14,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  }

  bool isVerify = false;

  verifyOtp() async {
    isVerify = true;
    update();

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: codeController.text.toString());

      await auth.signInWithCredential(credential);
      await addUserInfo();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    isVerify = false;
    update();
  }
}
