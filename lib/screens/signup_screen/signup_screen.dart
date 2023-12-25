import 'package:get/get.dart';

import '../../Controller/auth_contollre.dart';
import '../../common_widget/app_logo.dart';
import '../../common_widget/bg_widget.dart';
import '../../common_widget/button.dart';
import '../../common_widget/custom_textfild.dart';
import '../../consts/consts.dart';
import '../homescreen/home.dart';

bool _isChecked = true;
var controller = Get.put(AuthController());
var nameController = TextEditingController();
var emailController = TextEditingController();
var passwordController = TextEditingController();

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                          title: name,
                          hint: namehint,
                          controller: nameController,
                          ispass: false,
                        ),
                        customTextFild(
                          title: email,
                          hint: emailhint,
                          controller: emailController,
                          ispass: false,
                        ),
                        customTextFild(
                          title: password,
                          hint: passwordhint,
                          controller: passwordController,
                          ispass: true,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: forgetpassword.text.make(),
                          ),
                        ),
                        Row(
                          children: [
                            const CheckBox(),
                            10.widthBox,
                            Expanded(
                              child: RichText(
                                text: const TextSpan(children: [
                                  TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                      fontFamily: bold,
                                      color: fontGrey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: termsandcondition,
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: redColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: fontGrey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: privacPolicy,
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: redColor,
                                    ),
                                  )
                                ]),
                              ),
                            )
                          ],
                        ),
                        controller.isLoding.value
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor),
                              )
                            : ourButton(
                                color: redColor,
                                textcolor: whiteColor,
                                title: signup,
                                onPress: () async {
                                  controller.isLoding(true);
                                  if (_isChecked != false) {
                                    try {
                                      await controller
                                          .signupMethod(
                                              context: context,
                                              email: emailController.text,
                                              password: passwordController.text)
                                          .then((value) {
                                        return controller.storeUserData(
                                          nameController.text,
                                          passwordController.text,
                                          emailController.text,
                                        );
                                      }).then((value) {
                                        VxToast.show(context,
                                            msg: loggedin,
                                            bgColor: redColor,
                                            textColor: whiteColor);
                                        Get.offAll(() => Home());
                                        controller.isLoding(false);
                                      });
                                    } catch (e) {
                                      auth.signOut();
                                      VxToast.show(context, msg: e.toString());
                                    }
                                  }
                                },
                              ).box.width(context.screenWidth - 50).make(),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            alredyhaveaccount.text.color(fontGrey).make(),
                            login.text.color(redColor).make().onTap(
                              () {
                                Get.back();
                              },
                            ),
                          ],
                        )
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

class CheckBox extends StatefulWidget {
  const CheckBox({super.key});

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: _isChecked,
      onChanged: (bool? value) {
        setState(() {
          _isChecked = value!;
          print('$_isChecked');
        });
      },
    );
  }
}
