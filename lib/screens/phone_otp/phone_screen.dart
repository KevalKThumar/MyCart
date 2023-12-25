import 'package:get/get.dart';

import '../../Controller/auth_contollre.dart';
import '../../common_widget/app_logo.dart';
import '../../common_widget/bg_widget.dart';
import '../../common_widget/button.dart';
import '../../common_widget/custom_textfild.dart';
import '../../consts/consts.dart';
import '../login_screen/login_screen.dart';

var phonelength = 10.obs;
var controller = Get.find<AuthController>();

class PhoneScreen extends StatelessWidget {
  const PhoneScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return bgwidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              Column(
                children: [
                  (context.screenHeight * 0.1).heightBox,
                  appoloWidget(),
                  15.heightBox,
                  "log in to $appname with OTP"
                      .text
                      .fontFamily(bold)
                      .white
                      .size(18)
                      .make(),
                  10.heightBox,
                  Column(
                    children: [
                      30.heightBox,
                      customTextFild(
                        title: phone,
                        hint: phoneHint,
                        controller: controller.phonecontroller,
                        type: TextInputType.phone,
                        ispass: false,
                      ),
                      30.heightBox,
                      ourButton(
                              color: redColor,
                              onPress: () {
                                controller.phonecontroller.text.length ==
                                        phonelength.value
                                    ? controller.loginMethodWithPhone(
                                        phoneNo:
                                            controller.phonecontroller.text)
                                    : VxToast.show(context,
                                        msg: "Enter Proper Number",
                                        bgColor: redColor,
                                        textColor: whiteColor,
                                        position: VxToastPosition.center);
                              },
                              textcolor: whiteColor,
                              title: "Send OTP")
                          .box
                          .width(context.screenWidth - 50)
                          .make(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          loginWith.text.color(fontGrey).make(),
                          TextButton(
                              onPressed: () {
                                Get.to(() => LoginScreen());
                              },
                              child: "E-mail"
                                  .text
                                  .fontFamily(semibold)
                                  .color(fontGrey)
                                  .make())
                        ],
                      ),
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .shadowSm
                      .make(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
