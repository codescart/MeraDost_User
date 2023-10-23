import 'package:sixam_mart/controller/order_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/base/footer_view.dart';
import 'package:sixam_mart/view/screens/auth/sign_in_screen.dart';

class NotLoggedInScreen extends StatelessWidget {
  final Function(bool success) callBack;
  const NotLoggedInScreen({Key? key, required this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FooterView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [

            Image.asset(
              Images.guest,
              width: MediaQuery.of(context).size.height*0.25,
              height: MediaQuery.of(context).size.height*0.25,
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.01),

            Text(
              'you_are_not_logged_in'.tr,
              style: robotoBold.copyWith(fontSize: MediaQuery.of(context).size.height*0.023),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.01),

            Text(
              'please_login_to_continue'.tr,
              style: robotoRegular.copyWith(fontSize: MediaQuery.of(context).size.height*0.0175, color: Theme.of(context).disabledColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.04),

            SizedBox(
              width: 200,
              child: CustomButton(buttonText: 'login'.tr, height: 40, onPressed: () async {

                if(!ResponsiveHelper.isDesktop(context)) {
                  await Get.toNamed(RouteHelper.getSignInRoute(Get.currentRoute));
                }else{
                  Get.dialog(const SignInScreen(exitFromApp: false, backFromThis: true)).then((value) => callBack(true));
                }
                if(Get.find<OrderController>().showBottomSheet) {
                  Get.find<OrderController>().showRunningOrders();
                }
                callBack(true);

              }),
            ),

          ]),
        ),
      ),
    );
  }
}
