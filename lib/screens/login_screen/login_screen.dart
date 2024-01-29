// ignore_for_file: must_be_immutable

import '../../Controller/auth_contollre.dart';
import '../../common_widget/app_logo.dart';
import '../../common_widget/bg_widget.dart';
import '../../common_widget/button.dart';
import '../../common_widget/custom_textfild.dart';
import '../../consts/consts.dart';
import '../homescreen/home.dart';
import '../phone_otp/phone_screen.dart';
import '../signup_screen/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  var controller = Get.put(AuthController());

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return bgwidget(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                children: [
                  (context.screenHeight * 0.1).heightBox,
                  appoloWidget(),
                  15.heightBox,
                  "log in to $appname"
                      .text
                      .fontFamily(bold)
                      .white
                      .size(18)
                      .make(),
                  10.heightBox,
                  Obx(
                    () => Column(
                      children: [
                        customTextFild(
                          title: email,
                          hint: emailhint,
                          controller: controller.emailController,
                          ispass: false,
                        ),
                        customTextFild(
                          title: password,
                          hint: passwordhint,
                          controller: controller.passwordController,
                          ispass: true,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: forgetpassword.text.make(),
                          ),
                        ),
                        controller.isLoding.value
                            ? const CircularProgressIndicator(
                                color: redColor,
                              )
                            : ourButton(
                                color: redColor,
                                onPress: () async {
                                  controller.isLoding(true);
                                  await controller
                                      .loginMethod(context: context)
                                      .then(
                                    (value) {
                                      if (value != null) {
                                        VxToast.show(context,
                                            msg: loggedin.toUpperCase(),
                                            bgColor: redColor,
                                            textColor: whiteColor);
                                        Get.offAll(() => Home());
                                      } else {
                                        controller.isLoding(false);
                                      }
                                    },
                                  );
                                },
                                textcolor: whiteColor,
                                title: login,
                              ).box.width(context.screenWidth - 50).make(),
                        5.heightBox,
                        createNewAccount.text.color(fontGrey).make(),
                        5.heightBox,
                        ourButton(
                                color: lightgolden,
                                onPress: () {
                                  Get.to(
                                    () => const SignupScreen(),
                                  );
                                },
                                textcolor: whiteColor,
                                title: signup)
                            .box
                            .width(context.screenWidth - 50)
                            .make(),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            loginWith.text.color(fontGrey).make(),
                            TextButton(
                                onPressed: () {
                                  Get.to(() => const PhoneScreen());
                                },
                                child: "OTP"
                                    .text
                                    .fontFamily(semibold)
                                    .color(fontGrey)
                                    .make())
                          ],
                        ),
                        5.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => const PhoneScreen());
                                },
                                child: CircleAvatar(
                                  backgroundColor: lightGrey,
                                  radius: 25,
                                  child: Image.asset(
                                    icGoogleLogo,
                                    width: 30,
                                  ),
                                ),
                              ),
                            ),
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
                  ),
                ],
              ),
            )));
  }
}
