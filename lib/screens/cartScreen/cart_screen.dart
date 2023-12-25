import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Controller/cart_controller.dart';
import '../../common_widget/button.dart';
import '../../consts/consts.dart';
import '../../services/firestore_services.dart';
import 'shippingScreen/shipping_screen.dart';

class Cartscreen extends StatelessWidget {
  const Cartscreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          color: redColor,
          onPress: () {
            Get.to(() => ShippingDetails());
          },
          textcolor: whiteColor,
          title: "Proceed to shipping".toUpperCase(),
        ),
      ),
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping Cart"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: StreamBuilder(
          stream: FirestoreService.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Cart is empty".text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);
              controller.productSnapshot = data;
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: lightGrey,
                            ),
                            child: ListTile(
                              leading: Image.network(
                                "${data[index]['img']}",
                                width: 80,
                                fit: BoxFit.contain,
                              ),
                              title:
                                  "${data[index]['title']} (x${data[index]['qtu']}) "
                                      .text
                                      .make(),
                              subtitle: "${data[index]['tprice']}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .fontFamily(semibold)
                                  .make(),
                              trailing: IconButton(
                                onPressed: () {
                                  FirestoreService.deletDocument(
                                      data[index].id);
                                  VxToast.show(context,
                                      msg:
                                          "${data[index]['title']} Delete Successful",
                                      bgColor: redColor,
                                      textSize: 18,
                                      textColor: whiteColor,
                                      position: VxToastPosition.center);
                                },
                                icon: const Icon(Icons.remove_shopping_cart),
                                color: redColor,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total Price"
                            .toUpperCase()
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        Obx(
                          () => "${controller.totalP.value}"
                              .numCurrency
                              .text
                              .fontFamily(semibold)
                              .color(redColor)
                              .make(),
                        ),
                      ],
                    )
                        .box
                        .padding(const EdgeInsets.all(12))
                        .color(lightgolden)
                        .roundedSM
                        .make(),
                    5.heightBox,
                    // SizedBox(
                    //   width: context.screenWidth - 60,
                    //   child: ourButton(
                    //     color: redColor,
                    //     onPress: () {},
                    //     textcolor: whiteColor,
                    //     title: "Proceed to shipping".toUpperCase(),
                    //   ),
                    // )
                  ],
                ),
              );
            }
          }),
    );
  }
}
