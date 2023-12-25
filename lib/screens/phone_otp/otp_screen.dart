import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../common_widget/app_logo.dart';
import '../../common_widget/bg_widget.dart';
import '../../common_widget/button.dart';
import '../../consts/consts.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var code = "";
    return bgwidget(
      child: Scaffold(
        body: Center(
            child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            appoloWidget(),
            15.heightBox,
            "Veriy Your Code".text.fontFamily(bold).white.size(18).make(),
            10.heightBox,
            Column(
              children: [
                40.heightBox,
                OtpTextField(
                  onCodeChanged: (value) {
                    code = value;
                  },
                  mainAxisAlignment: MainAxisAlignment.center,
                  fillColor: Colors.black.withOpacity(0.1),
                  filled: true,
                  borderColor: fontGrey,
                  focusedBorderColor: redColor,
                  keyboardType: TextInputType.phone,
                  numberOfFields: 6,
                ),
                40.heightBox,
                ourButton(
                  color: redColor,
                  onPress: () {},
                  textcolor: whiteColor,
                  title: "Verify OTP",
                ).box.width(context.screenWidth - 50).make(),
              ],
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 40)
                .shadowSm
                .make(),
          ],
        )),
      ),
    );
  }
}
