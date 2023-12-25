import 'package:get/get.dart';

import '../../Controller/productController.dart';
import '../../common_widget/button.dart';
import '../../consts/consts.dart';
import '../../consts/list.dart';
import '../chatScreen/chat_screen.dart';

class Itemdetail extends StatelessWidget {
  const Itemdetail({super.key, required this.title, this.data});
  final String? title;
  final dynamic data;

  // int _quantity = 0;
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.resetValues();
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: whiteColor,
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
              ),
            ),
            Obx(
              () => IconButton(
                onPressed: () {
                  if (controller.isFav.value) {
                    controller.removeFromWishlist(data.id, context);
                    controller.isFav(false);
                  } else {
                    controller.addTOWishlist(data.id, context);
                    controller.isFav(true);
                  }
                },
                icon: Icon(
                  Icons.favorite_rounded,
                  color: controller.isFav.value
                      ? const Color.fromARGB(255, 243, 56, 118)
                      : darkFontGrey,
                ),
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                          autoPlay: true,
                          height: 300,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          itemCount: data['p_imgs'].length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              data["p_imgs"][index],
                              width: double.infinity,
                              fit: BoxFit.fill,
                            );
                          }),
                      10.heightBox,
                      title!.text
                          .size(16)
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data['p_rating']),
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        count: 5,
                        size: 25,
                        maxRating: 5,
                      ),
                      10.heightBox,
                      "${data['p_price']}"
                          .numCurrency
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(18)
                          .make(),
                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['p_seller']}"
                                    .text
                                    .white
                                    .fontFamily(semibold)
                                    .make(),
                                5.heightBox,
                                "In House Brands"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .size(16)
                                    .make(),
                              ],
                            ),
                          ),
                          const CircleAvatar(
                            backgroundColor: whiteColor,
                            child: Icon(
                              Icons.message_rounded,
                              color: darkFontGrey,
                            ),
                          ).onTap(() {
                            Get.to(() => const ChatScreen(), arguments: [
                              data['p_seller'],
                              data['vender_id']
                            ]);
                          })
                        ],
                      )
                          .box
                          .height(60)
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .color(textfieldGrey)
                          .make(),
                      20.heightBox,
                      Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Colors: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Row(
                                  children: List.generate(
                                    data['p_color'].length,
                                    (index) => Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        VxBox()
                                            .size(
                                              40,
                                              40,
                                            )
                                            .roundedFull
                                            .color(Color(data['p_color'][index])
                                                .withOpacity(1.0))
                                            .margin(const EdgeInsets.symmetric(
                                                horizontal: 4))
                                            .make()
                                            .onTap(() {
                                          controller.changeColorIndex(index);
                                        }),
                                        Visibility(
                                          visible: index ==
                                              controller.colorIndex.value,
                                          child: const Icon(
                                            Icons.done,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quantity: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller
                                                .decreaseQuantity(context);
                                            controller.calculateTotalPrice(
                                                int.parse(data['p_price']));
                                          },
                                          icon: const Icon(Icons.remove)),
                                      controller.quantity.value.text
                                          .size(16)
                                          .color(darkFontGrey)
                                          .fontFamily(bold)
                                          .make(),
                                      IconButton(
                                          onPressed: () {
                                            controller.increaseQuantity(
                                                int.parse(data['p_quantity']),
                                                context);
                                            controller.calculateTotalPrice(
                                                int.parse(data['p_price']));
                                          },
                                          icon: const Icon(Icons.add)),
                                      10.widthBox,
                                      "(${data['p_quantity']} Available)"
                                          .text
                                          .color(textfieldGrey)
                                          .make()
                                    ],
                                  ),
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Total: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                "${controller.totalPrice.value}"
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .size(16)
                                    .fontFamily(bold)
                                    .make(),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                          ],
                        ).box.white.shadowSm.make(),
                      ),
                      10.heightBox,
                      "Description"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,
                      "${data['p_description']} Available"
                          .text
                          .color(darkFontGrey)
                          .make(),
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          itemDetaiIButtonsList.length,
                          (index) => ListTile(
                            title: (itemDetaiIButtonsList[index])
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            trailing: const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ),
                      20.heightBox,
                      productsyomaylike.text
                          .fontFamily(bold)
                          .size(16)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            6,
                            (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  imgP1,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                                10.heightBox,
                                "laptop 4GB/256GB"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                "RS 9000"
                                    .text
                                    .size(15)
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .make()
                              ],
                            )
                                .box
                                .white
                                .margin(
                                  const EdgeInsets.symmetric(horizontal: 4),
                                )
                                .roundedSM
                                .padding(const EdgeInsets.all(8))
                                .make(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                  color: redColor,
                  onPress: () {
                    if (controller.quantity.value > 0) {
                      controller.addToCart(
                        venderID: data['vender_id'],
                        color: data['p_color'][controller.colorIndex.value],
                        context: context,
                        img: data['p_imgs'][0],
                        qtu: controller.quantity.value,
                        sellername: data['p_seller'],
                        title: data['p_name'],
                        tprice: controller.totalPrice.value,
                      );
                      VxToast.show(context,
                          msg: "Added to cart",
                          bgColor: redColor,
                          textSize: 18,
                          textColor: whiteColor,
                          position: VxToastPosition.center);
                    } else {
                      VxToast.show(context,
                          msg: "Quntity cann't be Zero",
                          bgColor: redColor,
                          textSize: 18,
                          textColor: whiteColor,
                          position: VxToastPosition.center);
                      // VxToast.show(context, msg: "Quntity cann't be Zero:");
                    }
                  },
                  textcolor: whiteColor,
                  title: "Add to cart"),
            ).box.roundedSM.padding(const EdgeInsets.all(5)).make()
          ],
        ),
      ),
    );
  }
}
