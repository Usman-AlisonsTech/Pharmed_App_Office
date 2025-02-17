import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/models/signup_response_model.dart';
import 'package:pharmed_app/service/api_service.dart';
import 'package:pharmed_app/views/authentication/signup/sign_up_controller.dart';
import 'package:pharmed_app/views/personalize_experience/who_are_you/who_are_you_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupOtpController extends GetxController {
  RxBool isLoading = false.obs;
  ApiService apiService = ApiService();
  final signUpController = Get.find<SignUpController>();

  Future<void> signUpOtp(String email, String otp) async {
    isLoading.value = true;
    try {
      final response = await apiService.loginOtp(email, otp);

      if (response != null) {
        await _saveToken(
            response.data!.token,
            response.data!.userDetail!.username ?? '',
            response.data!.userDetail!.id ?? 0);
        Get.offAll(() => WhoAreYouView(
              token: response.data!.token,
              userName: response.data!.userDetail!.username,
              id: response.data!.userDetail!.id,
            ));
      } else {
        Get.snackbar("Error", "Invalid OTP. Please try again.",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {
    try {
      SignUpResponse? loginResponse = await apiService.signUp(
          signUpController.emailController.text,
          signUpController.passwordController.text,
          signUpController.phoneNumController.text,
          signUpController.passwordController.text);

      if (loginResponse != null && loginResponse.success == true) {
        Get.snackbar('Success', loginResponse.message ?? '',
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", loginResponse?.message ?? "Login failed",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error",
          "UnAuthorized User, Please Check Password or create a new account",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> _saveToken(String? token, String? userName, int? id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token != null && token.isNotEmpty) {
      await prefs.setString('loggedInToken', token);
      prefs.setString('username', userName ?? '');
      prefs.setInt('id', id ?? 0);
      print("Token saved: $token");
      print("UserName saved: $userName");
    }
  }
}
