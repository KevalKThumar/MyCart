import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../Controller/productController.dart';
import '../../common_widget/bg_widget.dart';
import '../../consts/consts.dart';
import '../../services/firestore_services.dart';
import 'item_detail.dart';

class CatagoryDetails extends StatefulWidget {
  const CatagoryDetails({super.key, required this.title});
  final String? title;

  @override
  State<CatagoryDetails> createState() => _CatagoryDetailsState();
}

class _CatagoryDetailsState extends State<CatagoryDetails> {
  var controller = Get.put(ProductController());
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productManager = FirestoreService.getSubCategory(title);
    } else {
      productManager = FirestoreService.getProduct(title);
    }
  }

  dynamic productManager;

  @override
  Widget build(BuildContext context) {
    return bgwidget(
        child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              elevation: 0,
              title: widget.title!.text.fontFamily(bold).white.make(),
            ),
            body: Column(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      controller.subcat.length,
                      (index) => "${controller.subcat[index]}"
                          .text
                          .fontFamily(semibold)
                          .size(12)
                          .color(darkFontGrey)
                          .makeCentered()
                          .box
                          .white
                          .roundedSM
                          .size(110, 50)
                          .margin(
                            const EdgeInsets.symmetric(
                              horizontal: 4,
                            ),
                          )
                          .make()
                          .onTap(() {
                        switchCategory("${controller.subcat[index]}");
                        setState(() {});
                      }),
                    ),
                  ),
                ),
                20.heightBox,
                StreamBuilder(
                    stream: productManager,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor)),
                          ),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Expanded(
                          child: Center(
                            child: "No Poducts found!"
                                .text
                                .color(darkFontGrey)
                                .make(),
                          ),
                        );
                      } else {
                        var data = snapshot.data!.docs;

                        return Expanded(
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              mainAxisExtent: 250,
                            ),
                            itemBuilder: (context, index) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        data[index]['p_imgs'][0],
                                        width: 200,
                                        height: 150,
                                        fit: BoxFit.fill,
                                      ),
                                      "${data[index]['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      "${data[index]['p_price']}"
                                          .numCurrency
                                          .text
                                          .size(15)
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .make(),
                                    ],
                                  )
                                      .box
                                      .white
                                      .margin(
                                        const EdgeInsets.symmetric(
                                            horizontal: 4),
                                      )
                                      .rounded
                                      .clip(Clip.antiAlias)
                                      .outerShadowSm
                                      .padding(const EdgeInsets.all(12))
                                      .make()
                                      .onTap(() {
                                    controller.checkIfFav(data[index]);
                                    Get.to(() => Itemdetail(
                                          title: "${data[index]['p_name']}",
                                          data: data[index],
                                        ));
                                  }),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }),
              ],
            )));
  }
}
