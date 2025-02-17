import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/views/authentication/login/login_view.dart';
import 'package:pharmed_app/views/sidebar_views/change_language/change_language_view.dart';
import 'package:pharmed_app/views/sidebar_views/privacy_policy/privacy_policy_view.dart';
import 'package:pharmed_app/views/sidebar_views/terms_condition/terms_condition_view.dart';
import 'package:pharmed_app/widgets/common_button.dart';
import 'package:pharmed_app/widgets/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget buildDrawerItem(double screenWidth, double screenHeight) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
    child: Column(
      children: [
        Center(
            child: CustomText(
          text: 'setting'.tr,
          weight: FontWeight.w900,
          fontSize: 30,
        )),
        SizedBox(
          height: screenHeight * 0.035,
        ),
        navItem(screenWidth, screenHeight, 'change_language'.tr,
            'assets/svg/language.svg', 'choose_preferred_lang'.tr, () {
          Get.to(ChangeLanguageView());
        }),
        navItem(screenWidth, screenHeight, 'terms_condition'.tr,
            'assets/svg/terms.svg', 'read_terms'.tr, () {
          Get.to(TermsConditionView());
        }),
        navItem(screenWidth, screenHeight, 'privacy_policy'.tr,
            'assets/svg/privacy.svg', 'read_privacy'.tr, () {
          Get.to(PrivacyPolicyView());
        }),
        SizedBox(height: 20),
        CommonButton(
          onPressed: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            await pref
                .remove('loggedInToken'); // Remove only the loggedInToken key
            Get.offAll(LoginView());
          },
          title: 'signout'.tr,
          borderColor: Color(0xffF9F9F9),
          bgColor: Color(0xffF9F9F9),
          textColor: Color(0xffFF0000),
          icon: SvgPicture.asset('assets/svg/signout.svg'),
          shadowColor: Colors.white,
        ),
      ],
    ),
  );
}

navItem(double screenWidth, double screenHeight, String text, String icon,
    String subtitle, void Function()? ontap) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      margin: EdgeInsets.only(bottom: 10),
      color: Color(0xffF9F9F9),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          SvgPicture.asset(icon),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                text: text,
                weight: FontWeight.w700,
                fontSize: screenWidth * 0.035,
              ),
              CustomText(
                text: subtitle,
                fontSize: 10,
                weight: FontWeight.w400,
              )
            ],
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_outlined,
            size: screenWidth * 0.04,
          ),
        ],
      ),
    ),
  );
}
