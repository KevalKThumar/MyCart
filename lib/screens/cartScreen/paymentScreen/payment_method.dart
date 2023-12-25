import '../../../Controller/cart_controller.dart';
import '../../../common_widget/button.dart';
import '../../../consts/consts.dart';
import '../../../consts/list.dart';
import '../../homescreen/home.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    var contorller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Choose Payment Method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: contorller.placingOrder.value
              ? const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor)),
                )
              : ourButton(
                  onPress: () async {
                    await contorller.placeMyOrder(
                        orderPaymentMethod:
                            pamentMethodString[contorller.paymentIndex.value],
                        totalAmount: contorller.totalP.value);
                    await contorller.clearCart();
                    // ignore: use_build_context_synchronously
                    VxToast.show(context, msg: "Order placed successfully");
                    Get.offAll(Home());
                  },
                  color: redColor,
                  textcolor: whiteColor,
                  title: "Place my order",
                ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              children: List.generate(
                pamentMethodImg.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      contorller.changePaymentIndex(index);
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: contorller.paymentIndex.value == index
                              ? redColor
                              : Colors.transparent,
                          width: 4,
                        ),
                      ),
                      margin: const EdgeInsets.only(
                        bottom: 8,
                      ),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.asset(
                            colorBlendMode:
                                contorller.paymentIndex.value == index
                                    ? BlendMode.darken
                                    : BlendMode.color,
                            color: contorller.paymentIndex.value == index
                                ? Colors.black.withOpacity(0.1)
                                : Colors.transparent,
                            pamentMethodImg[index],
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 5, //commet
                            right: 10,
                            child: pamentMethodString[index]
                                .text
                                .color(whiteColor)
                                .fontFamily(semibold)
                                .size(16)
                                .make(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
