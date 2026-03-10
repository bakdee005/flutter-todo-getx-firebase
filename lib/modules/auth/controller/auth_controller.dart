import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../routes/app_pages.dart';


class AuthController extends GetxController {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordHidden = true.obs;

  void togglePassword() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  var isLoading = false.obs;

  String get userId => _auth.currentUser!.uid;
  

  /// Login with email function 
  Future login(String email, String password) async {
    try {
      isLoading(true);

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // await LocalStorage.saveLogin(); 

      emailController.clear();
      passwordController.clear();
      

      Get.offAllNamed(AppRoutes.tasks);

    } catch (e) {

      Get.snackbar(
        backgroundColor: Colors.grey,
        "Error ","Enter a valid details" );

    } finally {

      isLoading(false);
    }
  }


  /// Signup with email function 
  Future signup(String email, String password) async {
    try {

      isLoading(true);

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // await LocalStorage.saveLogin(); 

      emailController.clear();
      passwordController.clear();

      Get.offAllNamed(AppRoutes.tasks);

    } catch (e) {
      log(e.toString());

      Get.snackbar(
        backgroundColor: Colors.grey,
        "Error", e.toString());

    } finally {

      isLoading(false);
    }
  }
  


  /// Google account login function 
   Future<void> googleLogin() async {

    final GoogleSignInAccount? googleUser =
        await _googleSignIn.signIn();

    if (googleUser == null) return;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await _auth.signInWithCredential(credential);

    // await LocalStorage.saveLogin(); 

    Get.offAllNamed(AppRoutes.tasks);
  }
 
  /// Logout function
  Future logout() async {
    // await LocalStorage.logout(); 
    if(_googleSignIn.currentUser != null){
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
    }else{
      await _auth.signOut();
    }
    Get.offAllNamed(AppRoutes.login);
  }
}