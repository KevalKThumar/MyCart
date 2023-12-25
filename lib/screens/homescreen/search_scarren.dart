import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../Controller/productController.dart';
import '../../consts/consts.dart';
import '../../services/firestore_services.dart';
import '../catagoryScreen/item_detail.dart';

class SearchScarren extends StatelessWidget {
  final String? title;
  const SearchScarren({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: whiteColor),
        title: title!.text.white.make(),
      ),
      backgroundColor: whiteColor,
      body: FutureBuilder(
          future: FirestoreService.searchProduct(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(child: "No Product Found".text.make());
            } else {
              var fulldata = snapshot.data!.docs;
              var data = fulldata
                  .where(
                    (element) => element['p_name']
                        .toString()
                        .toLowerCase()
                        .contains(title!.toLowerCase()),
                  )
                  .toList();
              return Container(
                padding: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.heightBox,
                      GridView.builder(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    const EdgeInsets.symmetric(horizontal: 4),
                                  )
                                  .rounded
                                  .clip(Clip.antiAlias)
                                  .shadowSm
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
                      )
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
