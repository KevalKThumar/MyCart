import '../../../Controller/cart_controller.dart';
import '../../../common_widget/button.dart';
import '../../../common_widget/custom_textfild.dart';
import '../../../consts/consts.dart';
import '../paymentScreen/payment_method.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onPress: () {
            if (controller.addressController.text.length > 1
                // || controller.cityController.text.length > 2 ||
                // controller.stateController.text.length > 2 ||
                // controller.pinCodeController.text.length > 6 ||
                // controller.phoneController.text.length > 10
                ) {
              Get.to(() => PaymentMethod());
            } else {
              VxToast.show(context, msg: "Please Fill the form properly");
            }
          },
          color: redColor,
          textcolor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextFild(
              hint: "Address",
              ispass: false,
              title: "Address",
              controller: controller.addressController,
            ),
            customTextFild(
              hint: "City",
              ispass: false,
              title: "City",
              controller: controller.cityController,
            ),
            customTextFild(
              hint: "State",
              ispass: false,
              title: "State",
              controller: controller.stateController,
            ),
            customTextFild(
              hint: "Pin-Code",
              ispass: false,
              title: "Pin-Code",
              controller: controller.pinCodeController,
            ),
            customTextFild(
              hint: "Phone",
              ispass: false,
              title: "Phone",
              controller: controller.phoneController,
            ),
          ],
        ),
      ),
    );
  }
}
