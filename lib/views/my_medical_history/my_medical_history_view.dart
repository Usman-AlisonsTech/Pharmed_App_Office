import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/models/get_medication_response_model.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/my_medical_history/my_medical_history_controller.dart';
import 'package:pharmed_app/views/my_medical_history/widgets/medical_history_container.dart';
import 'package:pharmed_app/widgets/custom_text.dart';
import 'package:pharmed_app/widgets/custom_textfield.dart';
import 'package:pharmed_app/widgets/nav_item.dart';

class MyMedicalHistoryView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MyMedicalHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final controller = Get.put(MyMedicalHistoryController());
    
    controller.currentPage.value =1;
    controller.getMedications();

    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(height: screenHeight * 0.1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState?.closeDrawer();
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                            left: screenWidth * 0.05,
                            right: screenWidth * 0.05),
                        child: Icon(
                          Icons.arrow_back,
                          size: 22,
                        ))),
              ],
            ),
            SizedBox(height: screenHeight * 0.05),
            buildDrawerItem(
              screenWidth,
              screenHeight,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: ScreenConstants.screenhorizontalPadding,
          right: ScreenConstants.screenhorizontalPadding,
          top: screenHeight * 0.06,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
              icon: SvgPicture.asset('assets/svg/side-bar.svg'),
            ),
            SizedBox(height: 10),
            CustomText(
              text: 'medical_history'.tr,
              fontSize: 30,
              weight: FontWeight.w900,
            ),
            SizedBox(height: screenHeight * 0.05),
            CustomTextField(
              controller: controller.searchController,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 15, right: 5),
                child: Icon(
                  Icons.search,
                  size: 20,
                  color: Color(0xffDADADA),
                ),
              ),
              hintText: 'search_medication'.tr,
              borderColor: Color(0xffDADADA),
              contentPadding: EdgeInsets.only(left: 10),
              hintStyle: TextStyle(
                color: Color(0xffDADADA),
                fontWeight: FontWeight.w400,
              ),
              borderRadius: 8,
              padding: 10,
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 70),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(strokeWidth: 3),
                  ),
                ));
              } else if (controller.filteredMedicationsList.isEmpty) {
                return Center(
                    child: Container(
                        margin: EdgeInsets.only(top: 40),
                        child: CustomText(text: 'No medications available')));
              } else {
                return Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollEndNotification &&
                          scrollNotification.metrics.pixels ==
                              scrollNotification.metrics.maxScrollExtent) {
                        // User has scrolled to the end
                        controller.loadMoreMedications();
                      }
                      return false;
                    },
                    child: ListView.builder(
                      itemCount: controller.filteredMedicationsList.length,
                      itemBuilder: (context, index) {
                        Datum medication =
                            controller.filteredMedicationsList[index];
                        return MedicalHistoryContainer(data: medication);
                      },
                    ),
                  ),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
