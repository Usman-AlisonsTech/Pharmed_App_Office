import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/sidebar_views/terms_condition/terms_condition_controller.dart';
import 'package:pharmed_app/widgets/custom_text.dart';

class TermsConditionView extends StatelessWidget {
  TermsConditionView({Key? key}) : super(key: key);
  final TermsConditionController controller =
      Get.put(TermsConditionController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body:  SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
            left: ScreenConstants.screenhorizontalPadding,
            right: ScreenConstants.screenhorizontalPadding,
            top: screenHeight * 0.055,
          ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.arrow_back, size: 22),
                ),
                SizedBox(height: screenHeight * 0.04),
                CustomText(
                  text: 'terms_condition'.tr,
                  weight: FontWeight.w900,
                  fontSize: 30,
                ),
                const SizedBox(height: 10),
                CustomText(
                  text: 'read_terms_and_condition'.tr,
                  color: ColorConstants.themecolor,
                  weight: FontWeight.w500,
                ),
                SizedBox(height: screenHeight * 0.04),
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: const SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(strokeWidth: 3),
                        ),
                      ),
                    );
                  }
                  return HtmlWidget(
                    controller.termsHtml.value,
                    textStyle: TextStyle(fontFamily: 'Poppins'),
                  );
                }),
                SizedBox(height: screenHeight * 0.055),
              ],
            ),
          ),
        ),
    );
  }
}
